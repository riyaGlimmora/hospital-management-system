const AppError = require('../utils/AppError');

function validateBody(schema) {
  return (req, res, next) => {
    const { error, value } = schema.validate(req.body);
    if (error) {
      const errors = error.details.map((detail) => ({
        field: detail.path.join('.'),
        message: detail.message,
      }));
      const validationError = new AppError('Validation failed', 400);
      validationError.errors = errors;
      return next(validationError);
    }
    req.body = value;
    next();
  };
}

module.exports = validateBody;