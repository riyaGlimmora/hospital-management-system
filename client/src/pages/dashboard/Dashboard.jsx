import { useCallback, useEffect, useState } from 'react';
import {
  Users,
  Stethoscope,
  CalendarClock,
  Receipt,
  Wallet,
  AlertCircle,
  RefreshCw,
} from 'lucide-react';
import api from '../../api/axios';

const APPOINTMENT_STATUS_STYLES = {
  scheduled: 'bg-blue-50 text-blue-700 border-blue-100',
  checked_in: 'bg-amber-50 text-amber-700 border-amber-100',
  completed: 'bg-emerald-50 text-emerald-700 border-emerald-100',
  cancelled: 'bg-red-50 text-red-700 border-red-100',
};

const PAYMENT_STATUS_STYLES = {
  pending: 'bg-amber-50 text-amber-700 border-amber-100',
  paid: 'bg-emerald-50 text-emerald-700 border-emerald-100',
  partially_paid: 'bg-blue-50 text-blue-700 border-blue-100',
  cancelled: 'bg-red-50 text-red-700 border-red-100',
};

function formatCurrency(amount) {
  return new Intl.NumberFormat('en-IN', {
    style: 'currency',
    currency: 'INR',
    maximumFractionDigits: 0,
  }).format(amount ?? 0);
}

function formatLabel(value) {
  if (!value) {
    return '—';
  }
  return value
    .split('_')
    .map((word) => word.charAt(0).toUpperCase() + word.slice(1))
    .join(' ');
}

function truncateId(id) {
  if (!id) {
    return '—';
  }
  return `${id.slice(0, 8)}…`;
}

function StatusBadge({ value, styleMap }) {
  const style = styleMap[value] ?? 'bg-slate-50 text-slate-600 border-slate-200';
  return (
    <span
      className={`inline-flex items-center rounded-full border px-2.5 py-0.5 text-xs font-medium ${style}`}
    >
      {formatLabel(value)}
    </span>
  );
}

function OverviewCard({ label, value, icon: Icon }) {
  return (
    <div className="rounded-lg border border-slate-200 bg-white p-5">
      <div className="flex items-center justify-between">
        <p className="text-sm font-medium text-slate-500">{label}</p>
        <div className="flex h-9 w-9 items-center justify-center rounded-md bg-[#0F6B66]/10 text-[#0F6B66]">
          <Icon size={18} />
        </div>
      </div>
      <p className="mt-3 font-['Manrope',sans-serif] text-2xl font-semibold text-slate-800">
        {value}
      </p>
    </div>
  );
}

function CardSkeleton() {
  return (
    <div className="rounded-lg border border-slate-200 bg-white p-5">
      <div className="flex items-center justify-between">
        <div className="h-4 w-24 animate-pulse rounded bg-slate-200" />
        <div className="h-9 w-9 animate-pulse rounded-md bg-slate-200" />
      </div>
      <div className="mt-4 h-7 w-16 animate-pulse rounded bg-slate-200" />
    </div>
  );
}

