const Joi = require('joi');

const createDepartmentSchema = Joi.object({
  name: Joi.string().trim().min(2).max(100).required(),
}).options({
  abortEarly: false,
  stripUnknown: true,
});

module.exports = {
  createDepartmentSchema,
};
