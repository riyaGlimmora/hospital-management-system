const express = require('express');
const doctorController = require('./doctor.controller');
const { createDoctorSchema, updateDoctorSchema } = require('./doctor.validation');
const validateBody = require('../../middleware/validate.middleware');
const { authenticate, authorize } = require('../../middleware/auth.middleware');

const router = express.Router();

router.post(
  '/',
  authenticate,
  authorize('admin', 'receptionist'),
  validateBody(createDoctorSchema),
  doctorController.createDoctor
);

router.get(
  '/',
  authenticate,
  authorize('admin', 'receptionist', 'doctor'),
  doctorController.listDoctors
);

router.get(
  '/search',
  authenticate,
  authorize('admin', 'receptionist', 'doctor'),
  doctorController.searchDoctors
);

router.get(
  '/:id',
  authenticate,
  authorize('admin', 'receptionist', 'doctor'),
  doctorController.getDoctor
);

router.put(
  '/:id',
  authenticate,
  authorize('admin', 'receptionist'),
  validateBody(updateDoctorSchema),
  doctorController.updateDoctor
);

router.delete(
  '/:id',
  authenticate,
  authorize('admin'),
  doctorController.deleteDoctor
);

module.exports = router;