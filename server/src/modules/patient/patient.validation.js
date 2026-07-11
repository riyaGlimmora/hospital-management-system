const Joi = require('joi');

const PHONE_REGEX = /^[0-9+\-\s()]{7,20}$/;
const BLOOD_GROUPS = ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'];
const GENDERS = ['Male', 'Female', 'Other'];

const createPatientSchema = Joi.object({
  fullName: Joi.string().trim().min(2).max(150).required(),
  gender: Joi.string().valid(...GENDERS).required(),
  dateOfBirth: Joi.date().iso().max('now').required().messages({
    'date.max': 'Date of birth cannot be in the future',
  }),
  phone: Joi.string().trim().pattern(PHONE_REGEX).required().messages({
    'string.pattern.base': 'Phone must be a valid phone number',
  }),
  email: Joi.string().trim().lowercase().email({ tlds: { allow: false } }).max(255).optional().allow(null, ''),
  address: Joi.string().trim().min(5).max(500).required(),
  bloodGroup: Joi.string().valid(...BLOOD_GROUPS).optional().allow(null, ''),
  emergencyContactName: Joi.string().trim().min(2).max(150).required(),
  emergencyContactPhone: Joi.string().trim().pattern(PHONE_REGEX).required().messages({
    'string.pattern.base': 'Emergency contact phone must be a valid phone number',
  }),
  confirmDuplicate: Joi.boolean().default(false),
}).options({
  abortEarly: false,
  stripUnknown: true,
});

const updatePatientSchema = Joi.object({
  fullName: Joi.string().trim().min(2).max(150).optional(),
  gender: Joi.string().valid(...GENDERS).optional(),
  dateOfBirth: Joi.date().iso().max('now').optional().messages({
    'date.max': 'Date of birth cannot be in the future',
  }),
  phone: Joi.string().trim().pattern(PHONE_REGEX).optional().messages({
    'string.pattern.base': 'Phone must be a valid phone number',
  }),
  email: Joi.string().trim().lowercase().email({ tlds: { allow: false } }).max(255).optional().allow(null, ''),
  address: Joi.string().trim().min(5).max(500).optional(),
  bloodGroup: Joi.string().valid(...BLOOD_GROUPS).optional().allow(null, ''),
  emergencyContactName: Joi.string().trim().min(2).max(150).optional(),
  emergencyContactPhone: Joi.string().trim().pattern(PHONE_REGEX).optional().messages({
    'string.pattern.base': 'Emergency contact phone must be a valid phone number',
  }),
}).options({
  abortEarly: false,
  stripUnknown: true,
});

const listPatientsSchema = Joi.object({
  page: Joi.number().integer().min(1).default(1),
  limit: Joi.number().integer().min(1).max(100).default(10),
  search: Joi.string().trim().max(150).optional().allow(''),
  includeInactive: Joi.boolean().default(false),
}).options({
  abortEarly: false,
  stripUnknown: true,
});

module.exports = {
  createPatientSchema,
  updatePatientSchema,
  listPatientsSchema,
};