import { useEffect, useState } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import { ArrowLeft, Loader2 } from 'lucide-react';
import { createDoctor, getDepartments } from '../../api/doctorApi';

const CONSULT_DAY_OPTIONS = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

const INITIAL_FORM = {
  fullName: '',
  specialization: '',
  departmentId: '',
  qualification: '',
  experienceYears: '',
  consultationFee: '',
  gender: '',
  phone: '',
  email: '',
  consultStartTime: '',
  consultEndTime: '',
  consultDays: [],
};

function FieldError({ message }) {
  if (!message) {
    return null;
  }
  return <p className="mt-1 text-xs text-red-600">{message}</p>;
}

export default function AddDoctor() {
  const [form, setForm] = useState(INITIAL_FORM);
  const [departments, setDepartments] = useState([]);
  const [fieldErrors, setFieldErrors] = useState({});
  const [errorMessage, setErrorMessage] = useState('');
  const [isSubmitting, setIsSubmitting] = useState(false);

  const navigate = useNavigate();

  useEffect(() => {
    getDepartments()
      .then((response) => setDepartments(response.data.data))
      .catch(() => setDepartments([]));
  }, []);

  function updateField(field, value) {
    setForm((prev) => ({ ...prev, [field]: value }));
  }

  function toggleConsultDay(day) {
    setForm((prev) => ({
      ...prev,
      consultDays: prev.consultDays.includes(day)
        ? prev.consultDays.filter((d) => d !== day)
        : [...prev.consultDays, day],
    }));
  }

  async function handleSubmit(event) {
    event.preventDefault();
    setErrorMessage('');
    setFieldErrors({});
    setIsSubmitting(true);

    try {
      const payload = {
        ...form,
        departmentId: Number(form.departmentId),
        experienceYears: Number(form.experienceYears),
        consultationFee: Number(form.consultationFee),
      };
      const response = await createDoctor(payload);
      const newDoctor = response.data.data;
      navigate(`/doctors/${newDoctor.id}`);
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
        error.response?.data?.message ?? 'Unable to save this doctor right now.'
      );
    } finally {
      setIsSubmitting(false);
    }
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
          Add Doctor
        </h1>
        <p className="mt-1 text-sm text-slate-500">
          Register a new doctor with their professional and contact details.
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
              <label htmlFor="departmentId" className="block text-sm font-medium text-slate-700">
                Department
              </label>
              <select
                id="departmentId"
                required
                value={form.departmentId}
                onChange={(event) => updateField('departmentId', event.target.value)}
                className="mt-1.5 block w-full rounded-md border border-slate-300 bg-white px-3.5 py-2.5 text-sm text-slate-800 focus:border-[#0F6B66] focus:outline-none focus:ring-2 focus:ring-[#0F6B66]/20"
              >
                <option value="" disabled>
                  Select department
                </option>
                {departments.map((department) => (
                  <option key={department.id} value={department.id}>
                    {department.name}
                  </option>
                ))}
              </select>
              <FieldError message={fieldErrors.departmentId} />
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

        <div>
          <h2 className="font-['Manrope',sans-serif] text-sm font-semibold uppercase tracking-wide text-slate-400">
            Consultation Schedule
          </h2>
          <div className="mt-4 grid grid-cols-1 gap-5 sm:grid-cols-2">
            <div>
              <label htmlFor="consultStartTime" className="block text-sm font-medium text-slate-700">
                Consultation Start Time
              </label>
              <input
                id="consultStartTime"
                type="time"
                required
                value={form.consultStartTime}
                onChange={(event) => updateField('consultStartTime', event.target.value)}
                className="mt-1.5 block w-full rounded-md border border-slate-300 bg-white px-3.5 py-2.5 text-sm text-slate-800 focus:border-[#0F6B66] focus:outline-none focus:ring-2 focus:ring-[#0F6B66]/20"
              />
              <FieldError message={fieldErrors.consultStartTime} />
            </div>

            <div>
              <label htmlFor="consultEndTime" className="block text-sm font-medium text-slate-700">
                Consultation End Time
              </label>
              <input
                id="consultEndTime"
                type="time"
                required
                value={form.consultEndTime}
                onChange={(event) => updateField('consultEndTime', event.target.value)}
                className="mt-1.5 block w-full rounded-md border border-slate-300 bg-white px-3.5 py-2.5 text-sm text-slate-800 focus:border-[#0F6B66] focus:outline-none focus:ring-2 focus:ring-[#0F6B66]/20"
              />
              <FieldError message={fieldErrors.consultEndTime} />
            </div>
          </div>

          <div className="mt-5">
            <span className="block text-sm font-medium text-slate-700">Consultation Days</span>
            <div className="mt-2 flex flex-wrap gap-2">
              {CONSULT_DAY_OPTIONS.map((day) => {
                const isSelected = form.consultDays.includes(day);
                return (
                  <button
                    key={day}
                    type="button"
                    onClick={() => toggleConsultDay(day)}
                    className={`rounded-md border px-3 py-1.5 text-sm font-medium transition-colors ${
                      isSelected
                        ? 'border-[#0F6B66] bg-[#0F6B66]/10 text-[#0F6B66]'
                        : 'border-slate-300 text-slate-500 hover:bg-slate-50'
                    }`}
                  >
                    {day}
                  </button>
                );
              })}
            </div>
            <FieldError message={fieldErrors.consultDays} />
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
            {isSubmitting ? 'Saving…' : 'Save Doctor'}
          </button>
        </div>
      </form>
    </div>
  );
}
