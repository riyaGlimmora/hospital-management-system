const Joi = require('joi');

const TIME_REGEX = /^([01]\d|2[0-3]):[0-5]\d$/;
const DURATIONS = [15, 30, 45, 60];
const PRIORITIES = ['normal', 'urgent', 'emergency'];
const STATUSES = ['scheduled', 'checked_in', 'completed', 'cancelled'];

function notInThePast(value, helpers) {
  const today = new Date();
  const todayDateOnly = new Date(Date.UTC(today.getUTCFullYear(), today.getUTCMonth(), today.getUTCDate()));
  if (value < todayDateOnly) {
    return helpers.error('date.pastNotAllowed');
  }
  return value;
}

const appointmentDateValidator = Joi.date().iso().custom(notInThePast).messages({
  'date.pastNotAllowed': 'Appointment date cannot be in the past',
});

const createAppointmentSchema = Joi.object({
  patientId: Joi.string().uuid().required(),
  doctorId: Joi.string().uuid().required(),
  appointmentDate: appointmentDateValidator.required(),
  startTime: Joi.string().pattern(TIME_REGEX).required().messages({
    'string.pattern.base': 'Start time must be in HH:mm format',
  }),
  durationMinutes: Joi.number().valid(...DURATIONS).default(30),
  priority: Joi.string().valid(...PRIORITIES).default('normal'),
  notes: Joi.string().trim().max(1000).optional().allow(null, ''),
}).options({
  abortEarly: false,
  stripUnknown: true,
});

const updateAppointmentSchema = Joi.object({
  appointmentDate: appointmentDateValidator.optional(),
  startTime: Joi.string().pattern(TIME_REGEX).optional().messages({
    'string.pattern.base': 'Start time must be in HH:mm format',
  }),
  durationMinutes: Joi.number().valid(...DURATIONS).optional(),
  priority: Joi.string().valid(...PRIORITIES).optional(),
  notes: Joi.string().trim().max(1000).optional().allow(null, ''),
}).options({
  abortEarly: false,
  stripUnknown: true,
});

const updateAppointmentStatusSchema = Joi.object({
  status: Joi.string().valid(...STATUSES).required(),
}).options({
  abortEarly: false,
  stripUnknown: true,
});

const listAppointmentsSchema = Joi.object({
  page: Joi.number().integer().min(1).default(1),
  limit: Joi.number().integer().min(1).max(100).default(10),
  date: Joi.date().iso().optional(),
  doctorId: Joi.string().uuid().optional(),
  patientId: Joi.string().uuid().optional(),
  status: Joi.string().valid(...STATUSES).optional(),
  priority: Joi.string().valid(...PRIORITIES).optional(),
}).options({
  abortEarly: false,
  stripUnknown: true,
});

module.exports = {
  createAppointmentSchema,
  updateAppointmentSchema,
  updateAppointmentStatusSchema,
  listAppointmentsSchema,
};