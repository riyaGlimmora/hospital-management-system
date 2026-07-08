const express = require('express');
const billingController = require('./billing.controller');
const {
  createBillSchema,
  updateBillSchema,
  updatePaymentStatusSchema,
} = require('./billing.validation');
const validateBody = require('../../middleware/validate.middleware');
const { authenticate, authorize } = require('../../middleware/auth.middleware');

const router = express.Router();

router.post(
  '/',
  authenticate,
  authorize('admin', 'receptionist'),
  validateBody(createBillSchema),
  billingController.createBill
);

router.get(
  '/',
  authenticate,
  authorize('admin', 'receptionist', 'doctor'),
  billingController.listBills
);

router.get(
  '/:id',
  authenticate,
  authorize('admin', 'receptionist', 'doctor'),
  billingController.getBill
);

router.put(
  '/:id',
  authenticate,
  authorize('admin', 'receptionist'),
  validateBody(updateBillSchema),
  billingController.updateBill
);

router.patch(
  '/:id/payment-status',
  authenticate,
  authorize('admin', 'receptionist'),
  validateBody(updatePaymentStatusSchema),
  billingController.updatePaymentStatus
);

module.exports = router;