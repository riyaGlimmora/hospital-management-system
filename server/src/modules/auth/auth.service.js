const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const authModel = require('./auth.model');
const AppError = require('../../utils/AppError');

const SALT_ROUNDS = 10;
const MAX_FAILED_ATTEMPTS = 5;
const LOCK_DURATION_MS = 15 * 60 * 1000;
const JWT_SECRET = process.env.JWT_SECRET;
const JWT_EXPIRES_IN = process.env.JWT_EXPIRES_IN || '8h';

function generateToken(user) {
  if (!JWT_SECRET) {
    throw new AppError('JWT_SECRET is not configured', 500);
  }
  return jwt.sign(
    { id: user.id, email: user.email, role: user.role_name ?? user.role },
    JWT_SECRET,
    { expiresIn: JWT_EXPIRES_IN }
  );
}

function isLocked(user) {
  return Boolean(user.locked_until) && new Date(user.locked_until) > new Date();
}

async function register({ fullName, email, password, role }) {
  const normalizedEmail = email.trim().toLowerCase();

  const existingUser = await authModel.findUserByEmail(normalizedEmail);
  if (existingUser) {
    throw new AppError('A user with this email already exists', 409);
  }

  const roleRecord = await authModel.getRoleByName(role);
  if (!roleRecord) {
    throw new AppError('Requested role does not exist', 400);
  }

  const passwordHash = await bcrypt.hash(password, SALT_ROUNDS);

  const newUser = await authModel.createUser({
    fullName,
    email: normalizedEmail,
    passwordHash,
    roleId: roleRecord.id,
  });

  return {
    id: newUser.id,
    fullName: newUser.full_name,
    email: newUser.email,
    role: roleRecord.name,
    isActive: newUser.is_active,
    createdAt: newUser.created_at,
  };
}

async function login({ email, password }) {
  const normalizedEmail = email.trim().toLowerCase();

  const user = await authModel.findUserByEmail(normalizedEmail);
  if (!user) {
    throw new AppError('Invalid email or password', 401);
  }

  if (!user.is_active) {
    throw new AppError('This account has been deactivated', 403);
  }

  if (isLocked(user)) {
    throw new AppError('Account is locked due to too many failed login attempts. Try again later.', 423);
  }

  const passwordMatches = await bcrypt.compare(password, user.password_hash);
  if (!passwordMatches) {
    const updated = await authModel.incrementFailedAttempts(user.id);
    if (updated.failed_login_attempts >= MAX_FAILED_ATTEMPTS) {
      const lockUntil = new Date(Date.now() + LOCK_DURATION_MS);
      await authModel.lockUser(user.id, lockUntil);
      throw new AppError('Account locked due to too many failed login attempts. Try again in 15 minutes.', 423);
    }
    throw new AppError('Invalid email or password', 401);
  }

  await authModel.resetFailedAttempts(user.id);
  await authModel.updateLastLogin(user.id);

  const token = generateToken(user);

  return {
    token,
    user: {
      id: user.id,
      fullName: user.full_name,
      email: user.email,
      role: user.role_name,
    },
  };
}

module.exports = {
  register,
  login,
};