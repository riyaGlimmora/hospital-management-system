import { useState } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import { ArrowLeft, Loader2 } from 'lucide-react';
import { createPatient } from '../../api/patientApi';

const BLOOD_GROUPS = ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'];

const INITIAL_FORM = {
  fullName: '',
  gender: '',
  dateOfBirth: '',
  phone: '',
  email: '',
  address: '',
  bloodGroup: '',
  emergencyContactName: '',
  emergencyContactPhone: '',
};

function FieldError({ message }) {
  if (!message) {
    return null;
  }
  return <p className="mt-1 text-xs text-red-600">{message}</p>;
}

export default function AddPatient() {
  const [form, setForm] = useState(INITIAL_FORM);
  const [fieldErrors, setFieldErrors] = useState({});
  const [errorMessage, setErrorMessage] = useState('');
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [duplicateWarning, setDuplicateWarning] = useState(null);

  const navigate = useNavigate();

  function updateField(field, value) {
    setForm((prev) => ({ ...prev, [field]: value }));
  }

  async function submitPatient({ confirmDuplicate }) {
    const payload = {
      ...form,
      email: form.email.trim() === '' ? undefined : form.email.trim(),
      bloodGroup: form.bloodGroup === '' ? undefined : form.bloodGroup,
      confirmDuplicate,
    };
    const response = await createPatient(payload);
    const newPatient = response.data.data;
    navigate(`/patients/${newPatient.id}`);
  }

  async function handleSubmit(event) {
    event.preventDefault();
    setErrorMessage('');
    setFieldErrors({});
    setDuplicateWarning(null);
    setIsSubmitting(true);

    try {
      await submitPatient({ confirmDuplicate: false });
    } catch (error) {
      const backendErrors = error.response?.data?.errors;
      const duplicateError = Array.isArray(backendErrors)
        ? backendErrors.find((item) => item.field === 'duplicate')
        : null;

      if (duplicateError) {
        setDuplicateWarning({
          message: error.response.data.message,
          existingPatientId: duplicateError.existingPatientId,
        });
        return;
      }

      if (Array.isArray(backendErrors) && backendErrors.length > 0) {
        const mapped = {};
        backendErrors.forEach((item) => {
          mapped[item.field] = item.message;
        });
        setFieldErrors(mapped);
      }
      setErrorMessage(
        error.response?.data?.message ?? 'Unable to save this patient right now.'
      );
    } finally {
      setIsSubmitting(false);
    }
  }

  async function handleConfirmDuplicate() {
    setIsSubmitting(true);
    setErrorMessage('');
    try {
      await submitPatient({ confirmDuplicate: true });
    } catch (error) {
      setDuplicateWarning(null);
      setErrorMessage(
        error.response?.data?.message ?? 'Unable to save this patient right now.'
      );
    } finally {
      setIsSubmitting(false);
    }
  }

  return (
    <div className="mx-auto max-w-3xl space-y-6">
      <div>
        <Link
          to="/patients"
          className="inline-flex items-center gap-1.5 text-sm font-medium text-slate-500 hover:text-slate-700"
        >
          <ArrowLeft size={15} />
          Back to Patients
        </Link>
        <h1 className="mt-3 font-['Manrope',sans-serif] text-2xl font-semibold text-slate-800">
          Add Patient
        </h1>
        <p className="mt-1 text-sm text-slate-500">
          Register a new patient with their contact and emergency details.
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

        {duplicateWarning && (
          <div className="rounded-md border border-amber-200 bg-amber-50 px-4 py-3 text-sm text-amber-800">
            <p className="font-medium">{duplicateWarning.message}</p>
            <p className="mt-1 text-amber-700">
              This may be the same person, or a different patient with a matching name and
              phone number or date of birth. Check the existing record before continuing.
            </p>
            <div className="mt-3 flex flex-wrap gap-2">
              {duplicateWarning.existingPatientId && (
                <Link
                  to={`/patients/${duplicateWarning.existingPatientId}`}
                  className="rounded-md border border-amber-300 bg-white px-3 py-1.5 text-sm font-medium text-amber-800 hover:bg-amber-100"
                >
                  View existing patient
                </Link>
              )}
              <button
                type="button"
                onClick={handleConfirmDuplicate}
                disabled={isSubmitting}
                className="rounded-md bg-amber-600 px-3 py-1.5 text-sm font-medium text-white hover:bg-amber-700 disabled:opacity-60"
              >
                Register as new patient anyway
              </button>
              <button
                type="button"
                onClick={() => setDuplicateWarning(null)}
                className="rounded-md border border-slate-300 bg-white px-3 py-1.5 text-sm font-medium text-slate-600 hover:bg-slate-50"
              >
                Cancel
              </button>
            </div>
          </div>
        )}

        <div>
          <h2 className="font-['Manrope',sans-serif] text-sm font-semibold uppercase tracking-wide text-slate-400">
            Personal Details
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
              <label htmlFor="dateOfBirth" className="block text-sm font-medium text-slate-700">
                Date of Birth
              </label>
              <input
                id="dateOfBirth"
                type="date"
                required
                max={new Date().toISOString().split('T')[0]}
                value={form.dateOfBirth}
                onChange={(event) => updateField('dateOfBirth', event.target.value)}
                className="mt-1.5 block w-full rounded-md border border-slate-300 bg-white px-3.5 py-2.5 text-sm text-slate-800 focus:border-[#0F6B66] focus:outline-none focus:ring-2 focus:ring-[#0F6B66]/20"
              />
              <FieldError message={fieldErrors.dateOfBirth} />
            </div>

            <div>
              <label htmlFor="bloodGroup" className="block text-sm font-medium text-slate-700">
                Blood Group <span className="text-slate-400">(optional)</span>
              </label>
              <select
                id="bloodGroup"
                value={form.bloodGroup}
                onChange={(event) => updateField('bloodGroup', event.target.value)}
                className="mt-1.5 block w-full rounded-md border border-slate-300 bg-white px-3.5 py-2.5 text-sm text-slate-800 focus:border-[#0F6B66] focus:outline-none focus:ring-2 focus:ring-[#0F6B66]/20"
              >
                <option value="">Unknown</option>
                {BLOOD_GROUPS.map((group) => (
                  <option key={group} value={group}>
                    {group}
                  </option>
                ))}
              </select>
              <FieldError message={fieldErrors.bloodGroup} />
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
                Email <span className="text-slate-400">(optional)</span>
              </label>
              <input
                id="email"
                type="email"
                value={form.email}
                onChange={(event) => updateField('email', event.target.value)}
                className="mt-1.5 block w-full rounded-md border border-slate-300 bg-white px-3.5 py-2.5 text-sm text-slate-800 focus:border-[#0F6B66] focus:outline-none focus:ring-2 focus:ring-[#0F6B66]/20"
              />
              <FieldError message={fieldErrors.email} />
            </div>

            <div className="sm:col-span-2">
              <label htmlFor="address" className="block text-sm font-medium text-slate-700">
                Address
              </label>
              <textarea
                id="address"
                required
                rows={3}
                value={form.address}
                onChange={(event) => updateField('address', event.target.value)}
                className="mt-1.5 block w-full rounded-md border border-slate-300 bg-white px-3.5 py-2.5 text-sm text-slate-800 focus:border-[#0F6B66] focus:outline-none focus:ring-2 focus:ring-[#0F6B66]/20"
              />
              <FieldError message={fieldErrors.address} />
            </div>
          </div>
        </div>

        <div>
          <h2 className="font-['Manrope',sans-serif] text-sm font-semibold uppercase tracking-wide text-slate-400">
            Emergency Contact
          </h2>
          <div className="mt-4 grid grid-cols-1 gap-5 sm:grid-cols-2">
            <div>
              <label
                htmlFor="emergencyContactName"
                className="block text-sm font-medium text-slate-700"
              >
                Contact Name
              </label>
              <input
                id="emergencyContactName"
                type="text"
                required
                value={form.emergencyContactName}
                onChange={(event) => updateField('emergencyContactName', event.target.value)}
                className="mt-1.5 block w-full rounded-md border border-slate-300 bg-white px-3.5 py-2.5 text-sm text-slate-800 focus:border-[#0F6B66] focus:outline-none focus:ring-2 focus:ring-[#0F6B66]/20"
              />
              <FieldError message={fieldErrors.emergencyContactName} />
            </div>

            <div>
              <label
                htmlFor="emergencyContactPhone"
                className="block text-sm font-medium text-slate-700"
              >
                Contact Phone
              </label>
              <input
                id="emergencyContactPhone"
                type="text"
                required
                value={form.emergencyContactPhone}
                onChange={(event) => updateField('emergencyContactPhone', event.target.value)}
                className="mt-1.5 block w-full rounded-md border border-slate-300 bg-white px-3.5 py-2.5 text-sm text-slate-800 focus:border-[#0F6B66] focus:outline-none focus:ring-2 focus:ring-[#0F6B66]/20"
              />
              <FieldError message={fieldErrors.emergencyContactPhone} />
            </div>
          </div>
        </div>

        <div className="flex items-center justify-end gap-3 border-t border-slate-100 pt-5">
          <Link
            to="/patients"
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
            {isSubmitting ? 'Saving…' : 'Save Patient'}
          </button>
        </div>
      </form>
    </div>
  );
}
