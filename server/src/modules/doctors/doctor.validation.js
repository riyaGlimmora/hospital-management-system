const Joi = require('joi');

const PHONE_REGEX = /^[0-9+\-\s()]{7,20}$/;
const TIME_REGEX = /^([01]\d|2[0-3]):[0-5]\d$/;
const GENDERS = ['Male', 'Female', 'Other'];
const CONSULT_DAYS = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

const createDoctorSchema = Joi.object({
  fullName: Joi.string().trim().min(2).max(150).required(),
  specialization: Joi.string().trim().min(2).max(100).required(),
  departmentId: Joi.number().integer().min(1).required(),
  phone: Joi.string().trim().pattern(PHONE_REGEX).required().messages({
    'string.pattern.base': 'Phone must be a valid phone number',
  }),
  email: Joi.string().trim().lowercase().email({ tlds: { allow: false } }).max(255).required(),
  qualification: Joi.string().trim().min(2).max(150).required(),
  experienceYears: Joi.number().integer().min(0).required(),
  consultationFee: Joi.number().min(0).required(),
  gender: Joi.string().valid(...GENDERS).required(),
  consultStartTime: Joi.string().pattern(TIME_REGEX).required().messages({
    'string.pattern.base': 'Consultation start time must be in HH:mm format',
  }),
  consultEndTime: Joi.string().pattern(TIME_REGEX).required().messages({
    'string.pattern.base': 'Consultation end time must be in HH:mm format',
  }),
  consultDays: Joi.array().items(Joi.string().valid(...CONSULT_DAYS)).min(1).required(),
}).options({
  abortEarly: false,
  stripUnknown: true,
});

const updateDoctorSchema = Joi.object({
  fullName: Joi.string().trim().min(2).max(150).optional(),
  specialization: Joi.string().trim().min(2).max(100).optional(),
  departmentId: Joi.number().integer().min(1).optional(),
  phone: Joi.string().trim().pattern(PHONE_REGEX).optional().messages({
    'string.pattern.base': 'Phone must be a valid phone number',
  }),
  email: Joi.string().trim().lowercase().email({ tlds: { allow: false } }).max(255).optional(),
  qualification: Joi.string().trim().min(2).max(150).optional(),
  experienceYears: Joi.number().integer().min(0).optional(),
  consultationFee: Joi.number().min(0).optional(),
  gender: Joi.string().valid(...GENDERS).optional(),
  consultStartTime: Joi.string().pattern(TIME_REGEX).optional().messages({
    'string.pattern.base': 'Consultation start time must be in HH:mm format',
  }),
  consultEndTime: Joi.string().pattern(TIME_REGEX).optional().messages({
    'string.pattern.base': 'Consultation end time must be in HH:mm format',
  }),
  consultDays: Joi.array().items(Joi.string().valid(...CONSULT_DAYS)).min(1).optional(),
}).options({
  abortEarly: false,
  stripUnknown: true,
});

const listDoctorsSchema = Joi.object({
  page: Joi.number().integer().min(1).default(1),
  limit: Joi.number().integer().min(1).max(100).default(10),
  search: Joi.string().trim().max(150).optional().allow(''),
  departmentId: Joi.number().integer().min(1).optional(),
  includeInactive: Joi.boolean().default(false),
}).options({
  abortEarly: false,
  stripUnknown: true,
});

module.exports = {
  createDoctorSchema,
  updateDoctorSchema,
  listDoctorsSchema,
};