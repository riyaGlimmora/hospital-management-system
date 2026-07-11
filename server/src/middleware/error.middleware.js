const AppError = require('../utils/AppError');

function errorHandler(err, req, res, next) {
  const isDevelopment = process.env.NODE_ENV === 'development';

  if (err instanceof AppError) {
    const response = {
      success: false,
      message: err.message,
      errors: err.errors ?? null,
    };
    if (isDevelopment) {
      response.stack = err.stack;
    }
    return res.status(err.statusCode).json(response);
  }

  const response = {
    success: false,
    message: 'Internal server error',
    errors: null,
  };
  if (isDevelopment) {
    response.stack = err.stack;
  }
  return res.status(500).json(response);
}

module.exports = errorHandler;