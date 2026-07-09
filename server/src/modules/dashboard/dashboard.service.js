const dashboardModel = require('./dashboard.model');
const AppError = require('../../utils/AppError');

function toOverviewDto(row) {
  return {
    totalActivePatients: row.total_active_patients,
    totalActiveDoctors: row.total_active_doctors,
    todaysAppointments: row.todays_appointments,
    pendingBills: row.pending_bills,
    totalRevenue: Number(row.total_revenue),
  };
}

function toAppointmentStatDto(row) {
  return {
    status: row.status,
    count: row.count,
  };
}

function toBillingStatDto(row) {
  return {
    paymentStatus: row.payment_status,
    count: row.count,
  };
}

function toRecentAppointmentDto(row) {
  return {
    id: row.id,
    patientId: row.patient_id,
    doctorId: row.doctor_id,
    appointmentDate: row.appointment_date,
    startTime: row.start_time,
    durationMinutes: row.duration_minutes,
    priority: row.priority,
    status: row.status,
    notes: row.notes,
    createdBy: row.created_by,
    createdAt: row.created_at,
    updatedAt: row.updated_at,
  };
}

function toRecentBillDto(row) {
  return {
    id: row.id,
    billNumber: row.bill_number,
    appointmentId: row.appointment_id,
    patientId: row.patient_id,
    doctorId: row.doctor_id,
    totalAmount: Number(row.total_amount),
    discountAmount: Number(row.discount_amount),
    taxAmount: Number(row.tax_amount),
    finalAmount: Number(row.final_amount),
    paymentStatus: row.payment_status,
    paymentMethod: row.payment_method,
    notes: row.notes,
    createdBy: row.created_by,
    createdAt: row.created_at,
    updatedAt: row.updated_at,
  };
}

async function getDashboard() {
  const [overviewRow, appointmentStatRows, billingStatRows, recentAppointmentRows, recentBillRows] =
    await Promise.all([
      dashboardModel.getOverviewStats(),
      dashboardModel.getAppointmentStats(),
      dashboardModel.getBillingStats(),
      dashboardModel.getRecentAppointments(5),
      dashboardModel.getRecentBills(5),
    ]);

  if (!overviewRow) {
    throw new AppError('Unable to load dashboard overview', 500);
  }

  return {
    overview: toOverviewDto(overviewRow),
    appointmentStats: appointmentStatRows.map(toAppointmentStatDto),
    billingStats: billingStatRows.map(toBillingStatDto),
    recentAppointments: recentAppointmentRows.map(toRecentAppointmentDto),
    recentBills: recentBillRows.map(toRecentBillDto),
  };
}

module.exports = {
  getDashboard,
};