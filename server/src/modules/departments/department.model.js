const db = require('../../config/db');

const DEPARTMENT_COLUMNS = 'id, name, created_at, updated_at';

async function listDepartments() {
  const query = `
    SELECT ${DEPARTMENT_COLUMNS}
    FROM departments
    ORDER BY name ASC
  `;
  const { rows } = await db.query(query);
  return rows;
}

async function getDepartmentById(id) {
  const query = `
    SELECT ${DEPARTMENT_COLUMNS}
    FROM departments
    WHERE id = $1
  `;
  const { rows } = await db.query(query, [id]);
  return rows[0] ?? null;
}

async function getDepartmentByName(name) {
  const query = `
    SELECT ${DEPARTMENT_COLUMNS}
    FROM departments
    WHERE name = $1
  `;
  const { rows } = await db.query(query, [name]);
  return rows[0] ?? null;
}

async function createDepartment(name) {
  const query = `
    INSERT INTO departments (name)
    VALUES ($1)
    RETURNING ${DEPARTMENT_COLUMNS}
  `;
  const { rows } = await db.query(query, [name]);
  return rows[0] ?? null;
}

module.exports = {
  listDepartments,
  getDepartmentById,
  getDepartmentByName,
  createDepartment,
};
