const billingService = require('./billing.service');

async function createBill(req, res, next) {
  try {
    const bill = await billingService.createBill({
      ...req.body,
      createdBy: req.user.id,
    });
    res.status(201).json({
      success: true,
      message: 'Bill created successfully',
      data: bill,
    });
  } catch (error) {
    next(error);
  }
}

async function getBill(req, res, next) {
  try {
    const { id } = req.params;
    const bill = await billingService.getBill(id);
    res.status(200).json({
      success: true,
      message: 'Bill retrieved successfully',
      data: bill,
    });
  } catch (error) {
    next(error);
  }
}

async function updateBill(req, res, next) {
  try {
    const { id } = req.params;
    const bill = await billingService.updateBill(id, req.body);
    res.status(200).json({
      success: true,
      message: 'Bill updated successfully',
      data: bill,
    });
  } catch (error) {
    next(error);
  }
}

async function updatePaymentStatus(req, res, next) {
  try {
    const { id } = req.params;
    const { paymentStatus } = req.body;
    const bill = await billingService.updatePaymentStatus(id, paymentStatus);
    res.status(200).json({
      success: true,
      message: 'Bill payment status updated successfully',
      data: bill,
    });
  } catch (error) {
    next(error);
  }
}

async function listBills(req, res, next) {
  try {
    const pageNumber = Number(req.query.page) || 1;
    const limitNumber = Number(req.query.limit) || 10;
    const { patientId, doctorId, appointmentId, paymentStatus } = req.query;
    const result = await billingService.listBills({
      page: pageNumber,
      limit: limitNumber,
      patientId,
      doctorId,
      appointmentId,
      paymentStatus,
    });
    res.status(200).json({
      success: true,
      message: 'Bills retrieved successfully',
      data: result,
    });
  } catch (error) {
    next(error);
  }
}

module.exports = {
  createBill,
  getBill,
  updateBill,
  updatePaymentStatus,
  listBills,
};