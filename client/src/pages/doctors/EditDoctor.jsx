import { useCallback, useEffect, useState } from 'react';
import { Link, useNavigate, useParams } from 'react-router-dom';
import { ArrowLeft, Loader2, AlertCircle, RefreshCw } from 'lucide-react';
import { getDoctorById, updateDoctor } from '../../api/doctorApi';

const EMPTY_FORM = {
  fullName: '',
  specialization: '',
  qualification: '',
  experienceYears: '',
  consultationFee: '',
  gender: '',
  phone: '',
  email: '',
};

function FieldError({ message }) {
  if (!message) {
    return null;
  }
  return <p className="mt-1 text-xs text-red-600">{message}</p>;
}

export default function EditDoctor() {
  const { id } = useParams();
  const navigate = useNavigate();

  const [form, setForm] = useState(EMPTY_FORM);
  const [fieldErrors, setFieldErrors] = useState({});
  const [errorMessage, setErrorMessage] = useState('');
  const [isLoading, setIsLoading] = useState(true);
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [loadError, setLoadError] = useState('');

  const fetchDoctor = useCallback(async () => {
    setIsLoading(true);
    setLoadError('');
    try {
      const response = await getDoctorById(id);
      const doctor = response.data.data;
      setForm({
        fullName: doctor.fullName ?? '',
        specialization: doctor.specialization ?? '',
        qualification: doctor.qualification ?? '',
        experienceYears: doctor.experienceYears ?? '',
        consultationFee: doctor.consultationFee ?? '',
        gender: doctor.gender ?? '',
        phone: doctor.phone ?? '',
        email: doctor.email ?? '',
      });
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
        ...form,
        experienceYears: Number(form.experienceYears),
        consultationFee: Number(form.consultationFee),
      };
      await updateDoctor(id, payload);
      navigate(`/doctors/${id}`);
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
        error.response?.data?.message ?? 'Unable to update this doctor right now.'
      );
    } finally {
      setIsSubmitting(false);
    }
  }

  if (isLoading) {
    return (
      <div className="mx-auto max-w-3xl space-y-6">
        <div className="h-6 w-40 animate-pulse rounded bg-slate-200" />
        <div className="space-y-6 rounded-lg border border-slate-200 bg-white p-6">
          {Array.from({ length: 4 }).map((_, index) => (
            <div key={index} className="grid grid-cols-1 gap-5 sm:grid-cols-2">
              <div className="h-10 animate-pulse rounded bg-slate-200" />
              <div className="h-10 animate-pulse rounded bg-slate-200" />
            </div>
          ))}
        </div>
      </div>
    );
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
      <div>
        <Link
          to="/doctors"
          className="inline-flex items-center gap-1.5 text-sm font-medium text-slate-500 hover:text-slate-700"
        >
          <ArrowLeft size={15} />
          Back to Doctors
        </Link>
        <h1 className="mt-3 font-['Manrope',sans-serif] text-2xl font-semibold text-slate-800">
          Edit Doctor
        </h1>
        <p className="mt-1 text-sm text-slate-500">
          Update {form.fullName || 'this doctor'}&apos;s professional and contact details.
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
            Professional Details
          </h2>
          <div className="mt-4 grid grid-cols-1 gap-5 sm:grid-cols-2">
            <div>
              <label htmlFor="fullName" className="block text-sm font-medium text-slate-700">
                Full Name
              </label>
              <input
                id="fullName"
                type="text"
                required
                value={form.fullName}
                onChange={(event) => updateField('fullName', event.target.value)}
                className="mt-1.5 block w-full rounded-md border border-slate-300 bg-white px-3.5 py-2.5 text-sm text-slate-800 focus:border-[#0F6B66] focus:outline-none focus:ring-2 focus:ring-[#0F6B66]/20"
              />
              <FieldError message={fieldErrors.fullName} />
            </div>

            <div>
              <label htmlFor="gender" className="block text-sm font-medium text-slate-700">
                Gender
              </label>
              <select
                id="gender"
                required
                value={form.gender}
                onChange={(event) => updateField('gender', event.target.value)}
                className="mt-1.5 block w-full rounded-md border border-slate-300 bg-white px-3.5 py-2.5 text-sm text-slate-800 focus:border-[#0F6B66] focus:outline-none focus:ring-2 focus:ring-[#0F6B66]/20"
              >
                <option value="" disabled>
                  Select gender
                </option>
                <option value="Male">Male</option>
                <option value="Female">Female</option>
                <option value="Other">Other</option>
              </select>
              <FieldError message={fieldErrors.gender} />
            </div>

            <div>
              <label htmlFor="specialization" className="block text-sm font-medium text-slate-700">
                Specialization
              </label>
              <input
                id="specialization"
                type="text"
                required
                value={form.specialization}
                onChange={(event) => updateField('specialization', event.target.value)}
                className="mt-1.5 block w-full rounded-md border border-slate-300 bg-white px-3.5 py-2.5 text-sm text-slate-800 focus:border-[#0F6B66] focus:outline-none focus:ring-2 focus:ring-[#0F6B66]/20"
              />
              <FieldError message={fieldErrors.specialization} />
            </div>

            <div>
              <label htmlFor="qualification" className="block text-sm font-medium text-slate-700">
                Qualification
              </label>
              <input
                id="qualification"
                type="text"
                required
                value={form.qualification}
                onChange={(event) => updateField('qualification', event.target.value)}
                className="mt-1.5 block w-full rounded-md border border-slate-300 bg-white px-3.5 py-2.5 text-sm text-slate-800 focus:border-[#0F6B66] focus:outline-none focus:ring-2 focus:ring-[#0F6B66]/20"
              />
              <FieldError message={fieldErrors.qualification} />
            </div>

            <div>
              <label
                htmlFor="experienceYears"
                className="block text-sm font-medium text-slate-700"
              >
                Experience (Years)
              </label>
              <input
                id="experienceYears"
                type="number"
                min="0"
                required
                value={form.experienceYears}
                onChange={(event) => updateField('experienceYears', event.target.value)}
                className="mt-1.5 block w-full rounded-md border border-slate-300 bg-white px-3.5 py-2.5 text-sm text-slate-800 focus:border-[#0F6B66] focus:outline-none focus:ring-2 focus:ring-[#0F6B66]/20"
              />
              <FieldError message={fieldErrors.experienceYears} />
            </div>

            <div>
              <label
                htmlFor="consultationFee"
                className="block text-sm font-medium text-slate-700"
              >
                Consultation Fee
              </label>
              <input
                id="consultationFee"
                type="number"
                min="0"
                step="0.01"
                required
                value={form.consultationFee}
                onChange={(event) => updateField('consultationFee', event.target.value)}
                className="mt-1.5 block w-full rounded-md border border-slate-300 bg-white px-3.5 py-2.5 text-sm text-slate-800 focus:border-[#0F6B66] focus:outline-none focus:ring-2 focus:ring-[#0F6B66]/20"
              />
              <FieldError message={fieldErrors.consultationFee} />
            </div>
          </div>
        </div>

        <div>
          <h2 className="font-['Manrope',sans-serif] text-sm font-semibold uppercase tracking-wide text-slate-400">
            Contact Details
          </h2>
          <div className="mt-4 grid grid-cols-1 gap-5 sm:grid-cols-2">
            <div>
              <label htmlFor="phone" className="block text-sm font-medium text-slate-700">
                Phone
              </label>
              <input
                id="phone"
                type="text"
                required
                value={form.phone}
                onChange={(event) => updateField('phone', event.target.value)}
                className="mt-1.5 block w-full rounded-md border border-slate-300 bg-white px-3.5 py-2.5 text-sm text-slate-800 focus:border-[#0F6B66] focus:outline-none focus:ring-2 focus:ring-[#0F6B66]/20"
              />
              <FieldError message={fieldErrors.phone} />
            </div>

            <div>
              <label htmlFor="email" className="block text-sm font-medium text-slate-700">
                Email
              </label>
              <input
                id="email"
                type="email"
                required
                value={form.email}
                onChange={(event) => updateField('email', event.target.value)}
                className="mt-1.5 block w-full rounded-md border border-slate-300 bg-white px-3.5 py-2.5 text-sm text-slate-800 focus:border-[#0F6B66] focus:outline-none focus:ring-2 focus:ring-[#0F6B66]/20"
              />
              <FieldError message={fieldErrors.email} />
            </div>
          </div>
        </div>

        <div className="flex items-center justify-end gap-3 border-t border-slate-100 pt-5">
          <Link
            to="/doctors"
            className="rounded-md px-4 py-2.5 text-sm font-medium text-slate-500 hover:bg-slate-100 hover:text-slate-700"
          >
            Cancel
          </Link>
          <button
            type="submit"
            disabled={isSubmitting}
            className="flex items-center justify-center gap-2 rounded-md bg-[#0F6B66] px-5 py-2.5 text-sm font-semibold text-white transition-colors hover:bg-[#0C5450] disabled:cursor-not-allowed disabled:opacity-60"
          >
            {isSubmitting && <Loader2 size={16} className="animate-spin" />}
            {isSubmitting ? 'Saving…' : 'Save Changes'}
          </button>
        </div>
      </form>
    </div>
  );
}
