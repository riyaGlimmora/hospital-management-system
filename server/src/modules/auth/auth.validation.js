const Joi = require('joi');

const PASSWORD_REGEX = new RegExp('^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[!@#$%^&*()_+\\-=[\\]{};\':"\\\\|,.<>/?]).{8,64}$');

const registerSchema = Joi.object({
  fullName: Joi.string().trim().min(2).max(150).required(),
  email: Joi.string().trim().lowercase().email().max(255).required(),
  password: Joi.string().pattern(PASSWORD_REGEX).required().messages({
    'string.pattern.base':
      'Password must be 8-64 characters and include at least one uppercase letter, one lowercase letter, one number, and one special character.',
  }),
  role: Joi.string().valid('admin', 'receptionist', 'doctor').required(),
}).options({
  abortEarly: false,
  stripUnknown: true,
});

const loginSchema = Joi.object({
  email: Joi.string().trim().lowercase().email().max(255).required(),
  password: Joi.string().min(1).max(128).required(),
}).options({
  abortEarly: false,
  stripUnknown: true,
});

module.exports = {
  registerSchema,
  loginSchema,
};