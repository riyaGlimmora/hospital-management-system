const express = require('express');
const dashboardController = require('./dashboard.controller');
const { authenticate, authorize } = require('../../middleware/auth.middleware');

const router = express.Router();

router.get(
  '/',
  authenticate,
  authorize('admin', 'receptionist', 'doctor'),
  dashboardController.getDashboard
);

module.exports = router;