const departmentService = require('./department.service');

async function listDepartments(req, res, next) {
  try {
    const departments = await departmentService.listDepartments();
    res.status(200).json({
      success: true,
      message: 'Departments retrieved successfully',
      data: departments,
    });
  } catch (error) {
    next(error);
  }
}

async function createDepartment(req, res, next) {
  try {
    const department = await departmentService.createDepartment(req.body.name);
    res.status(201).json({
      success: true,
      message: 'Department created successfully',
      data: department,
    });
  } catch (error) {
    next(error);
  }
}

module.exports = {
  listDepartments,
  createDepartment,
};
