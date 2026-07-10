const express = require('express');
const departmentController = require('./department.controller');
const { createDepartmentSchema } = require('./department.validation');
const validateBody = require('../../middleware/validate.middleware');
const { authenticate, authorize } = require('../../middleware/auth.middleware');

const router = express.Router();

router.get(
  '/',
  authenticate,
  authorize('admin', 'receptionist', 'doctor'),
  departmentController.listDepartments
);

router.post(
  '/',
  authenticate,
  authorize('admin'),
  validateBody(createDepartmentSchema),
  departmentController.createDepartment
);

module.exports = router;
