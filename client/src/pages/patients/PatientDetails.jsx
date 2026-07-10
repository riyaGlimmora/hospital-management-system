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
import { getPatientById, deletePatient } from '../../api/patientApi';

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

export default function PatientDetails() {
  const { id } = useParams();
  const navigate = useNavigate();

  const [patient, setPatient] = useState(null);
  const [isLoading, setIsLoading] = useState(true);
  const [loadError, setLoadError] = useState('');
  const [deleteErrorMessage, setDeleteErrorMessage] = useState('');
  const [isConfirmingDelete, setIsConfirmingDelete] = useState(false);
  const [isDeleting, setIsDeleting] = useState(false);

  const fetchPatient = useCallback(async () => {
    setIsLoading(true);
    setLoadError('');
    try {
      const response = await getPatientById(id);
      setPatient(response.data.data);
    } catch (error) {
      setLoadError(
        error.response?.data?.message ?? 'Unable to load this patient right now.'
      );
    } finally {
      setIsLoading(false);
    }
  }, [id]);

  useEffect(() => {
    fetchPatient();
  }, [fetchPatient]);

  async function handleDelete() {
    setIsDeleting(true);
    setDeleteErrorMessage('');
    try {
      await deletePatient(id);
      navigate('/patients', { replace: true });
    } catch (error) {
      setDeleteErrorMessage(
        error.response?.data?.message ?? 'Unable to delete this patient right now.'
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
          Couldn&apos;t load this patient
        </p>
        <p className="mt-1 max-w-sm text-sm text-slate-500">{loadError}</p>
        <button
          type="button"
          onClick={fetchPatient}
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
        to="/patients"
        className="inline-flex items-center gap-1.5 text-sm font-medium text-slate-500 hover:text-slate-700"
      >
        <ArrowLeft size={15} />
        Back to Patients
      </Link>

      <div className="rounded-lg border border-slate-200 bg-white p-6">
        <div className="flex flex-col justify-between gap-4 sm:flex-row sm:items-start">
          <div>
            <div className="flex items-center gap-3">
              <h1 className="font-['Manrope',sans-serif] text-2xl font-semibold text-slate-800">
                {patient.fullName}
              </h1>
              <StatusBadge isActive={patient.isActive} />
            </div>
            <p className="mt-1 font-['JetBrains_Mono',monospace] text-sm text-slate-500">
              {patient.patientId}
            </p>
          </div>

          {isConfirmingDelete ? (
            <div className="flex items-center gap-2">
              <span className="text-sm text-slate-500">Delete this patient?</span>
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
                to={`/patients/${id}/edit`}
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

      <SectionCard title="Personal Details">
        <InfoField label="Gender" value={patient.gender} />
        <InfoField label="Date of Birth" value={formatDate(patient.dateOfBirth)} />
        <InfoField label="Blood Group" value={patient.bloodGroup} />
      </SectionCard>

      <SectionCard title="Contact Details">
        <InfoField label="Phone" value={patient.phone} />
        <InfoField label="Email" value={patient.email} />
        <div className="sm:col-span-2">
          <InfoField label="Address" value={patient.address} />
        </div>
      </SectionCard>

      <SectionCard title="Emergency Contact">
        <InfoField label="Contact Name" value={patient.emergencyContactName} />
        <InfoField label="Contact Phone" value={patient.emergencyContactPhone} />
      </SectionCard>

      <SectionCard title="Record Information">
        <InfoField label="Registered On" value={formatDateTime(patient.createdAt)} />
        <InfoField label="Last Updated" value={formatDateTime(patient.updatedAt)} />
      </SectionCard>
    </div>
  );
}
