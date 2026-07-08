const Joi = require('joi');

const PHONE_REGEX = /^[0-9+\-\s()]{7,20}$/;
const GENDERS = ['Male', 'Female', 'Other'];

const createDoctorSchema = Joi.object({
  fullName: Joi.string().trim().min(2).max(150).required(),
  specialization: Joi.string().trim().min(2).max(100).required(),
  phone: Joi.string().trim().pattern(PHONE_REGEX).required().messages({
    'string.pattern.base': 'Phone must be a valid phone number',
  }),
  email: Joi.string().trim().lowercase().email().max(255).required(),
  qualification: Joi.string().trim().min(2).max(150).required(),
  experienceYears: Joi.number().integer().min(0).required(),
  consultationFee: Joi.number().min(0).required(),
  gender: Joi.string().valid(...GENDERS).required(),
}).options({
  abortEarly: false,
  stripUnknown: true,
});

const updateDoctorSchema = Joi.object({
  fullName: Joi.string().trim().min(2).max(150).optional(),
  specialization: Joi.string().trim().min(2).max(100).optional(),
  phone: Joi.string().trim().pattern(PHONE_REGEX).optional().messages({
    'string.pattern.base': 'Phone must be a valid phone number',
  }),
  email: Joi.string().trim().lowercase().email().max(255).optional(),
  qualification: Joi.string().trim().min(2).max(150).optional(),
  experienceYears: Joi.number().integer().min(0).optional(),
  consultationFee: Joi.number().min(0).optional(),
  gender: Joi.string().valid(...GENDERS).optional(),
}).options({
  abortEarly: false,
  stripUnknown: true,
});

const listDoctorsSchema = Joi.object({
  page: Joi.number().integer().min(1).default(1),
  limit: Joi.number().integer().min(1).max(100).default(10),
  search: Joi.string().trim().max(150).optional().allow(''),
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