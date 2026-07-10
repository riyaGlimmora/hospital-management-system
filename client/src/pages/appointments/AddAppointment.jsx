import { useEffect, useState } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import { ArrowLeft, Loader2, AlertTriangle } from 'lucide-react';
import { createAppointment } from '../../api/appointment.api';
import { getPatients } from '../../api/patient.api';
import { getDoctors } from '../../api/doctor.api';

const DURATIONS = [15, 30, 45, 60];
const PRIORITIES = ['normal', 'urgent', 'emergency'];

const INITIAL_FORM = {
  patientId: '',
  doctorId: '',
  appointmentDate: '',
  startTime: '',
  durationMinutes: 30,
  priority: 'normal',
  notes: '',
};

function FieldError({ message }) {
  if (!message) {
    return null;
  }
  return <p className="mt-1 text-xs text-red-600">{message}</p>;
}

export default function AddAppointment() {
  const [form, setForm] = useState(INITIAL_FORM);
  const [patients, setPatients] = useState([]);
  const [doctors, setDoctors] = useState([]);
  const [isLoadingOptions, setIsLoadingOptions] = useState(true);
  const [fieldErrors, setFieldErrors] = useState({});
  const [errorMessage, setErrorMessage] = useState('');
  const [isConflict, setIsConflict] = useState(false);
  const [isSubmitting, setIsSubmitting] = useState(false);

  const navigate = useNavigate();

  useEffect(() => {
    async function loadOptions() {
      setIsLoadingOptions(true);
      try {
        const [patientsRes, doctorsRes] = await Promise.all([
          getPatients({ page: 1, limit: 100 }),
          getDoctors({ page: 1, limit: 100 }),
        ]);
        setPatients(patientsRes.data.data.patients);
        setDoctors(doctorsRes.data.data.doctors);
      } catch (error) {
        setErrorMessage('Unable to load patients and doctors right now.');
      } finally {
        setIsLoadingOptions(false);
      }
    }
    loadOptions();
  }, []);

  function updateField(field, value) {
    setForm((prev) => ({ ...prev, [field]: value }));
  }

  async function handleSubmit(event) {
    event.preventDefault();
    setErrorMessage('');
    setIsConflict(false);
    setFieldErrors({});
    setIsSubmitting(true);

    try {
      const payload = {
        ...form,
        durationMinutes: Number(form.durationMinutes),
        notes: form.notes.trim() === '' ? undefined : form.notes.trim(),
      };
      await createAppointment(payload);
      navigate('/appointments');
    } catch (error) {
      const status = error.response?.status;
      const backendErrors = error.response?.data?.errors;

      if (status === 409) {
        setIsConflict(true);
      }
      if (Array.isArray(backendErrors) && backendErrors.length > 0) {
        const mapped = {};
        backendErrors.forEach((item) => {
          mapped[item.field] = item.message;
        });
        setFieldErrors(mapped);
      }
      setErrorMessage(
        error.response?.data?.message ?? 'Unable to book this appointment right now.'
      );
    } finally {
      setIsSubmitting(false);
    }
  }

  return (
    <div className="mx-auto max-w-3xl space-y-6">
      <div>
        <Link
          to="/appointments"
          className="inline-flex items-center gap-1.5 text-sm font-medium text-slate-500 hover:text-slate-700"
        >
          <ArrowLeft size={15} />
          Back to Appointments
        </Link>
        <h1 className="mt-3 font-['Manrope',sans-serif] text-2xl font-semibold text-slate-800">
          New Appointment
        </h1>
        <p className="mt-1 text-sm text-slate-500">
          Book an appointment for a patient with a doctor.
        </p>
      </div>

      <form
        onSubmit={handleSubmit}
        className="space-y-6 rounded-lg border border-slate-200 bg-white p-6"
      >
        {errorMessage && (
          <div
            className={`flex items-start gap-2 rounded-md border px-4 py-3 text-sm ${
              isConflict
                ? 'border-amber-100 bg-amber-50 text-amber-700'
                : 'border-red-100 bg-red-50 text-red-600'
            }`}
          >
            {isConflict && <AlertTriangle size={16} className="mt-0.5 shrink-0" />}
            <span>{errorMessage}</span>
          </div>
        )}

        <div className="grid grid-cols-1 gap-5 sm:grid-cols-2">
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
                  {doctor.doctorId} — {doctor.fullName} ({doctor.specialization})
                </option>
              ))}
            </select>
            <FieldError message={fieldErrors.doctorId} />
          </div>

          <div>
            <label htmlFor="appointmentDate" className="block text-sm font-medium text-slate-700">
              Date
            </label>
            <input
              id="appointmentDate"
              type="date"
              required
              min={new Date().toISOString().split('T')[0]}
              value={form.appointmentDate}
              onChange={(event) => updateField('appointmentDate', event.target.value)}
              className="mt-1.5 block w-full rounded-md border border-slate-300 bg-white px-3.5 py-2.5 text-sm text-slate-800 focus:border-[#0F6B66] focus:outline-none focus:ring-2 focus:ring-[#0F6B66]/20"
            />
            <FieldError message={fieldErrors.appointmentDate} />
          </div>

          <div>
            <label htmlFor="startTime" className="block text-sm font-medium text-slate-700">
              Start Time
            </label>
            <input
              id="startTime"
              type="time"
              required
              value={form.startTime}
              onChange={(event) => updateField('startTime', event.target.value)}
              className="mt-1.5 block w-full rounded-md border border-slate-300 bg-white px-3.5 py-2.5 text-sm text-slate-800 focus:border-[#0F6B66] focus:outline-none focus:ring-2 focus:ring-[#0F6B66]/20"
            />
            <FieldError message={fieldErrors.startTime} />
          </div>

          <div>
            <label htmlFor="durationMinutes" className="block text-sm font-medium text-slate-700">
              Duration
            </label>
            <select
              id="durationMinutes"
              required
              value={form.durationMinutes}
              onChange={(event) => updateField('durationMinutes', event.target.value)}
              className="mt-1.5 block w-full rounded-md border border-slate-300 bg-white px-3.5 py-2.5 text-sm text-slate-800 focus:border-[#0F6B66] focus:outline-none focus:ring-2 focus:ring-[#0F6B66]/20"
            >
              {DURATIONS.map((duration) => (
                <option key={duration} value={duration}>
                  {duration} minutes
                </option>
              ))}
            </select>
            <FieldError message={fieldErrors.durationMinutes} />
          </div>

          <div>
            <label htmlFor="priority" className="block text-sm font-medium text-slate-700">
              Priority
            </label>
            <select
              id="priority"
              required
              value={form.priority}
              onChange={(event) => updateField('priority', event.target.value)}
              className="mt-1.5 block w-full rounded-md border border-slate-300 bg-white px-3.5 py-2.5 text-sm text-slate-800 focus:border-[#0F6B66] focus:outline-none focus:ring-2 focus:ring-[#0F6B66]/20"
            >
              {PRIORITIES.map((priority) => (
                <option key={priority} value={priority}>
                  {priority.charAt(0).toUpperCase() + priority.slice(1)}
                </option>
              ))}
            </select>
            <FieldError message={fieldErrors.priority} />
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

        <div className="flex items-center justify-end gap-3 border-t border-slate-100 pt-5">
          <Link
            to="/appointments"
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
            {isSubmitting ? 'Booking…' : 'Book Appointment'}
          </button>
        </div>
      </form>
    </div>
  );
}
