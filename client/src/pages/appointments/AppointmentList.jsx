import { useCallback, useEffect, useState } from 'react';
import { Link } from 'react-router-dom';
import {
  Plus,
  AlertCircle,
  RefreshCw,
  CalendarDays,
  ChevronLeft,
  ChevronRight,
  X,
} from 'lucide-react';
import { getAppointments, cancelAppointment } from '../../api/appointmentApi';
import { getPatients } from '../../api/patientApi';
import { getDoctors } from '../../api/doctorApi';

const PAGE_SIZE = 10;

const STATUS_OPTIONS = ['scheduled', 'checked_in', 'completed', 'cancelled'];

const STATUS_STYLES = {
  scheduled: 'bg-amber-50 text-amber-700 border-amber-100',
  checked_in: 'bg-blue-50 text-blue-700 border-blue-100',
  completed: 'bg-emerald-50 text-emerald-700 border-emerald-100',
  cancelled: 'bg-red-50 text-red-700 border-red-100',
};

const PRIORITY_STYLES = {
  normal: 'text-slate-500',
  urgent: 'text-amber-600',
  emergency: 'text-red-600',
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

function formatDate(value) {
  if (!value) {
    return '—';
  }
  return new Date(value).toLocaleDateString('en-IN', {
    year: 'numeric',
    month: 'short',
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

function TableSkeletonRows({ columns, rows = 6 }) {
  return Array.from({ length: rows }).map((_, rowIndex) => (
    <tr key={rowIndex}>
      {Array.from({ length: columns }).map((__, colIndex) => (
        <td key={colIndex} className="px-4 py-3">
          <div className="h-4 w-full max-w-[120px] animate-pulse rounded bg-slate-200" />
        </td>
      ))}
    </tr>
  ));
}

export default function AppointmentList() {
  const [appointments, setAppointments] = useState([]);
  const [patientsById, setPatientsById] = useState({});
  const [doctorsById, setDoctorsById] = useState({});
  const [meta, setMeta] = useState({ page: 1, limit: PAGE_SIZE, total: 0, totalPages: 1 });
  const [page, setPage] = useState(1);
  const [statusFilter, setStatusFilter] = useState('');
  const [dateFilter, setDateFilter] = useState('');
  const [isLoading, setIsLoading] = useState(true);
  const [errorMessage, setErrorMessage] = useState('');
  const [cancellingId, setCancellingId] = useState(null);

  useEffect(() => {
    async function loadLookups() {
      try {
        const [patientsRes, doctorsRes] = await Promise.all([
          getPatients({ page: 1, limit: 200 }),
          getDoctors({ page: 1, limit: 200 }),
        ]);
        setPatientsById(
          Object.fromEntries(patientsRes.data.data.patients.map((p) => [p.id, p]))
        );
        setDoctorsById(
          Object.fromEntries(doctorsRes.data.data.doctors.map((d) => [d.id, d]))
        );
      } catch {
        // Non-critical — table falls back to showing raw IDs.
      }
    }
    loadLookups();
  }, []);

  const fetchAppointments = useCallback(async () => {
    setIsLoading(true);
    setErrorMessage('');
    try {
      const response = await getAppointments({
        page,
        limit: PAGE_SIZE,
        status: statusFilter || undefined,
        date: dateFilter || undefined,
      });
      setAppointments(response.data.data.appointments);
      setMeta(response.data.data.meta);
    } catch (error) {
      setErrorMessage(
        error.response?.data?.message ?? 'Unable to load appointments right now.'
      );
    } finally {
      setIsLoading(false);
    }
  }, [page, statusFilter, dateFilter]);

  useEffect(() => {
    fetchAppointments();
  }, [fetchAppointments]);

  function handleStatusFilterChange(value) {
    setStatusFilter(value);
    setPage(1);
  }

  function handleDateFilterChange(value) {
    setDateFilter(value);
    setPage(1);
  }

  async function handleCancel(id) {
    setCancellingId(id);
    try {
      await cancelAppointment(id);
      await fetchAppointments();
    } catch (error) {
      setErrorMessage(
        error.response?.data?.message ?? 'Unable to cancel this appointment right now.'
      );
    } finally {
      setCancellingId(null);
    }
  }

  const hasActiveFilters = Boolean(statusFilter || dateFilter);

  if (errorMessage && appointments.length === 0 && !isLoading) {
    return (
      <div className="flex min-h-[60vh] flex-col items-center justify-center rounded-lg border border-red-100 bg-red-50/40 text-center">
        <AlertCircle className="text-red-500" size={32} />
        <p className="mt-3 font-['Manrope',sans-serif] text-base font-semibold text-slate-800">
          Couldn&apos;t load appointments
        </p>
        <p className="mt-1 max-w-sm text-sm text-slate-500">{errorMessage}</p>
        <button
          type="button"
          onClick={fetchAppointments}
          className="mt-5 inline-flex items-center gap-2 rounded-md bg-[#0F6B66] px-4 py-2 text-sm font-semibold text-white hover:bg-[#0C5450]"
        >
          <RefreshCw size={15} />
          Retry
        </button>
      </div>
    );
  }

  return (
    <div className="space-y-6">
      <div className="flex flex-col justify-between gap-4 sm:flex-row sm:items-center">
        <div>
          <h1 className="font-['Manrope',sans-serif] text-2xl font-semibold text-slate-800">
            Appointments
          </h1>
          <p className="mt-1 text-sm text-slate-500">
            {meta.total} appointment{meta.total === 1 ? '' : 's'}
          </p>
        </div>
        <Link
          to="/appointments/new"
          className="inline-flex items-center justify-center gap-2 rounded-md bg-[#0F6B66] px-4 py-2.5 text-sm font-semibold text-white hover:bg-[#0C5450]"
        >
          <Plus size={16} />
          New Appointment
        </Link>
      </div>

      <div className="rounded-lg border border-slate-200 bg-white">
        <div className="flex flex-wrap items-center gap-3 border-b border-slate-100 px-5 py-4">
          <select
            value={statusFilter}
            onChange={(event) => handleStatusFilterChange(event.target.value)}
            className="rounded-md border border-slate-300 bg-white px-3 py-2 text-sm text-slate-800 focus:border-[#0F6B66] focus:outline-none focus:ring-2 focus:ring-[#0F6B66]/20"
          >
            <option value="">All statuses</option>
            {STATUS_OPTIONS.map((status) => (
              <option key={status} value={status}>
                {formatLabel(status)}
              </option>
            ))}
          </select>

          <input
            type="date"
            value={dateFilter}
            onChange={(event) => handleDateFilterChange(event.target.value)}
            className="rounded-md border border-slate-300 bg-white px-3 py-2 text-sm text-slate-800 focus:border-[#0F6B66] focus:outline-none focus:ring-2 focus:ring-[#0F6B66]/20"
          />

          {hasActiveFilters && (
            <button
              type="button"
              onClick={() => {
                setStatusFilter('');
                setDateFilter('');
                setPage(1);
              }}
              className="inline-flex items-center gap-1 text-sm font-medium text-slate-500 hover:text-slate-700"
            >
              <X size={14} />
              Clear filters
            </button>
          )}
        </div>

        {errorMessage && appointments.length > 0 && (
          <div className="mx-5 mt-4 flex items-center gap-2 rounded-md border border-red-100 bg-red-50 px-4 py-3 text-sm text-red-600">
            <AlertCircle size={16} />
            {errorMessage}
          </div>
        )}

        <div className="overflow-x-auto">
          <table className="w-full text-left text-sm">
            <thead>
              <tr className="border-b border-slate-100 text-xs uppercase tracking-wide text-slate-400">
                <th className="px-4 py-3 font-medium">Date &amp; Time</th>
                <th className="px-4 py-3 font-medium">Patient</th>
                <th className="px-4 py-3 font-medium">Doctor</th>
                <th className="px-4 py-3 font-medium">Priority</th>
                <th className="px-4 py-3 font-medium">Status</th>
                <th className="px-4 py-3 font-medium text-right">Actions</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-slate-100">
              {isLoading ? (
                <TableSkeletonRows columns={6} />
              ) : appointments.length === 0 ? (
                <tr>
                  <td colSpan={6} className="px-4 py-14">
                    <div className="flex flex-col items-center justify-center text-center">
                      <div className="flex h-12 w-12 items-center justify-center rounded-full bg-slate-100 text-slate-400">
                        <CalendarDays size={22} />
                      </div>
                      <p className="mt-3 text-sm font-medium text-slate-600">
                        {hasActiveFilters ? 'No appointments match these filters.' : 'No appointments yet.'}
                      </p>
                      <p className="mt-1 text-sm text-slate-400">
                        {hasActiveFilters
                          ? 'Try a different status or date.'
                          : 'Book your first appointment to get started.'}
                      </p>
                      {!hasActiveFilters && (
                        <Link
                          to="/appointments/new"
                          className="mt-4 inline-flex items-center gap-2 rounded-md bg-[#0F6B66] px-4 py-2 text-sm font-semibold text-white hover:bg-[#0C5450]"
                        >
                          <Plus size={15} />
                          New Appointment
                        </Link>
                      )}
                    </div>
                  </td>
                </tr>
              ) : (
                appointments.map((appointment) => {
                  const patient = patientsById[appointment.patientId];
                  const doctor = doctorsById[appointment.doctorId];
                  return (
                    <tr key={appointment.id}>
                      <td className="px-4 py-3 text-slate-700">
                        <div className="font-medium">{formatDate(appointment.appointmentDate)}</div>
                        <div className="text-xs text-slate-400">{formatTime(appointment.startTime)}</div>
                      </td>
                      <td className="px-4 py-3 text-slate-700">
                        {patient ? patient.fullName : `Patient #${appointment.patientId.slice(0, 8)}`}
                      </td>
                      <td className="px-4 py-3 text-slate-700">
                        {doctor ? doctor.fullName : `Doctor #${appointment.doctorId.slice(0, 8)}`}
                      </td>
                      <td className={`px-4 py-3 font-medium capitalize ${PRIORITY_STYLES[appointment.priority] ?? 'text-slate-500'}`}>
                        {appointment.priority}
                      </td>
                      <td className="px-4 py-3">
                        <StatusBadge value={appointment.status} />
                      </td>
                      <td className="px-4 py-3">
                        <div className="flex items-center justify-end gap-2">
                          <Link
                            to={`/appointments/${appointment.id}`}
                            className="rounded-md px-2.5 py-1.5 text-xs font-medium text-slate-500 hover:bg-slate-100 hover:text-slate-700"
                          >
                            View
                          </Link>
                          {appointment.status !== 'cancelled' && appointment.status !== 'completed' && (
                            <button
                              type="button"
                              onClick={() => handleCancel(appointment.id)}
                              disabled={cancellingId === appointment.id}
                              className="rounded-md px-2.5 py-1.5 text-xs font-medium text-red-600 hover:bg-red-50 disabled:opacity-50"
                            >
                              {cancellingId === appointment.id ? 'Cancelling…' : 'Cancel'}
                            </button>
                          )}
                        </div>
                      </td>
                    </tr>
                  );
                })
              )}
            </tbody>
          </table>
        </div>

        {!isLoading && appointments.length > 0 && (
          <div className="flex flex-col items-center justify-between gap-3 border-t border-slate-100 px-5 py-4 sm:flex-row">
            <p className="text-sm text-slate-500">
              Page {meta.page} of {meta.totalPages} &middot; {meta.total} total
            </p>
            <div className="flex items-center gap-2">
              <button
                type="button"
                onClick={() => setPage((prev) => Math.max(1, prev - 1))}
                disabled={meta.page <= 1}
                className="flex items-center gap-1 rounded-md border border-slate-200 px-3 py-1.5 text-sm text-slate-600 hover:bg-slate-50 disabled:cursor-not-allowed disabled:opacity-50"
              >
                <ChevronLeft size={15} />
                Previous
              </button>
              <button
                type="button"
                onClick={() => setPage((prev) => Math.min(meta.totalPages, prev + 1))}
                disabled={meta.page >= meta.totalPages}
                className="flex items-center gap-1 rounded-md border border-slate-200 px-3 py-1.5 text-sm text-slate-600 hover:bg-slate-50 disabled:cursor-not-allowed disabled:opacity-50"
              >
                Next
                <ChevronRight size={15} />
              </button>
            </div>
          </div>
        )}
      </div>
    </div>
  );
}
