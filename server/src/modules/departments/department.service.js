const departmentModel = require('./department.model');
const AppError = require('../../utils/AppError');

function toDepartmentDto(row) {
  return {
    id: row.id,
    name: row.name,
    createdAt: row.created_at,
    updatedAt: row.updated_at,
  };
}

async function listDepartments() {
  const rows = await departmentModel.listDepartments();
  return rows.map(toDepartmentDto);
}

async function createDepartment(name) {
  const trimmedName = name.trim();
  const existing = await departmentModel.getDepartmentByName(trimmedName);
  if (existing) {
    throw new AppError('A department with this name already exists', 409);
  }
  const department = await departmentModel.createDepartment(trimmedName);
  return toDepartmentDto(department);
}

module.exports = {
  listDepartments,
  createDepartment,
};
