import { useCallback, useEffect, useState } from 'react';
import { Link, useNavigate, useParams } from 'react-router-dom';
import {
  ArrowLeft,
  Pencil,
  Trash2,
  Check,
  X,
  AlertCircle,
  RefreshCw,
  Loader2,
} from 'lucide-react';
import { getDoctorById, deleteDoctor } from '../../api/doctorApi';

function StatusBadge({ isActive }) {
  return (
    <span
      className={`inline-flex items-center rounded-full border px-2.5 py-0.5 text-xs font-medium ${
        isActive
          ? 'border-emerald-100 bg-emerald-50 text-emerald-700'
          : 'border-slate-200 bg-slate-50 text-slate-500'
      }`}
    >
      {isActive ? 'Active' : 'Inactive'}
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

function SectionCard({ title, children }) {
  return (
    <div className="rounded-lg border border-slate-200 bg-white">
      <div className="border-b border-slate-100 px-5 py-4">
        <h2 className="font-['Manrope',sans-serif] text-base font-semibold text-slate-800">
          {title}
        </h2>
      </div>
      <div className="grid grid-cols-1 gap-5 p-5 sm:grid-cols-2">{children}</div>
    </div>
  );
}

function formatCurrency(amount) {
  return new Intl.NumberFormat('en-IN', {
    style: 'currency',
    currency: 'INR',
    maximumFractionDigits: 0,
  }).format(amount ?? 0);
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
      {Array.from({ length: 2 }).map((_, index) => (
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

export default function DoctorDetails() {
  const { id } = useParams();
  const navigate = useNavigate();

  const [doctor, setDoctor] = useState(null);
  const [isLoading, setIsLoading] = useState(true);
  const [loadError, setLoadError] = useState('');
  const [deleteErrorMessage, setDeleteErrorMessage] = useState('');
  const [isConfirmingDelete, setIsConfirmingDelete] = useState(false);
  const [isDeleting, setIsDeleting] = useState(false);

  const fetchDoctor = useCallback(async () => {
    setIsLoading(true);
    setLoadError('');
    try {
      const response = await getDoctorById(id);
      setDoctor(response.data.data);
    } catch (error) {
      setLoadError(
        error.response?.data?.message ?? 'Unable to load this doctor right now.'
      );
    } finally {
      setIsLoading(false);
    }
  }, [id]);

  useEffect(() => {
    fetchDoctor();
  }, [fetchDoctor]);

  async function handleDelete() {
    setIsDeleting(true);
    setDeleteErrorMessage('');
    try {
      await deleteDoctor(id);
      navigate('/doctors', { replace: true });
    } catch (error) {
      setDeleteErrorMessage(
        error.response?.data?.message ?? 'Unable to delete this doctor right now.'
      );
      setIsConfirmingDelete(false);
    } finally {
      setIsDeleting(false);
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
          Couldn&apos;t load this doctor
        </p>
        <p className="mt-1 max-w-sm text-sm text-slate-500">{loadError}</p>
        <button
          type="button"
          onClick={fetchDoctor}
          className="mt-5 inline-flex items-center gap-2 rounded-md bg-[#0F6B66] px-4 py-2 text-sm font-semibold text-white hover:bg-[#0C5450]"
        >
          <RefreshCw size={15} />
          Retry
        </button>
      </div>
    );
  }

  return (
    <div className="mx-auto max-w-3xl space-y-6">
      <Link
        to="/doctors"
        className="inline-flex items-center gap-1.5 text-sm font-medium text-slate-500 hover:text-slate-700"
      >
        <ArrowLeft size={15} />
        Back to Doctors
      </Link>

      <div className="rounded-lg border border-slate-200 bg-white p-6">
        <div className="flex flex-col justify-between gap-4 sm:flex-row sm:items-start">
          <div>
            <div className="flex items-center gap-3">
              <h1 className="font-['Manrope',sans-serif] text-2xl font-semibold text-slate-800">
                {doctor.fullName}
              </h1>
              <StatusBadge isActive={doctor.isActive} />
            </div>
            <p className="mt-1 font-['JetBrains_Mono',monospace] text-sm text-slate-500">
              {doctor.doctorId}
            </p>
          </div>

          {isConfirmingDelete ? (
            <div className="flex items-center gap-2">
              <span className="text-sm text-slate-500">Delete this doctor?</span>
              <button
                type="button"
                onClick={handleDelete}
                disabled={isDeleting}
                className="flex items-center gap-1.5 rounded-md bg-red-600 px-3 py-2 text-sm font-medium text-white hover:bg-red-700 disabled:opacity-60"
              >
                {isDeleting ? <Loader2 size={15} className="animate-spin" /> : <Check size={15} />}
                Confirm
              </button>
              <button
                type="button"
                onClick={() => setIsConfirmingDelete(false)}
                disabled={isDeleting}
                className="flex items-center gap-1.5 rounded-md border border-slate-200 px-3 py-2 text-sm font-medium text-slate-500 hover:bg-slate-50"
              >
                <X size={15} />
                Cancel
              </button>
            </div>
          ) : (
            <div className="flex items-center gap-2">
              <Link
                to={`/doctors/${id}/edit`}
                className="flex items-center gap-1.5 rounded-md border border-slate-200 px-3 py-2 text-sm font-medium text-slate-600 hover:bg-slate-50"
              >
                <Pencil size={15} />
                Edit
              </Link>
              <button
                type="button"
                onClick={() => setIsConfirmingDelete(true)}
                className="flex items-center gap-1.5 rounded-md border border-red-100 px-3 py-2 text-sm font-medium text-red-600 hover:bg-red-50"
              >
                <Trash2 size={15} />
                Delete
              </button>
            </div>
          )}
        </div>

        {deleteErrorMessage && (
          <div className="mt-4 rounded-md border border-red-100 bg-red-50 px-4 py-3 text-sm text-red-600">
            {deleteErrorMessage}
          </div>
        )}
      </div>

      <SectionCard title="Professional Details">
        <InfoField label="Department" value={doctor.departmentName} />
        <InfoField label="Specialization" value={doctor.specialization} />
        <InfoField label="Qualification" value={doctor.qualification} />
        <InfoField label="Experience" value={`${doctor.experienceYears} years`} />
        <InfoField label="Consultation Fee" value={formatCurrency(doctor.consultationFee)} />
        <InfoField label="Gender" value={doctor.gender} />
      </SectionCard>

      <SectionCard title="Consultation Schedule">
        <InfoField
          label="Hours"
          value={
            doctor.consultStartTime && doctor.consultEndTime
              ? `${doctor.consultStartTime.slice(0, 5)} - ${doctor.consultEndTime.slice(0, 5)}`
              : null
          }
        />
        <InfoField
          label="Days"
          value={doctor.consultDays?.length ? doctor.consultDays.join(', ') : null}
        />
      </SectionCard>

      <SectionCard title="Contact Details">
        <InfoField label="Phone" value={doctor.phone} />
        <InfoField label="Email" value={doctor.email} />
      </SectionCard>

      <SectionCard title="Record Information">
        <InfoField label="Registered On" value={formatDateTime(doctor.createdAt)} />
        <InfoField label="Last Updated" value={formatDateTime(doctor.updatedAt)} />
      </SectionCard>
    </div>
  );
}
