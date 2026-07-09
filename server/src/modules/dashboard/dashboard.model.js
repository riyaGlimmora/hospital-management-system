const db = require('../../config/db');

async function getOverviewStats() {
  const query = `
    SELECT
      (SELECT COUNT(*)::INT FROM patients WHERE is_active = TRUE) AS total_active_patients,
      (SELECT COUNT(*)::INT FROM doctors WHERE is_active = TRUE) AS total_active_doctors,
      (SELECT COUNT(*)::INT FROM appointments WHERE appointment_date = CURRENT_DATE) AS todays_appointments,
      (SELECT COUNT(*)::INT FROM billing WHERE payment_status = 'pending') AS pending_bills,
      (SELECT COALESCE(SUM(final_amount), 0) FROM billing WHERE payment_status = 'paid') AS total_revenue
  `;
  const { rows } = await db.query(query);
  return rows[0] ?? null;
}

async function getAppointmentStats() {
  const query = `
    SELECT status, COUNT(*)::INT AS count
    FROM appointments
    GROUP BY status
  `;
  const { rows } = await db.query(query);
  return rows;
}

async function getBillingStats() {
  const query = `
    SELECT payment_status, COUNT(*)::INT AS count
    FROM billing
    GROUP BY payment_status
  `;
  const { rows } = await db.query(query);
  return rows;
}

async function getRecentAppointments(limit = 5) {
  const query = `
    SELECT
      id, patient_id, doctor_id, appointment_date, start_time, duration_minutes,
      priority, status, notes, created_by, created_at, updated_at
    FROM appointments
    ORDER BY created_at DESC
    LIMIT $1
  `;
  const { rows } = await db.query(query, [limit]);
  return rows;
}

async function getRecentBills(limit = 5) {
  const query = `
    SELECT
      id, bill_number, appointment_id, patient_id, doctor_id,
      total_amount, discount_amount, tax_amount, final_amount,
      payment_status, payment_method, notes, created_by, created_at, updated_at
    FROM billing
    ORDER BY created_at DESC
    LIMIT $1
  `;
  const { rows } = await db.query(query, [limit]);
  return rows;
}

module.exports = {
  getOverviewStats,
  getAppointmentStats,
  getBillingStats,
  getRecentAppointments,
  getRecentBills,
};