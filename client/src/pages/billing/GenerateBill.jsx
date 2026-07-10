import { useEffect, useState } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import { ArrowLeft, Loader2 } from 'lucide-react';
import { createBill } from '../../api/billingAPi';
import { getPatients } from '../../api/patientApi';
import { getDoctors } from '../../api/doctorApi';
import { getAppointments } from '../../api/appointmentApi';

const PAYMENT_METHODS = ['cash', 'card', 'upi', 'net_banking'];

const INITIAL_FORM = {
  appointmentId: '',
  patientId: '',
  doctorId: '',
  totalAmount: '',
  discountAmount: '0',
  taxAmount: '0',
  finalAmount: '',
  paymentMethod: '',
  notes: '',
};

function FieldError({ message }) {
  if (!message) {
    return null;
  }
  return <p className="mt-1 text-xs text-red-600">{message}</p>;
}

function formatMethodLabel(value) {
  return value
    .split('_')
    .map((word) => word.charAt(0).toUpperCase() + word.slice(1))
    .join(' ');
}

export default function GenerateBill() {
  const [form, setForm] = useState(INITIAL_FORM);
  const [patients, setPatients] = useState([]);
  const [doctors, setDoctors] = useState([]);
  const [appointments, setAppointments] = useState([]);
  const [isLoadingOptions, setIsLoadingOptions] = useState(true);
  const [fieldErrors, setFieldErrors] = useState({});
  const [errorMessage, setErrorMessage] = useState('');
  const [isSubmitting, setIsSubmitting] = useState(false);

  const navigate = useNavigate();

  useEffect(() => {
    async function loadOptions() {
      setIsLoadingOptions(true);
      try {
        const [patientsRes, doctorsRes, appointmentsRes] = await Promise.all([
          getPatients({ page: 1, limit: 100 }),
          getDoctors({ page: 1, limit: 100 }),
          getAppointments({ page: 1, limit: 100 }),
        ]);
        setPatients(patientsRes.data.data.patients);
        setDoctors(doctorsRes.data.data.doctors);
        setAppointments(appointmentsRes.data.data.appointments);
      } catch (error) {
        setErrorMessage('Unable to load appointments, patients, and doctors right now.');
      } finally {
        setIsLoadingOptions(false);
      }
    }
    loadOptions();
  }, []);

  function recalculateFinalAmount(next) {
    const total = Number(next.totalAmount) || 0;
    const discount = Number(next.discountAmount) || 0;
    const tax = Number(next.taxAmount) || 0;
    return String(Math.max(0, total - discount + tax));
  }

  function updateAmountField(field, value) {
    setForm((prev) => {
      const next = { ...prev, [field]: value };
      next.finalAmount = recalculateFinalAmount(next);
      return next;
    });
  }

  function updateField(field, value) {
    setForm((prev) => ({ ...prev, [field]: value }));
  }

  async function handleSubmit(event) {
    event.preventDefault();
    setErrorMessage('');
    setFieldErrors({});
    setIsSubmitting(true);

    try {
      const payload = {
        appointmentId: form.appointmentId,
        patientId: form.patientId,
        doctorId: form.doctorId,
        totalAmount: Number(form.totalAmount),
        discountAmount: Number(form.discountAmount) || 0,
        taxAmount: Number(form.taxAmount) || 0,
        finalAmount: Number(form.finalAmount),
        paymentMethod: form.paymentMethod === '' ? undefined : form.paymentMethod,
        notes: form.notes.trim() === '' ? undefined : form.notes.trim(),
      };
      await createBill(payload);
      navigate('/billing');
    } catch (error) {
      const backendErrors = error.response?.data?.errors;
      if (Array.isArray(backendErrors) && backendErrors.length > 0) {
        const mapped = {};
        backendErrors.forEach((item) => {
          mapped[item.field] = item.message;
        });
        setFieldErrors(mapped);
      }
      setErrorMessage(
        error.response?.data?.message ?? 'Unable to generate this bill right now.'
      );
    } finally {
      setIsSubmitting(false);
    }
  }

  return (
    <div className="mx-auto max-w-3xl space-y-6">
      <div>
        <Link
          to="/billing"
          className="inline-flex items-center gap-1.5 text-sm font-medium text-slate-500 hover:text-slate-700"
        >
          <ArrowLeft size={15} />
          Back to Billing
        </Link>
        <h1 className="mt-3 font-['Manrope',sans-serif] text-2xl font-semibold text-slate-800">
          Generate Bill
        </h1>
        <p className="mt-1 text-sm text-slate-500">
          Create a bill against a completed appointment.
        </p>
      </div>

      <form
        onSubmit={handleSubmit}
        className="space-y-6 rounded-lg border border-slate-200 bg-white p-6"
      >
        {errorMessage && (
          <div className="rounded-md border border-red-100 bg-red-50 px-4 py-3 text-sm text-red-600">
            {errorMessage}
          </div>
        )}

        <div>
          <h2 className="font-['Manrope',sans-serif] text-sm font-semibold uppercase tracking-wide text-slate-400">
            Reference Details
          </h2>
          <div className="mt-4 grid grid-cols-1 gap-5 sm:grid-cols-2">
            <div className="sm:col-span-2">
              <label htmlFor="appointmentId" className="block text-sm font-medium text-slate-700">
                Appointment
              </label>
              <select
                id="appointmentId"
                required
                disabled={isLoadingOptions}
                value={form.appointmentId}
                onChange={(event) => updateField('appointmentId', event.target.value)}
                className="mt-1.5 block w-full rounded-md border border-slate-300 bg-white px-3.5 py-2.5 text-sm text-slate-800 focus:border-[#0F6B66] focus:outline-none focus:ring-2 focus:ring-[#0F6B66]/20"
              >
                <option value="" disabled>
                  {isLoadingOptions ? 'Loading appointments…' : 'Select appointment'}
                </option>
                {appointments.map((appointment) => (
                  <option key={appointment.id} value={appointment.id}>
                    {appointment.appointmentDate} at {appointment.startTime} — {appointment.status}
                  </option>
                ))}
              </select>
              <FieldError message={fieldErrors.appointmentId} />
            </div>

            <div>
              <label htmlFor="patientId" className="block text-sm font-medium text-slate-700">
                Patient
              </label>
              <select
                id="patientId"
                required
                disabled={isLoadingOptions}
                value={form.patientId}
                onChange={(event) => updateField('patientId', event.target.value)}
                className="mt-1.5 block w-full rounded-md border border-slate-300 bg-white px-3.5 py-2.5 text-sm text-slate-800 focus:border-[#0F6B66] focus:outline-none focus:ring-2 focus:ring-[#0F6B66]/20"
              >
                <option value="" disabled>
                  {isLoadingOptions ? 'Loading patients…' : 'Select patient'}
                </option>
                {patients.map((patient) => (
                  <option key={patient.id} value={patient.id}>
                    {patient.patientId} — {patient.fullName}
                  </option>
                ))}
              </select>
              <FieldError message={fieldErrors.patientId} />
            </div>

            <div>
              <label htmlFor="doctorId" className="block text-sm font-medium text-slate-700">
                Doctor
              </label>
              <select
                id="doctorId"
                required
                disabled={isLoadingOptions}
                value={form.doctorId}
                onChange={(event) => updateField('doctorId', event.target.value)}
                className="mt-1.5 block w-full rounded-md border border-slate-300 bg-white px-3.5 py-2.5 text-sm text-slate-800 focus:border-[#0F6B66] focus:outline-none focus:ring-2 focus:ring-[#0F6B66]/20"
              >
                <option value="" disabled>
                  {isLoadingOptions ? 'Loading doctors…' : 'Select doctor'}
                </option>
                {doctors.map((doctor) => (
                  <option key={doctor.id} value={doctor.id}>
                    {doctor.doctorId} — {doctor.fullName}
                  </option>
                ))}
              </select>
              <FieldError message={fieldErrors.doctorId} />
            </div>
          </div>
        </div>

        <div>
          <h2 className="font-['Manrope',sans-serif] text-sm font-semibold uppercase tracking-wide text-slate-400">
            Amount
          </h2>
          <div className="mt-4 grid grid-cols-1 gap-5 sm:grid-cols-2">
            <div>
              <label htmlFor="totalAmount" className="block text-sm font-medium text-slate-700">
                Total Amount
              </label>
              <input
                id="totalAmount"
                type="number"
                min="0"
                step="0.01"
                required
                value={form.totalAmount}
                onChange={(event) => updateAmountField('totalAmount', event.target.value)}
                className="mt-1.5 block w-full rounded-md border border-slate-300 bg-white px-3.5 py-2.5 text-sm text-slate-800 focus:border-[#0F6B66] focus:outline-none focus:ring-2 focus:ring-[#0F6B66]/20"
              />
              <FieldError message={fieldErrors.totalAmount} />
            </div>

            <div>
              <label htmlFor="discountAmount" className="block text-sm font-medium text-slate-700">
                Discount
              </label>
              <input
                id="discountAmount"
                type="number"
                min="0"
                step="0.01"
                value={form.discountAmount}
                onChange={(event) => updateAmountField('discountAmount', event.target.value)}
                className="mt-1.5 block w-full rounded-md border border-slate-300 bg-white px-3.5 py-2.5 text-sm text-slate-800 focus:border-[#0F6B66] focus:outline-none focus:ring-2 focus:ring-[#0F6B66]/20"
              />
              <FieldError message={fieldErrors.discountAmount} />
            </div>

            <div>
              <label htmlFor="taxAmount" className="block text-sm font-medium text-slate-700">
                Tax
              </label>
              <input
                id="taxAmount"
                type="number"
                min="0"
                step="0.01"
                value={form.taxAmount}
                onChange={(event) => updateAmountField('taxAmount', event.target.value)}
                className="mt-1.5 block w-full rounded-md border border-slate-300 bg-white px-3.5 py-2.5 text-sm text-slate-800 focus:border-[#0F6B66] focus:outline-none focus:ring-2 focus:ring-[#0F6B66]/20"
              />
              <FieldError message={fieldErrors.taxAmount} />
            </div>

            <div>
              <label htmlFor="finalAmount" className="block text-sm font-medium text-slate-700">
                Final Amount
              </label>
              <input
                id="finalAmount"
                type="number"
                min="0"
                step="0.01"
                required
                value={form.finalAmount}
                onChange={(event) => updateField('finalAmount', event.target.value)}
                className="mt-1.5 block w-full rounded-md border border-slate-300 bg-white px-3.5 py-2.5 text-sm text-slate-800 focus:border-[#0F6B66] focus:outline-none focus:ring-2 focus:ring-[#0F6B66]/20"
              />
              <FieldError message={fieldErrors.finalAmount} />
            </div>

            <div>
              <label htmlFor="paymentMethod" className="block text-sm font-medium text-slate-700">
                Payment Method <span className="text-slate-400">(optional)</span>
              </label>
              <select
                id="paymentMethod"
                value={form.paymentMethod}
                onChange={(event) => updateField('paymentMethod', event.target.value)}
                className="mt-1.5 block w-full rounded-md border border-slate-300 bg-white px-3.5 py-2.5 text-sm text-slate-800 focus:border-[#0F6B66] focus:outline-none focus:ring-2 focus:ring-[#0F6B66]/20"
              >
                <option value="">Not specified</option>
                {PAYMENT_METHODS.map((method) => (
                  <option key={method} value={method}>
                    {formatMethodLabel(method)}
                  </option>
                ))}
              </select>
              <FieldError message={fieldErrors.paymentMethod} />
            </div>

            <div className="sm:col-span-2">
              <label htmlFor="notes" className="block text-sm font-medium text-slate-700">
                Notes <span className="text-slate-400">(optional)</span>
              </label>
              <textarea
                id="notes"
                rows={3}
                value={form.notes}
                onChange={(event) => updateField('notes', event.target.value)}
                className="mt-1.5 block w-full rounded-md border border-slate-300 bg-white px-3.5 py-2.5 text-sm text-slate-800 focus:border-[#0F6B66] focus:outline-none focus:ring-2 focus:ring-[#0F6B66]/20"
              />
              <FieldError message={fieldErrors.notes} />
            </div>
          </div>
        </div>

        <div className="flex items-center justify-end gap-3 border-t border-slate-100 pt-5">
          <Link
            to="/billing"
            className="rounded-md px-4 py-2.5 text-sm font-medium text-slate-500 hover:bg-slate-100 hover:text-slate-700"
          >
            Cancel
          </Link>
          <button
            type="submit"
            disabled={isSubmitting || isLoadingOptions}
            className="flex items-center justify-center gap-2 rounded-md bg-[#0F6B66] px-5 py-2.5 text-sm font-semibold text-white transition-colors hover:bg-[#0C5450] disabled:cursor-not-allowed disabled:opacity-60"
          >
            {isSubmitting && <Loader2 size={16} className="animate-spin" />}
            {isSubmitting ? 'Saving…' : 'Generate Bill'}
          </button>
        </div>
      </form>
    </div>
  );
}