function TableSkeletonRows({ columns, rows = 4 }) {
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

function SectionCard({ title, children }) {
  return (
    <div className="rounded-lg border border-slate-200 bg-white">
      <div className="border-b border-slate-100 px-5 py-4">
        <h2 className="font-['Manrope',sans-serif] text-base font-semibold text-slate-800">
          {title}
        </h2>
      </div>
      <div className="p-5">{children}</div>
    </div>
  );
}

function EmptyRow({ colSpan, message }) {
  return (
    <tr>
      <td colSpan={colSpan} className="px-4 py-8 text-center text-sm text-slate-400">
        {message}
      </td>
    </tr>
  );
}

export default function Dashboard() {
  const [dashboard, setDashboard] = useState(null);
  const [isLoading, setIsLoading] = useState(true);
  const [errorMessage, setErrorMessage] = useState('');

  const fetchDashboard = useCallback(async () => {
    setIsLoading(true);
    setErrorMessage('');
    try {
      const response = await api.get('/dashboard');
      setDashboard(response.data.data);
    } catch (error) {
      setErrorMessage(
        error.response?.data?.message ?? 'Unable to load the dashboard right now.'
      );
    } finally {
      setIsLoading(false);
    }
  }, []);

  useEffect(() => {
    fetchDashboard();
  }, [fetchDashboard]);

  if (errorMessage && !dashboard) {
    return (
      <div className="flex min-h-[60vh] flex-col items-center justify-center rounded-lg border border-red-100 bg-red-50/40 text-center">
        <AlertCircle className="text-red-500" size={32} />
        <p className="mt-3 font-['Manrope',sans-serif] text-base font-semibold text-slate-800">
          Couldn&apos;t load the dashboard
        </p>
        <p className="mt-1 max-w-sm text-sm text-slate-500">{errorMessage}</p>
        <button
          type="button"
          onClick={fetchDashboard}
          className="mt-5 inline-flex items-center gap-2 rounded-md bg-[#0F6B66] px-4 py-2 text-sm font-semibold text-white hover:bg-[#0C5450]"
        >
          <RefreshCw size={15} />
          Retry
        </button>
      </div>
    );
  }

  const overview = dashboard?.overview;
  const appointmentStats = dashboard?.appointmentStats ?? [];
  const billingStats = dashboard?.billingStats ?? [];
  const recentAppointments = dashboard?.recentAppointments ?? [];
  const recentBills = dashboard?.recentBills ?? [];

  const overviewCards = [
    { key: 'totalActivePatients', label: 'Active Patients', icon: Users },
    { key: 'totalActiveDoctors', label: 'Active Doctors', icon: Stethoscope },
    { key: 'todaysAppointments', label: "Today's Appointments", icon: CalendarClock },
    { key: 'pendingBills', label: 'Pending Bills', icon: Receipt },
  ];

  return (
    <div className="space-y-6">
      <div>
        <h1 className="font-['Manrope',sans-serif] text-2xl font-semibold text-slate-800">
          Dashboard
        </h1>
        <p className="mt-1 text-sm text-slate-500">
          A snapshot of today&apos;s activity across the hospital.
        </p>
      </div>

      <div className="grid grid-cols-1 gap-4 sm:grid-cols-2 lg:grid-cols-5">
        {isLoading
          ? Array.from({ length: 5 }).map((_, index) => <CardSkeleton key={index} />)
          : (
            <>
              {overviewCards.map(({ key, label, icon }) => (
                <OverviewCard key={key} label={label} value={overview?.[key] ?? 0} icon={icon} />
              ))}
              <OverviewCard
                label="Total Revenue"
                value={formatCurrency(overview?.totalRevenue)}
                icon={Wallet}
              />
            </>
          )}
      </div>

      <div className="grid grid-cols-1 gap-6 lg:grid-cols-2">
        <SectionCard title="Appointment Status Summary">
          {isLoading ? (
            <div className="space-y-3">
              {Array.from({ length: 3 }).map((_, index) => (
                <div key={index} className="h-6 w-full animate-pulse rounded bg-slate-200" />
              ))}
            </div>
          ) : appointmentStats.length === 0 ? (
            <p className="py-6 text-center text-sm text-slate-400">No appointment data yet.</p>
          ) : (
            <ul className="space-y-3">
              {appointmentStats.map((stat) => (
                <li key={stat.status} className="flex items-center justify-between">
                  <StatusBadge value={stat.status} styleMap={APPOINTMENT_STATUS_STYLES} />
                  <span className="text-sm font-semibold text-slate-700">{stat.count}</span>
                </li>
              ))}
            </ul>
          )}
        </SectionCard>

        <SectionCard title="Billing Status Summary">
          {isLoading ? (
            <div className="space-y-3">
              {Array.from({ length: 3 }).map((_, index) => (
                <div key={index} className="h-6 w-full animate-pulse rounded bg-slate-200" />
              ))}
            </div>
          ) : billingStats.length === 0 ? (
            <p className="py-6 text-center text-sm text-slate-400">No billing data yet.</p>
          ) : (
            <ul className="space-y-3">
              {billingStats.map((stat) => (
                <li key={stat.paymentStatus} className="flex items-center justify-between">
                  <StatusBadge value={stat.paymentStatus} styleMap={PAYMENT_STATUS_STYLES} />
                  <span className="text-sm font-semibold text-slate-700">{stat.count}</span>
                </li>
              ))}
            </ul>
          )}
        </SectionCard>
      </div>

      <SectionCard title="Recent Appointments">
        <div className="overflow-x-auto">
          <table className="w-full text-left text-sm">
            <thead>
              <tr className="border-b border-slate-100 text-xs uppercase tracking-wide text-slate-400">
                <th className="px-4 py-2 font-medium">Patient ID</th>
                <th className="px-4 py-2 font-medium">Doctor ID</th>
                <th className="px-4 py-2 font-medium">Date</th>
                <th className="px-4 py-2 font-medium">Time</th>
                <th className="px-4 py-2 font-medium">Status</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-slate-100">
              {isLoading ? (
                <TableSkeletonRows columns={5} />
              ) : recentAppointments.length === 0 ? (
                <EmptyRow colSpan={5} message="No recent appointments." />
              ) : (
                recentAppointments.map((appointment) => (
                  <tr key={appointment.id}>
                    <td
                      className="px-4 py-3 font-['JetBrains_Mono',monospace] text-xs text-slate-600"
                      title={appointment.patientId}
                    >
                      {truncateId(appointment.patientId)}
                    </td>
                    <td
                      className="px-4 py-3 font-['JetBrains_Mono',monospace] text-xs text-slate-600"
                      title={appointment.doctorId}
                    >
                      {truncateId(appointment.doctorId)}
                    </td>
                    <td className="px-4 py-3 text-slate-600">{appointment.appointmentDate}</td>
                    <td className="px-4 py-3 text-slate-600">{appointment.startTime}</td>
                    <td className="px-4 py-3">
                      <StatusBadge value={appointment.status} styleMap={APPOINTMENT_STATUS_STYLES} />
                    </td>
                  </tr>
                ))
              )}
            </tbody>
          </table>
        </div>
      </SectionCard>

      <SectionCard title="Recent Bills">
        <div className="overflow-x-auto">
          <table className="w-full text-left text-sm">
            <thead>
              <tr className="border-b border-slate-100 text-xs uppercase tracking-wide text-slate-400">
                <th className="px-4 py-2 font-medium">Bill Number</th>
                <th className="px-4 py-2 font-medium">Patient ID</th>
                <th className="px-4 py-2 font-medium">Doctor ID</th>
                <th className="px-4 py-2 font-medium">Amount</th>
                <th className="px-4 py-2 font-medium">Status</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-slate-100">
              {isLoading ? (
                <TableSkeletonRows columns={5} />
              ) : recentBills.length === 0 ? (
                <EmptyRow colSpan={5} message="No recent bills." />
              ) : (
                recentBills.map((bill) => (
                  <tr key={bill.billNumber}>
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
                      <StatusBadge value={bill.paymentStatus} styleMap={PAYMENT_STATUS_STYLES} />
                    </td>
                  </tr>
                ))
              )}
            </tbody>
          </table>
        </div>
      </SectionCard>
    </div>
  );
}
