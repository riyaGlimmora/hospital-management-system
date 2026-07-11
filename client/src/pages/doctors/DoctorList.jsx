import { useCallback, useEffect, useState } from 'react';
import { Link } from 'react-router-dom';
import {
  Search,
  Plus,
  Eye,
  Pencil,
  Trash2,
  AlertCircle,
  RefreshCw,
  Stethoscope,
  ChevronLeft,
  ChevronRight,
  Check,
  X,
} from 'lucide-react';
import { getDoctors, searchDoctors, deleteDoctor, getDepartments } from '../../api/doctorApi';
import { useAuth } from '../../context/AuthContext';

const PAGE_SIZE = 10;

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

function formatCurrency(amount) {
  return new Intl.NumberFormat('en-IN', {
    style: 'currency',
    currency: 'INR',
    maximumFractionDigits: 0,
  }).format(amount ?? 0);
}

function TableSkeletonRows({ columns, rows = 6 }) {
  return Array.from({ length: rows }).map((_, rowIndex) => (
    <tr key={rowIndex}>
      {Array.from({ length: columns }).map((__, colIndex) => (
        <td key={colIndex} className="px-4 py-3">
          <div className="h-4 w-full max-w-[140px] animate-pulse rounded bg-slate-200" />
        </td>
      ))}
    </tr>
  ));
}

