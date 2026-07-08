const express = require('express');
const patientController = require('./patient.controller');
const { createPatientSchema, updatePatientSchema } = require('./patient.validation');
const validateBody = require('../../middleware/validate.middleware');
const { authenticate, authorize } = require('../../middleware/auth.middleware');

const router = express.Router();

router.post(
  '/',
  authenticate,
  authorize('admin', 'receptionist'),
  validateBody(createPatientSchema),
  patientController.createPatient
);

router.get(
  '/',
  authenticate,
  authorize('admin', 'receptionist', 'doctor'),
  patientController.listPatients
);

router.get(
  '/search',
  authenticate,
  authorize('admin', 'receptionist', 'doctor'),
  patientController.searchPatients
);

router.get(
  '/:id',
  authenticate,
  authorize('admin', 'receptionist', 'doctor'),
  patientController.getPatient
);

router.put(
  '/:id',
  authenticate,
  authorize('admin', 'receptionist'),
  validateBody(updatePatientSchema),
  patientController.updatePatient
);

router.delete(
  '/:id',
  authenticate,
  authorize('admin', 'receptionist'),
  patientController.deletePatient
);

module.exports = router;