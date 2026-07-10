import { useCallback, useEffect, useState } from "react";
import { Link } from "react-router-dom";
import {
  Plus,
  AlertCircle,
  RefreshCw,
  Receipt,
  ChevronLeft,
  ChevronRight,
} from "lucide-react";
import { getBills } from "../../api/billingApi";

const PAGE_SIZE = 10;

const PAYMENT_STATUS_OPTIONS = ['pending', 'paid', 'partially_paid', 'cancelled'];

const PAYMENT_STATUS_STYLES = {
  pending: 'bg-amber-50 text-amber-700 border-amber-100',
  paid: 'bg-emerald-50 text-emerald-700 border-emerald-100',
  partially_paid: 'bg-blue-50 text-blue-700 border-blue-100',
  cancelled: 'bg-red-50 text-red-700 border-red-100',
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

function formatCurrency(amount) {
  return new Intl.NumberFormat('en-IN', {
    style: 'currency',
    currency: 'INR',
    maximumFractionDigits: 0,
  }).format(amount ?? 0);
}

function truncateId(id) {
  if (!id) {
    return '—';
  }
  return `${id.slice(0, 8)}…`;
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

export default function BillingList() {
  const [bills, setBills] = useState([]);
  const [meta, setMeta] = useState({ page: 1, limit: PAGE_SIZE, total: 0, totalPages: 1 });
  const [page, setPage] = useState(1);
  const [paymentStatusFilter, setPaymentStatusFilter] = useState('');
  const [isLoading, setIsLoading] = useState(true);
  const [errorMessage, setErrorMessage] = useState('');

  const fetchBills = useCallback(async () => {
    setIsLoading(true);
    setErrorMessage('');
    try {
      const response = await getBills({
        page,
        limit: PAGE_SIZE,
        paymentStatus: paymentStatusFilter || undefined,
      });
      setBills(response.data.data.bills);
      setMeta(response.data.data.meta);
    } catch (error) {
      setErrorMessage(
        error.response?.data?.message ?? 'Unable to load bills right now.'
      );
    } finally {
      setIsLoading(false);
    }
  }, [page, paymentStatusFilter]);

  useEffect(() => {
    fetchBills();
  }, [fetchBills]);

  function handleFilterChange(value) {
    setPaymentStatusFilter(value);
    setPage(1);
  }

  if (errorMessage && bills.length === 0 && !isLoading) {
    return (
      <div className="flex min-h-[60vh] flex-col items-center justify-center rounded-lg border border-red-100 bg-red-50/40 text-center">
        <AlertCircle className="text-red-500" size={32} />
        <p className="mt-3 font-['Manrope',sans-serif] text-base font-semibold text-slate-800">
          Couldn&apos;t load bills
        </p>
        <p className="mt-1 max-w-sm text-sm text-slate-500">{errorMessage}</p>
        <button
          type="button"
          onClick={fetchBills}
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
            Billing
          </h1>
          <p className="mt-1 text-sm text-slate-500">
            {meta.total} bill{meta.total === 1 ? '' : 's'}
          </p>
        </div>
        <Link
          to="/billing/new"
          className="inline-flex items-center justify-center gap-2 rounded-md bg-[#0F6B66] px-4 py-2.5 text-sm font-semibold text-white hover:bg-[#0C5450]"
        >
          <Plus size={16} />
          Generate Bill
        </Link>
      </div>

      <div className="rounded-lg border border-slate-200 bg-white">
        <div className="flex items-center gap-3 border-b border-slate-100 px-5 py-4">
          <select
            value={paymentStatusFilter}
            onChange={(event) => handleFilterChange(event.target.value)}
            className="rounded-md border border-slate-300 bg-white px-3 py-2 text-sm text-slate-800 focus:border-[#0F6B66] focus:outline-none focus:ring-2 focus:ring-[#0F6B66]/20"
          >
            <option value="">All payment statuses</option>
            {PAYMENT_STATUS_OPTIONS.map((status) => (
              <option key={status} value={status}>
                {formatLabel(status)}
              </option>
            ))}
          </select>
        </div>

        {errorMessage && bills.length > 0 && (
          <div className="mx-5 mt-4 flex items-center gap-2 rounded-md border border-red-100 bg-red-50 px-4 py-3 text-sm text-red-600">
            <AlertCircle size={16} />
            {errorMessage}
          </div>
        )}

        <div className="overflow-x-auto">
          <table className="w-full text-left text-sm">
            <thead>
              <tr className="border-b border-slate-100 text-xs uppercase tracking-wide text-slate-400">
                <th className="px-4 py-3 font-medium">Bill Number</th>
                <th className="px-4 py-3 font-medium">Patient ID</th>
                <th className="px-4 py-3 font-medium">Doctor ID</th>
                <th className="px-4 py-3 font-medium">Amount</th>
                <th className="px-4 py-3 font-medium">Status</th>
                <th className="px-4 py-3 font-medium text-right">Actions</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-slate-100">
              {isLoading ? (
                <TableSkeletonRows columns={6} />
              ) : bills.length === 0 ? (
                <tr>
                  <td colSpan={6} className="px-4 py-14">
                    <div className="flex flex-col items-center justify-center text-center">
                      <div className="flex h-12 w-12 items-center justify-center rounded-full bg-slate-100 text-slate-400">
                        <Receipt size={22} />
                      </div>
                      <p className="mt-3 text-sm font-medium text-slate-600">
                        {paymentStatusFilter ? 'No bills match this status.' : 'No bills yet.'}
                      </p>
                      <p className="mt-1 text-sm text-slate-400">
                        {paymentStatusFilter
                          ? 'Try a different payment status.'
                          : 'Generate your first bill to get started.'}
                      </p>
                    </div>
                  </td>
                </tr>
              ) : (
                bills.map((bill) => (
                  <tr key={bill.id}>
                    <td className="px-4 py-3 font-['JetBrains_Mono',monospace] text-xs text-slate-700">
                      {bill.billNumber}
                    </td>
                    <td
                      className="px-4 py-3 font-['JetBrains_Mono',monospace] text-xs text-slate-600"
                      title={bill.patientId}
                    >
                      {truncateId(bill.patientId)}
                    </td>
                    <td
                      className="px-4 py-3 font-['JetBrains_Mono',monospace] text-xs text-slate-600"
                      title={bill.doctorId}
                    >
                      {truncateId(bill.doctorId)}
                    </td>
                    <td className="px-4 py-3 text-slate-600">{formatCurrency(bill.finalAmount)}</td>
                    <td className="px-4 py-3">
                      <StatusBadge value={bill.paymentStatus} />
                    </td>
                    <td className="px-4 py-3 text-right">
                      <Link
                        to={`/billing/${bill.id}`}
                        className="rounded-md px-2.5 py-1.5 text-xs font-medium text-slate-500 hover:bg-slate-100 hover:text-slate-700"
                      >
                        View
                      </Link>
                    </td>
                  </tr>
                ))
              )}
            </tbody>
          </table>
        </div>

        {!isLoading && bills.length > 0 && (
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