export default function DoctorList() {
  const { user } = useAuth();
  const canDelete = user?.role === 'admin';
  const [doctors, setDoctors] = useState([]);
  const [departments, setDepartments] = useState([]);
  const [departmentFilter, setDepartmentFilter] = useState('');
  const [meta, setMeta] = useState({ page: 1, limit: PAGE_SIZE, total: 0, totalPages: 1 });
  const [page, setPage] = useState(1);
  const [searchInput, setSearchInput] = useState('');
  const [debouncedSearch, setDebouncedSearch] = useState('');
  const [isLoading, setIsLoading] = useState(true);
  const [errorMessage, setErrorMessage] = useState('');
  const [confirmDeleteId, setConfirmDeleteId] = useState(null);
  const [deletingId, setDeletingId] = useState(null);

  useEffect(() => {
    getDepartments()
      .then((response) => setDepartments(response.data.data))
      .catch(() => setDepartments([]));
  }, []);

  useEffect(() => {
    const timer = setTimeout(() => {
      setDebouncedSearch(searchInput.trim());
      setPage(1);
    }, 400);
    return () => clearTimeout(timer);
  }, [searchInput]);

  const fetchDoctors = useCallback(async () => {
    setIsLoading(true);
    setErrorMessage('');
    try {
      const departmentId = departmentFilter || undefined;
      const response = debouncedSearch
        ? await searchDoctors({ search: debouncedSearch, page, limit: PAGE_SIZE, departmentId })
        : await getDoctors({ page, limit: PAGE_SIZE, departmentId });
      setDoctors(response.data.data.doctors);
      setMeta(response.data.data.meta);
    } catch (error) {
      setErrorMessage(
        error.response?.data?.message ?? 'Unable to load doctors right now.'
      );
    } finally {
      setIsLoading(false);
    }
  }, [debouncedSearch, page, departmentFilter]);

  useEffect(() => {
    fetchDoctors();
  }, [fetchDoctors]);

  async function handleConfirmDelete(id) {
    setDeletingId(id);
    try {
      await deleteDoctor(id);
      setConfirmDeleteId(null);
      if (doctors.length === 1 && page > 1) {
        setPage((prev) => prev - 1);
      } else {
        fetchDoctors();
      }
    } catch (error) {
      setErrorMessage(
        error.response?.data?.message ?? 'Unable to delete this doctor right now.'
      );
      setConfirmDeleteId(null);
    } finally {
      setDeletingId(null);
    }
  }

  if (errorMessage && doctors.length === 0 && !isLoading) {
    return (
      <div className="flex min-h-[60vh] flex-col items-center justify-center rounded-lg border border-red-100 bg-red-50/40 text-center">
        <AlertCircle className="text-red-500" size={32} />
        <p className="mt-3 font-['Manrope',sans-serif] text-base font-semibold text-slate-800">
          Couldn&apos;t load doctors
        </p>
        <p className="mt-1 max-w-sm text-sm text-slate-500">{errorMessage}</p>
        <button
          type="button"
          onClick={fetchDoctors}
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
            Doctors
          </h1>
          <p className="mt-1 text-sm text-slate-500">
            {meta.total} registered doctor{meta.total === 1 ? '' : 's'}
          </p>
        </div>
        <Link
          to="/doctors/new"
          className="inline-flex items-center justify-center gap-2 rounded-md bg-[#0F6B66] px-4 py-2.5 text-sm font-semibold text-white hover:bg-[#0C5450]"
        >
          <Plus size={16} />
          Add Doctor
        </Link>
      </div>

      <div className="rounded-lg border border-slate-200 bg-white">
        <div className="flex flex-col gap-3 border-b border-slate-100 px-5 py-4 sm:flex-row sm:items-center">
          <div className="relative w-full max-w-sm">
            <Search
              size={16}
              className="pointer-events-none absolute left-3 top-1/2 -translate-y-1/2 text-slate-400"
            />
            <input
              type="text"
              value={searchInput}
              onChange={(event) => setSearchInput(event.target.value)}
              placeholder="Search by name, specialization, or phone"
              className="w-full rounded-md border border-slate-300 bg-white py-2 pl-9 pr-3 text-sm text-slate-800 placeholder:text-slate-400 focus:border-[#0F6B66] focus:outline-none focus:ring-2 focus:ring-[#0F6B66]/20"
            />
          </div>
          <select
            value={departmentFilter}
            onChange={(event) => {
              setDepartmentFilter(event.target.value);
              setPage(1);
            }}
            className="rounded-md border border-slate-300 bg-white px-3 py-2 text-sm text-slate-700 focus:border-[#0F6B66] focus:outline-none focus:ring-2 focus:ring-[#0F6B66]/20"
          >
            <option value="">All departments</option>
            {departments.map((department) => (
              <option key={department.id} value={department.id}>
                {department.name}
              </option>
            ))}
          </select>
        </div>

        {errorMessage && doctors.length > 0 && (
          <div className="mx-5 mt-4 flex items-center gap-2 rounded-md border border-red-100 bg-red-50 px-4 py-3 text-sm text-red-600">
            <AlertCircle size={16} />
            {errorMessage}
          </div>
        )}

        <div className="overflow-x-auto">
          <table className="w-full text-left text-sm">
            <thead>
              <tr className="border-b border-slate-100 text-xs uppercase tracking-wide text-slate-400">
                <th className="px-4 py-3 font-medium">Doctor ID</th>
                <th className="px-4 py-3 font-medium">Full Name</th>
                <th className="px-4 py-3 font-medium">Department</th>
                <th className="px-4 py-3 font-medium">Specialization</th>
                <th className="px-4 py-3 font-medium">Phone</th>
                <th className="px-4 py-3 font-medium">Consultation Fee</th>
                <th className="px-4 py-3 font-medium">Status</th>
                <th className="px-4 py-3 font-medium text-right">Actions</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-slate-100">
              {isLoading ? (
                <TableSkeletonRows columns={8} />
              ) : doctors.length === 0 ? (
                <tr>
                  <td colSpan={8} className="px-4 py-14">
                    <div className="flex flex-col items-center justify-center text-center">
                      <div className="flex h-12 w-12 items-center justify-center rounded-full bg-slate-100 text-slate-400">
                        <Stethoscope size={22} />
                      </div>
                      <p className="mt-3 text-sm font-medium text-slate-600">
                        {debouncedSearch ? 'No doctors match your search.' : 'No doctors yet.'}
                      </p>
                      <p className="mt-1 text-sm text-slate-400">
                        {debouncedSearch
                          ? 'Try a different name, specialization, or phone number.'
                          : 'Add your first doctor to get started.'}
                      </p>
                    </div>
                  </td>
                </tr>
              ) : (
                doctors.map((doctor) => (
                  <tr key={doctor.id}>
                    <td className="px-4 py-3 font-['JetBrains_Mono',monospace] text-xs text-slate-600">
                      {doctor.doctorId}
                    </td>
                    <td className="px-4 py-3 font-medium text-slate-800">{doctor.fullName}</td>
                    <td className="px-4 py-3 text-slate-600">{doctor.departmentName ?? '—'}</td>
                    <td className="px-4 py-3 text-slate-600">{doctor.specialization}</td>
                    <td className="px-4 py-3 text-slate-600">{doctor.phone}</td>
                    <td className="px-4 py-3 text-slate-600">
                      {formatCurrency(doctor.consultationFee)}
                    </td>
                    <td className="px-4 py-3">
                      <StatusBadge isActive={doctor.isActive} />
                    </td>
                    <td className="px-4 py-3">
                      {confirmDeleteId === doctor.id && canDelete ? (
                        <div className="flex items-center justify-end gap-2">
                          <span className="text-xs text-slate-500">Delete?</span>
                          <button
                            type="button"
                            onClick={() => handleConfirmDelete(doctor.id)}
                            disabled={deletingId === doctor.id}
                            className="flex h-7 w-7 items-center justify-center rounded-md bg-red-600 text-white hover:bg-red-700 disabled:opacity-60"
                          >
                            <Check size={14} />
                          </button>
                          <button
                            type="button"
                            onClick={() => setConfirmDeleteId(null)}
                            className="flex h-7 w-7 items-center justify-center rounded-md border border-slate-200 text-slate-500 hover:bg-slate-50"
                          >
                            <X size={14} />
                          </button>
                        </div>
                      ) : (
                        <div className="flex items-center justify-end gap-1.5">
                          <Link
                            to={`/doctors/${doctor.id}`}
                            className="flex h-8 w-8 items-center justify-center rounded-md text-slate-400 hover:bg-slate-100 hover:text-slate-700"
                            title="View doctor"
                          >
                            <Eye size={16} />
                          </Link>
                          <Link
                            to={`/doctors/${doctor.id}/edit`}
                            className="flex h-8 w-8 items-center justify-center rounded-md text-slate-400 hover:bg-slate-100 hover:text-slate-700"
                            title="Edit doctor"
                          >
                            <Pencil size={16} />
                          </Link>
                          {canDelete && (
                            <button
                              type="button"
                              onClick={() => setConfirmDeleteId(doctor.id)}
                              className="flex h-8 w-8 items-center justify-center rounded-md text-slate-400 hover:bg-red-50 hover:text-red-600"
                              title="Delete doctor"
                            >
                              <Trash2 size={16} />
                            </button>
                          )}
                        </div>
                      )}
                    </td>
                  </tr>
                ))
              )}
            </tbody>
          </table>
        </div>

        {!isLoading && doctors.length > 0 && (
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
