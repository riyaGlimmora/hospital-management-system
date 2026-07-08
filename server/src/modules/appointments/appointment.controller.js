const appointmentService = require('./appointment.service');

async function createAppointment(req, res, next) {
  try {
    const appointment = await appointmentService.createAppointment({
  ...req.body,
  createdBy: req.user.id,
});
    res.status(201).json({
      success: true,
      message: 'Appointment created successfully',
      data: appointment,
    });
  } catch (error) {
    next(error);
  }
}

async function getAppointment(req, res, next) {
  try {
    const { id } = req.params;
    const appointment = await appointmentService.getAppointment(id);
    res.status(200).json({
      success: true,
      message: 'Appointment retrieved successfully',
      data: appointment,
    });
  } catch (error) {
    next(error);
  }
}

async function updateAppointment(req, res, next) {
  try {
    const { id } = req.params;
    const appointment = await appointmentService.updateAppointment(id, req.body);
    res.status(200).json({
      success: true,
      message: 'Appointment updated successfully',
      data: appointment,
    });
  } catch (error) {
    next(error);
  }
}

async function updateAppointmentStatus(req, res, next) {
  try {
    const { id } = req.params;
    const { status } = req.body;
    const appointment = await appointmentService.updateAppointmentStatus(id, status);
    res.status(200).json({
      success: true,
      message: 'Appointment status updated successfully',
      data: appointment,
    });
  } catch (error) {
    next(error);
  }
}

async function cancelAppointment(req, res, next) {
  try {
    const { id } = req.params;
    const appointment = await appointmentService.cancelAppointment(id);
    res.status(200).json({
      success: true,
      message: 'Appointment cancelled successfully',
      data: appointment,
    });
  } catch (error) {
    next(error);
  }
}

async function listAppointments(req, res, next) {
  try {
    const pageNumber = Number(req.query.page) || 1;
    const limitNumber = Number(req.query.limit) || 10;
    const { date, doctorId, patientId, status, priority } = req.query;
    const result = await appointmentService.listAppointments({
      page: pageNumber,
      limit: limitNumber,
      date,
      doctorId,
      patientId,
      status,
      priority,
    });
    res.status(200).json({
      success: true,
      message: 'Appointments retrieved successfully',
      data: result,
    });
  } catch (error) {
    next(error);
  }
}

module.exports = {
  createAppointment,
  getAppointment,
  updateAppointment,
  updateAppointmentStatus,
  cancelAppointment,
  listAppointments,
};