import { useCallback, useEffect, useState } from 'react';
import { Link, useParams } from 'react-router-dom';
import {
  ArrowLeft,
  AlertCircle,
  RefreshCw,
  Loader2,
  Receipt,
  UserRound,
  Stethoscope,
} from 'lucide-react';
import { getBillById, updatePaymentStatus } from '../../api/billingApi';
import { getPatientById } from '../../api/patientApi';
import { getDoctorById } from '../../api/doctorApi';

const PAYMENT_STATUS_STYLES = {
  pending: 'bg-amber-50 text-amber-700 border-amber-100',
  paid: 'bg-emerald-50 text-emerald-700 border-emerald-100',
  partially_paid: 'bg-blue-50 text-blue-700 border-blue-100',
  cancelled: 'bg-red-50 text-red-700 border-red-100',
};

const NEXT_STATUS = {
  pending: { next: 'paid', label: 'Mark as Paid' },
  partially_paid: { next: 'paid', label: 'Mark as Paid' },
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
  const style = PAYMENT_STATUS_STYLES[value] ?? 'bg-slate-50 text-slate-600 border-slate-200';
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

export default function BillDetails() {
  const { id } = useParams();

  const [bill, setBill] = useState(null);
  const [patient, setPatient] = useState(null);
  const [doctor, setDoctor] = useState(null);
  const [isLoading, setIsLoading] = useState(true);
  const [loadError, setLoadError] = useState('');
  const [actionError, setActionError] = useState('');
  const [isUpdating, setIsUpdating] = useState(false);

  const fetchBill = useCallback(async () => {
    setIsLoading(true);
    setLoadError('');
    try {
      const response = await getBillById(id);
      const data = response.data.data;
      setBill(data);

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
        error.response?.data?.message ?? 'Unable to load this bill right now.'
      );
    } finally {
      setIsLoading(false);
    }
  }, [id]);

  useEffect(() => {
    fetchBill();
  }, [fetchBill]);

  async function handleUpdateStatus(nextStatus) {
    setActionError('');
    setIsUpdating(true);
    try {
      await updatePaymentStatus(id, nextStatus);
      await fetchBill();
    } catch (error) {
      setActionError(
        error.response?.data?.message ?? 'Unable to update payment status right now.'
      );
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
          Couldn&apos;t load this bill
        </p>
        <p className="mt-1 max-w-sm text-sm text-slate-500">{loadError}</p>
        <button
          type="button"
          onClick={fetchBill}
          className="mt-5 inline-flex items-center gap-2 rounded-md bg-[#0F6B66] px-4 py-2 text-sm font-semibold text-white hover:bg-[#0C5450]"
        >
          <RefreshCw size={15} />
          Retry
        </button>
      </div>
    );
  }

  const nextStep = NEXT_STATUS[bill.paymentStatus];

  return (
    <div className="mx-auto max-w-3xl space-y-6">
      <Link
        to="/billing"
        className="inline-flex items-center gap-1.5 text-sm font-medium text-slate-500 hover:text-slate-700"
      >
        <ArrowLeft size={15} />
        Back to Billing
      </Link>

      <div className="rounded-lg border border-slate-200 bg-white p-6">
        <div className="flex flex-col justify-between gap-4 sm:flex-row sm:items-start">
          <div>
            <div className="flex items-center gap-3">
              <h1 className="font-['Manrope',sans-serif] text-2xl font-semibold text-slate-800">
                {formatCurrency(bill.finalAmount)}
              </h1>
              <StatusBadge value={bill.paymentStatus} />
            </div>
            <p className="mt-1 font-['JetBrains_Mono',monospace] text-sm text-slate-500">
              {bill.billNumber}
            </p>
          </div>

          {nextStep && (
            <button
              type="button"
              onClick={() => handleUpdateStatus(nextStep.next)}
              disabled={isUpdating}
              className="flex items-center gap-1.5 rounded-md bg-[#0F6B66] px-3 py-2 text-sm font-medium text-white hover:bg-[#0C5450] disabled:opacity-60"
            >
              {isUpdating ? <Loader2 size={15} className="animate-spin" /> : <Receipt size={15} />}
              {nextStep.label}
            </button>
          )}
        </div>

        {actionError && (
          <div className="mt-4 rounded-md border border-red-100 bg-red-50 px-4 py-3 text-sm text-red-600">
            {actionError}
          </div>
        )}
      </div>

      <SectionCard title="Amount Breakdown">
        <InfoField label="Total Amount" value={formatCurrency(bill.totalAmount)} />
        <InfoField label="Discount" value={formatCurrency(bill.discountAmount)} />
        <InfoField label="Tax" value={formatCurrency(bill.taxAmount)} />
        <InfoField label="Final Amount" value={formatCurrency(bill.finalAmount)} />
        <InfoField label="Payment Method" value={formatLabel(bill.paymentMethod)} />
      </SectionCard>

      <SectionCard title="Patient" icon={UserRound}>
        {patient ? (
          <>
            <InfoField label="Name" value={patient.fullName} />
            <InfoField label="Patient ID" value={patient.patientId} />
          </>
        ) : (
          <div className="sm:col-span-2">
            <Link
              to={`/patients/${bill.patientId}`}
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
          </>
        ) : (
          <div className="sm:col-span-2">
            <Link
              to={`/doctors/${bill.doctorId}`}
              className="text-sm font-medium text-[#0F6B66] hover:underline"
            >
              View doctor record
            </Link>
          </div>
        )}
      </SectionCard>

      {bill.notes && (
        <SectionCard title="Notes">
          <div className="sm:col-span-2">
            <p className="text-sm text-slate-700">{bill.notes}</p>
          </div>
        </SectionCard>
      )}

      <SectionCard title="Record Information">
        <InfoField label="Generated On" value={formatDateTime(bill.createdAt)} />
        <InfoField label="Last Updated" value={formatDateTime(bill.updatedAt)} />
      </SectionCard>
    </div>
  );
}
