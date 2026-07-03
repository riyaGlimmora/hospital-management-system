const express = require('express');
const authController = require('./auth.controller');
const { registerSchema, loginSchema } = require('./auth.validation');
const { authenticate } = require('../../middleware/auth.middleware');
const validateBody = require('../../middleware/validate.middleware');

const router = express.Router();

router.post('/register', validateBody(registerSchema), authController.register);
router.post('/login', validateBody(loginSchema), authController.login);
router.get('/me', authenticate, authController.me);

module.exports = router;