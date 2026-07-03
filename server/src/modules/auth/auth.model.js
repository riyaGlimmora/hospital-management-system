const db = require('../../config/db');

async function createUser({ fullName, email, passwordHash, roleId }) {
  const query = `
    INSERT INTO users (full_name, email, password_hash, role_id)
    VALUES ($1, $2, $3, $4)
    RETURNING id, full_name, email, role_id, is_active, created_at
  `;
  const values = [fullName, email, passwordHash, roleId];
  const { rows } = await db.query(query, values);
  return rows[0] ?? null;
}

async function findUserByEmail(email) {
  const query = `
    SELECT
      u.id,
      u.full_name,
      u.email,
      u.password_hash,
      u.role_id,
      r.name AS role_name,
      u.is_active,
      u.failed_login_attempts,
      u.locked_until,
      u.last_login_at,
      u.created_at,
      u.updated_at
    FROM users u
    INNER JOIN roles r ON r.id = u.role_id
    WHERE u.email = $1
  `;
  const { rows } = await db.query(query, [email]);
  return rows[0] ?? null;
}

async function findUserById(id) {
  const query = `
    SELECT
      u.id,
      u.full_name,
      u.email,
      u.role_id,
      r.name AS role_name,
      u.is_active,
      u.failed_login_attempts,
      u.locked_until,
      u.last_login_at,
      u.created_at,
      u.updated_at
    FROM users u
    INNER JOIN roles r ON r.id = u.role_id
    WHERE u.id = $1
  `;
  const { rows } = await db.query(query, [id]);
  return rows[0] ?? null;
}

async function updateLastLogin(id) {
  const query = `
    UPDATE users
    SET last_login_at = NOW()
    WHERE id = $1
    RETURNING id, last_login_at
  `;
  const { rows } = await db.query(query, [id]);
  return rows[0] ?? null;
}

async function incrementFailedAttempts(id) {
  const query = `
    UPDATE users
    SET failed_login_attempts = failed_login_attempts + 1
    WHERE id = $1
    RETURNING id, failed_login_attempts
  `;
  const { rows } = await db.query(query, [id]);
  return rows[0] ?? null;
}

async function resetFailedAttempts(id) {
  const query = `
    UPDATE users
    SET failed_login_attempts = 0,
        locked_until = NULL
    WHERE id = $1
    RETURNING id, failed_login_attempts, locked_until
  `;
  const { rows } = await db.query(query, [id]);
  return rows[0] ?? null;
}

async function lockUser(id, until) {
  const query = `
    UPDATE users
    SET locked_until = $2
    WHERE id = $1
    RETURNING id, locked_until
  `;
  const { rows } = await db.query(query, [id, until]);
  return rows[0] ?? null;
}

async function getRoleByName(name) {
  const query = `
    SELECT id, name, created_at, updated_at
    FROM roles
    WHERE name = $1
  `;
  const { rows } = await db.query(query, [name]);
  return rows[0] ?? null;
}

async function deactivateUser(id) {
  const query = `
    UPDATE users
    SET is_active = FALSE
    WHERE id = $1
    RETURNING id, is_active
  `;
  const { rows } = await db.query(query, [id]);
  return rows[0] ?? null;
}

async function updatePassword(id, passwordHash) {
  const query = `
    UPDATE users
    SET password_hash = $2
    WHERE id = $1
    RETURNING id, updated_at
  `;
  const { rows } = await db.query(query, [id, passwordHash]);
  return rows[0] ?? null;
}

module.exports = {
  createUser,
  findUserByEmail,
  findUserById,
  updateLastLogin,
  incrementFailedAttempts,
  resetFailedAttempts,
  lockUser,
  getRoleByName,
  deactivateUser,
  updatePassword,
};