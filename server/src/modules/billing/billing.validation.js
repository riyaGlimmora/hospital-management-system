const Joi = require('joi');

const PAYMENT_METHODS = ['cash', 'card', 'upi', 'net_banking'];
const PAYMENT_STATUSES = ['pending', 'paid', 'partially_paid', 'cancelled'];

const createBillSchema = Joi.object({
  appointmentId: Joi.string().uuid().required(),
  patientId: Joi.string().uuid().required(),
  doctorId: Joi.string().uuid().required(),
  totalAmount: Joi.number().min(0).required(),
  discountAmount: Joi.number().min(0).default(0),
  taxAmount: Joi.number().min(0).default(0),
  finalAmount: Joi.number().min(0).required(),
  paymentMethod: Joi.string().valid(...PAYMENT_METHODS).allow(null).optional(),
  notes: Joi.string().trim().max(1000).optional().allow(null, ''),
}).options({
  abortEarly: false,
  stripUnknown: true,
});

const updateBillSchema = Joi.object({
  totalAmount: Joi.number().min(0).optional(),
  discountAmount: Joi.number().min(0).optional(),
  taxAmount: Joi.number().min(0).optional(),
  finalAmount: Joi.number().min(0).optional(),
  paymentMethod: Joi.string().valid(...PAYMENT_METHODS).allow(null).optional(),
  notes: Joi.string().trim().max(1000).optional().allow(null, ''),
}).options({
  abortEarly: false,
  stripUnknown: true,
});

const updatePaymentStatusSchema = Joi.object({
  paymentStatus: Joi.string().valid(...PAYMENT_STATUSES).required(),
}).options({
  abortEarly: false,
  stripUnknown: true,
});

const listBillsSchema = Joi.object({
  page: Joi.number().integer().min(1).default(1),
  limit: Joi.number().integer().min(1).max(100).default(10),
  patientId: Joi.string().uuid().optional(),
  doctorId: Joi.string().uuid().optional(),
  appointmentId: Joi.string().uuid().optional(),
  paymentStatus: Joi.string().valid(...PAYMENT_STATUSES).optional(),
}).options({
  abortEarly: false,
  stripUnknown: true,
});

module.exports = {
  createBillSchema,
  updateBillSchema,
  updatePaymentStatusSchema,
  listBillsSchema,
};