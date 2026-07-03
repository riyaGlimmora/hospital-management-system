const jwt = require('jsonwebtoken');
const authModel = require('../modules/auth/auth.model');
const AppError = require('../utils/AppError');

const JWT_SECRET = process.env.JWT_SECRET;

async function authenticate(req, res, next) {
  try {
    const authHeader = req.headers.authorization;

    if (!authHeader || !authHeader.startsWith('Bearer ')) {
      throw new AppError('Authentication token missing', 401);
    }

    const token = authHeader.split(' ')[1];

    if (!token) {
      throw new AppError('Authentication token missing', 401);
    }

    if (!JWT_SECRET) {
      throw new AppError('JWT_SECRET is not configured', 500);
    }

    let decoded;
    try {
      decoded = jwt.verify(token, JWT_SECRET);
    } catch (err) {
      throw new AppError('Invalid or expired token', 401);
    }

    const user = await authModel.findUserById(decoded.id);

    if (!user) {
      throw new AppError('User no longer exists', 401);
    }

    if (!user.is_active) {
      throw new AppError('This account has been deactivated', 403);
    }

    req.user = {
      id: user.id,
      fullName: user.full_name,
      email: user.email,
      role: user.role_name,
    };

    next();
  } catch (error) {
    next(error);
  }
}

function authorize(...roles) {
  return (req, res, next) => {
    if (!req.user) {
      return next(new AppError('Authentication required', 401));
    }

    if (!roles.includes(req.user.role)) {
      return next(new AppError('You do not have permission to perform this action', 403));
    }

    next();
  };
}

module.exports = {
  authenticate,
  authorize,
};