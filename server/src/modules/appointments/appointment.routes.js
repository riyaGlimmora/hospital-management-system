const express = require('express');
const appointmentController = require('./appointment.controller');
const {
  createAppointmentSchema,
  updateAppointmentSchema,
  updateAppointmentStatusSchema,
} = require('./appointment.validation');
const validateBody = require('../../middleware/validate.middleware');
const { authenticate, authorize } = require('../../middleware/auth.middleware');

const router = express.Router();

router.post(
  '/',
  authenticate,
  authorize('admin', 'receptionist'),
  validateBody(createAppointmentSchema),
  appointmentController.createAppointment
);

router.get(
  '/',
  authenticate,
  authorize('admin', 'receptionist', 'doctor'),
  appointmentController.listAppointments
);

router.get(
  '/:id',
  authenticate,
  authorize('admin', 'receptionist', 'doctor'),
  appointmentController.getAppointment
);

router.put(
  '/:id',
  authenticate,
  authorize('admin', 'receptionist'),
  validateBody(updateAppointmentSchema),
  appointmentController.updateAppointment
);

router.patch(
  '/:id/status',
  authenticate,
  authorize('admin', 'receptionist'),
  validateBody(updateAppointmentStatusSchema),
  appointmentController.updateAppointmentStatus
);

router.delete(
  '/:id',
  authenticate,
  authorize('admin', 'receptionist'),
  appointmentController.cancelAppointment
);

module.exports = router;