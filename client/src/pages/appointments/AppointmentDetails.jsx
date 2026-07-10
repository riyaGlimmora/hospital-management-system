import { useCallback, useEffect, useState } from 'react';
import { Link, useParams } from 'react-router-dom';
import {
  ArrowLeft,
  AlertCircle,
  RefreshCw,
  Loader2,
  Check,
  X,
  Receipt,
  UserRound,
  Stethoscope,
} from 'lucide-react';
import { getAppointmentById, updateAppointmentStatus, cancelAppointment } from '../../api/appointmentApi';
import { getPatientById } from '../../api/patientApi';
import { getDoctorById } from '../../api/doctorApi';

const STATUS_STYLES = {
  scheduled: 'bg-amber-50 text-amber-700 border-amber-100',
  checked_in: 'bg-blue-50 text-blue-700 border-blue-100',
  completed: 'bg-emerald-50 text-emerald-700 border-emerald-100',
  cancelled: 'bg-red-50 text-red-700 border-red-100',
};

const STATUS_FLOW = {
  scheduled: { next: 'checked_in', label: 'Check In' },
  checked_in: { next: 'completed', label: 'Mark Completed' },
};

function formatLabel(value) {
  if (!value) {
    return '—';
  }
  return value
    .split('_')
    .map((word) => word.charAt(0).toUpperCase() + word.slice(1))
    .join(' ');
}

function StatusBadge({ value }) {
  const style = STATUS_STYLES[value] ?? 'bg-slate-50 text-slate-600 border-slate-200';
  return (
    <span className={`inline-flex items-center rounded-full border px-2.5 py-0.5 text-xs font-medium ${style}`}>
      {formatLabel(value)}
    </span>
  );
}

function InfoField({ label, value }) {
  return (
    <div>
      <p className="text-xs font-medium uppercase tracking-wide text-slate-400">{label}</p>
      <p className="mt-1 text-sm text-slate-800">{value ?? '—'}</p>
    </div>
  );
}

function SectionCard({ title, icon: Icon, children }) {
  return (
    <div className="rounded-lg border border-slate-200 bg-white">
      <div className="flex items-center gap-2 border-b border-slate-100 px-5 py-4">
        {Icon && <Icon size={16} className="text-slate-400" />}
        <h2 className="font-['Manrope',sans-serif] text-base font-semibold text-slate-800">
          {title}
        </h2>
      </div>
      <div className="grid grid-cols-1 gap-5 p-5 sm:grid-cols-2">{children}</div>
    </div>
  );
}

function formatDate(value) {
  if (!value) {
    return '—';
  }
  return new Date(value).toLocaleDateString('en-IN', {
    year: 'numeric',
    month: 'long',
    day: 'numeric',
  });
}

function formatTime(value) {
  if (!value) {
    return '—';
  }
  const [hours, minutes] = value.split(':');
  const date = new Date();
  date.setHours(Number(hours), Number(minutes));
  return date.toLocaleTimeString('en-IN', { hour: 'numeric', minute: '2-digit' });
}

function formatDateTime(value) {
  if (!value) {
    return '—';
  }
  return new Date(value).toLocaleString('en-IN', {
    year: 'numeric',
    month: 'short',
    day: 'numeric',
    hour: '2-digit',
    minute: '2-digit',
  });
}

function DetailsSkeleton() {
  return (
    <div className="mx-auto max-w-3xl space-y-6">
      <div className="h-6 w-32 animate-pulse rounded bg-slate-200" />
      <div className="rounded-lg border border-slate-200 bg-white p-6">
        <div className="h-6 w-48 animate-pulse rounded bg-slate-200" />
        <div className="mt-3 h-4 w-32 animate-pulse rounded bg-slate-200" />
      </div>
      {Array.from({ length: 3 }).map((_, index) => (
        <div key={index} className="rounded-lg border border-slate-200 bg-white p-5">
          <div className="grid grid-cols-1 gap-5 sm:grid-cols-2">
            <div className="h-10 animate-pulse rounded bg-slate-200" />
            <div className="h-10 animate-pulse rounded bg-slate-200" />
          </div>
        </div>
      ))}
    </div>
  );
}

