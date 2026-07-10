import { useState } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import { Eye, EyeOff, Loader2, HeartPulse } from 'lucide-react';
import api from '../../api/axios';

const ROLES = [
  { value: 'receptionist', label: 'Receptionist' },
  { value: 'doctor', label: 'Doctor' },
  { value: 'admin', label: 'Admin' },
];

export default function Register() {
  const [fullName, setFullName] = useState('');
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [role, setRole] = useState('receptionist');
  const [showPassword, setShowPassword] = useState(false);
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [errorMessage, setErrorMessage] = useState('');
  const [fieldErrors, setFieldErrors] = useState({});

  const navigate = useNavigate();

  async function handleSubmit(event) {
    event.preventDefault();
    setErrorMessage('');
    setFieldErrors({});
    setIsSubmitting(true);

    try {
      await api.post('/auth/register', { fullName, email, password, role });
      navigate('/login', {
        replace: true,
        state: { registered: true },
      });
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
        error.response?.data?.message ?? 'Something went wrong. Please try again.'
      );
    } finally {
      setIsSubmitting(false);
    }
  }

  return (
    <div className="flex min-h-screen font-['Inter',sans-serif]">
      <div className="relative hidden w-1/2 flex-col justify-between bg-[#0B3B39] px-12 py-10 lg:flex">
        <div className="flex items-center gap-2 text-white">
          <HeartPulse size={26} className="text-[#D9A441]" />
          <span className="font-['Manrope',sans-serif] text-xl font-semibold tracking-tight">
            MediCore HMS
          </span>
        </div>

        <div className="max-w-md">
          <h1 className="font-['Manrope',sans-serif] text-3xl font-semibold leading-tight text-white">
            One workspace for
            <br />
            your whole front desk.
          </h1>
          <p className="mt-4 text-sm leading-relaxed text-white/60">
            Create an account to manage patients, doctors, appointments, and
            billing from a single, reliable workspace.
          </p>
        </div>

        <p className="text-xs text-white/30">
          &copy; {new Date().getFullYear()} MediCore Hospital Management System
        </p>

        <div className="pointer-events-none absolute -right-24 -top-24 h-72 w-72 rounded-full bg-[#D9A441]/10" />
        <div className="pointer-events-none absolute -bottom-16 right-10 h-40 w-40 rounded-full bg-white/5" />
      </div>

      <div className="flex w-full flex-col justify-center bg-[#F5F7F8] px-6 py-12 sm:px-12 lg:w-1/2 lg:px-20">
        <div className="mx-auto w-full max-w-sm">
          <div className="mb-8 flex items-center gap-2 lg:hidden">
            <HeartPulse size={24} className="text-[#0F6B66]" />
            <span className="font-['Manrope',sans-serif] text-lg font-semibold tracking-tight text-slate-800">
              MediCore HMS
            </span>
          </div>

          <h2 className="font-['Manrope',sans-serif] text-2xl font-semibold text-slate-800">
            Create an account
          </h2>
          <p className="mt-1.5 text-sm text-slate-500">
            Set up staff access to the system.
          </p>

          <form className="mt-8 space-y-5" onSubmit={handleSubmit}>
            {errorMessage && (
              <div className="rounded-md border border-red-100 bg-red-50 px-4 py-3 text-sm text-red-600">
                {errorMessage}
              </div>
            )}

            <div>
              <label htmlFor="fullName" className="block text-sm font-medium text-slate-700">
                Full name
              </label>
              <input
                id="fullName"
                type="text"
                autoComplete="name"
                required
                value={fullName}
                onChange={(event) => setFullName(event.target.value)}
                placeholder="Dr. Ananya Sharma"
                className="mt-1.5 block w-full rounded-md border border-slate-300 bg-white px-3.5 py-2.5 text-sm text-slate-800 placeholder:text-slate-400 focus:border-[#0F6B66] focus:outline-none focus:ring-2 focus:ring-[#0F6B66]/20"
              />
              {fieldErrors.fullName && (
                <p className="mt-1 text-xs text-red-600">{fieldErrors.fullName}</p>
              )}
            </div>

            <div>
              <label htmlFor="email" className="block text-sm font-medium text-slate-700">
                Email address
              </label>
              <input
                id="email"
                type="email"
                autoComplete="email"
                required
                value={email}
                onChange={(event) => setEmail(event.target.value)}
                placeholder="you@hospital.test"
                className="mt-1.5 block w-full rounded-md border border-slate-300 bg-white px-3.5 py-2.5 text-sm text-slate-800 placeholder:text-slate-400 focus:border-[#0F6B66] focus:outline-none focus:ring-2 focus:ring-[#0F6B66]/20"
              />
              {fieldErrors.email && (
                <p className="mt-1 text-xs text-red-600">{fieldErrors.email}</p>
              )}
            </div>

            <div>
              <label htmlFor="role" className="block text-sm font-medium text-slate-700">
                Role
              </label>
              <select
                id="role"
                required
                value={role}
                onChange={(event) => setRole(event.target.value)}
                className="mt-1.5 block w-full rounded-md border border-slate-300 bg-white px-3.5 py-2.5 text-sm text-slate-800 focus:border-[#0F6B66] focus:outline-none focus:ring-2 focus:ring-[#0F6B66]/20"
              >
                {ROLES.map((option) => (
                  <option key={option.value} value={option.value}>
                    {option.label}
                  </option>
                ))}
              </select>
            </div>

            <div>
              <label htmlFor="password" className="block text-sm font-medium text-slate-700">
                Password
              </label>
              <div className="relative mt-1.5">
                <input
                  id="password"
                  type={showPassword ? 'text' : 'password'}
                  autoComplete="new-password"
                  required
                  value={password}
                  onChange={(event) => setPassword(event.target.value)}
                  placeholder="••••••••"
                  className="block w-full rounded-md border border-slate-300 bg-white px-3.5 py-2.5 pr-10 text-sm text-slate-800 placeholder:text-slate-400 focus:border-[#0F6B66] focus:outline-none focus:ring-2 focus:ring-[#0F6B66]/20"
                />
                <button
                  type="button"
                  onClick={() => setShowPassword((prev) => !prev)}
                  className="absolute inset-y-0 right-0 flex items-center pr-3 text-slate-400 hover:text-slate-600"
                  tabIndex={-1}
                >
                  {showPassword ? <EyeOff size={18} /> : <Eye size={18} />}
                </button>
              </div>
              {fieldErrors.password ? (
                <p className="mt-1 text-xs text-red-600">{fieldErrors.password}</p>
              ) : (
                <p className="mt-1.5 text-xs text-slate-400">
                  8-64 characters, with an uppercase letter, a lowercase letter, a number, and a symbol.
                </p>
              )}
            </div>

            <button
              type="submit"
              disabled={isSubmitting}
              className="flex w-full items-center justify-center gap-2 rounded-md bg-[#0F6B66] px-4 py-2.5 text-sm font-semibold text-white transition-colors hover:bg-[#0C5450] disabled:cursor-not-allowed disabled:opacity-60"
            >
              {isSubmitting && <Loader2 size={16} className="animate-spin" />}
              {isSubmitting ? 'Creating account…' : 'Create account'}
            </button>

            <p className="text-center text-sm text-slate-500">
              Already have an account?{' '}
              <Link to="/login" className="font-medium text-[#0F6B66] hover:underline">
                Sign in
              </Link>
            </p>
          </form>
        </div>
      </div>
    </div>
  );
}