export default function AppointmentDetails() {
  const { id } = useParams();

  const [appointment, setAppointment] = useState(null);
  const [patient, setPatient] = useState(null);
  const [doctor, setDoctor] = useState(null);
  const [isLoading, setIsLoading] = useState(true);
  const [loadError, setLoadError] = useState('');
  const [actionError, setActionError] = useState('');
  const [isConfirmingCancel, setIsConfirmingCancel] = useState(false);
  const [isUpdating, setIsUpdating] = useState(false);

  const fetchAppointment = useCallback(async () => {
    setIsLoading(true);
    setLoadError('');
    try {
      const response = await getAppointmentById(id);
      const data = response.data.data;
      setAppointment(data);

      const [patientRes, doctorRes] = await Promise.allSettled([
        getPatientById(data.patientId),
        getDoctorById(data.doctorId),
      ]);
      if (patientRes.status === 'fulfilled') {
        setPatient(patientRes.value.data.data);
      }
      if (doctorRes.status === 'fulfilled') {
        setDoctor(doctorRes.value.data.data);
      }
    } catch (error) {
      setLoadError(
        error.response?.data?.message ?? 'Unable to load this appointment right now.'
      );
    } finally {
      setIsLoading(false);
    }
  }, [id]);

  useEffect(() => {
    fetchAppointment();
  }, [fetchAppointment]);

  async function handleAdvanceStatus(nextStatus) {
    setActionError('');
    setIsUpdating(true);
    try {
      await updateAppointmentStatus(id, nextStatus);
      await fetchAppointment();
    } catch (error) {
      setActionError(
        error.response?.data?.message ?? 'Unable to update this appointment right now.'
      );
    } finally {
      setIsUpdating(false);
    }
  }

  async function handleCancel() {
    setActionError('');
    setIsUpdating(true);
    try {
      await cancelAppointment(id);
      await fetchAppointment();
      setIsConfirmingCancel(false);
    } catch (error) {
      setActionError(
        error.response?.data?.message ?? 'Unable to cancel this appointment right now.'
      );
      setIsConfirmingCancel(false);
    } finally {
      setIsUpdating(false);
    }
  }

  if (isLoading) {
    return <DetailsSkeleton />;
  }

  if (loadError) {
    return (
      <div className="flex min-h-[60vh] flex-col items-center justify-center rounded-lg border border-red-100 bg-red-50/40 text-center">
        <AlertCircle className="text-red-500" size={32} />
        <p className="mt-3 font-['Manrope',sans-serif] text-base font-semibold text-slate-800">
          Couldn&apos;t load this appointment
        </p>
        <p className="mt-1 max-w-sm text-sm text-slate-500">{loadError}</p>
        <button
          type="button"
          onClick={fetchAppointment}
          className="mt-5 inline-flex items-center gap-2 rounded-md bg-[#0F6B66] px-4 py-2 text-sm font-semibold text-white hover:bg-[#0C5450]"
        >
          <RefreshCw size={15} />
          Retry
        </button>
      </div>
    );
  }

  const nextStep = STATUS_FLOW[appointment.status];
  const canCancel = appointment.status !== 'cancelled' && appointment.status !== 'completed';

  return (
    <div className="mx-auto max-w-3xl space-y-6">
      <Link
        to="/appointments"
        className="inline-flex items-center gap-1.5 text-sm font-medium text-slate-500 hover:text-slate-700"
      >
        <ArrowLeft size={15} />
        Back to Appointments
      </Link>

      <div className="rounded-lg border border-slate-200 bg-white p-6">
        <div className="flex flex-col justify-between gap-4 sm:flex-row sm:items-start">
          <div>
            <div className="flex items-center gap-3">
              <h1 className="font-['Manrope',sans-serif] text-2xl font-semibold text-slate-800">
                {formatDate(appointment.appointmentDate)}
              </h1>
              <StatusBadge value={appointment.status} />
            </div>
            <p className="mt-1 text-sm text-slate-500">
              {formatTime(appointment.startTime)} &middot; {appointment.durationMinutes} min &middot;{' '}
              <span className="capitalize">{appointment.priority} priority</span>
            </p>
          </div>

          {isConfirmingCancel ? (
            <div className="flex items-center gap-2">
              <span className="text-sm text-slate-500">Cancel this appointment?</span>
              <button
                type="button"
                onClick={handleCancel}
                disabled={isUpdating}
                className="flex items-center gap-1.5 rounded-md bg-red-600 px-3 py-2 text-sm font-medium text-white hover:bg-red-700 disabled:opacity-60"
              >
                {isUpdating ? <Loader2 size={15} className="animate-spin" /> : <Check size={15} />}
                Confirm
              </button>
              <button
                type="button"
                onClick={() => setIsConfirmingCancel(false)}
                disabled={isUpdating}
                className="flex items-center gap-1.5 rounded-md border border-slate-200 px-3 py-2 text-sm font-medium text-slate-500 hover:bg-slate-50"
              >
                <X size={15} />
                Keep it
              </button>
            </div>
          ) : (
            <div className="flex flex-wrap items-center gap-2">
              {appointment.status === 'completed' && (
                <Link
                  to="/billing/new"
                  className="flex items-center gap-1.5 rounded-md border border-slate-200 px-3 py-2 text-sm font-medium text-slate-600 hover:bg-slate-50"
                >
                  <Receipt size={15} />
                  Generate Bill
                </Link>
              )}
              {nextStep && (
                <button
                  type="button"
                  onClick={() => handleAdvanceStatus(nextStep.next)}
                  disabled={isUpdating}
                  className="flex items-center gap-1.5 rounded-md bg-[#0F6B66] px-3 py-2 text-sm font-medium text-white hover:bg-[#0C5450] disabled:opacity-60"
                >
                  {isUpdating ? <Loader2 size={15} className="animate-spin" /> : <Check size={15} />}
                  {nextStep.label}
                </button>
              )}
              {canCancel && (
                <button
                  type="button"
                  onClick={() => setIsConfirmingCancel(true)}
                  className="flex items-center gap-1.5 rounded-md border border-red-100 px-3 py-2 text-sm font-medium text-red-600 hover:bg-red-50"
                >
                  <X size={15} />
                  Cancel
                </button>
              )}
            </div>
          )}
        </div>

        {actionError && (
          <div className="mt-4 rounded-md border border-red-100 bg-red-50 px-4 py-3 text-sm text-red-600">
            {actionError}
          </div>
        )}
      </div>

      <SectionCard title="Patient" icon={UserRound}>
        {patient ? (
          <>
            <InfoField label="Name" value={patient.fullName} />
            <InfoField label="Patient ID" value={patient.patientId} />
            <InfoField label="Phone" value={patient.phone} />
            <InfoField label="Gender" value={patient.gender} />
          </>
        ) : (
          <div className="sm:col-span-2">
            <Link
              to={`/patients/${appointment.patientId}`}
              className="text-sm font-medium text-[#0F6B66] hover:underline"
            >
              View patient record
            </Link>
          </div>
        )}
      </SectionCard>

      <SectionCard title="Doctor" icon={Stethoscope}>
        {doctor ? (
          <>
            <InfoField label="Name" value={doctor.fullName} />
            <InfoField label="Doctor ID" value={doctor.doctorId} />
            <InfoField label="Specialization" value={doctor.specialization} />
            <InfoField label="Consultation Fee" value={doctor.consultationFee ? `₹${doctor.consultationFee}` : '—'} />
          </>
        ) : (
          <div className="sm:col-span-2">
            <Link
              to={`/doctors/${appointment.doctorId}`}
              className="text-sm font-medium text-[#0F6B66] hover:underline"
            >
              View doctor record
            </Link>
          </div>
        )}
      </SectionCard>

      <SectionCard title="Notes">
        <div className="sm:col-span-2">
          <p className="text-sm text-slate-700">{appointment.notes || 'No notes were added for this appointment.'}</p>
        </div>
      </SectionCard>

      <SectionCard title="Record Information">
        <InfoField label="Booked On" value={formatDateTime(appointment.createdAt)} />
        <InfoField label="Last Updated" value={formatDateTime(appointment.updatedAt)} />
      </SectionCard>
    </div>
  );
}
