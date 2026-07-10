import { Link } from 'react-router-dom';
import { ShieldAlert } from 'lucide-react';

export default function Unauthorized() {
  return (
    <div className="flex min-h-[70vh] flex-col items-center justify-center text-center">
      <div className="flex h-14 w-14 items-center justify-center rounded-full bg-red-50 text-red-500">
        <ShieldAlert size={28} />
      </div>
      <h1 className="mt-4 font-['Manrope',sans-serif] text-xl font-semibold text-slate-800">
        You don&apos;t have access to this page
      </h1>
      <p className="mt-1.5 max-w-sm text-sm text-slate-500">
        Your role doesn&apos;t have permission to view this section. Contact an
        administrator if you think this is a mistake.
      </p>
      <Link
        to="/dashboard"
        className="mt-6 inline-flex items-center gap-2 rounded-md bg-[#0F6B66] px-4 py-2.5 text-sm font-semibold text-white hover:bg-[#0C5450]"
      >
        Back to Dashboard
      </Link>
    </div>
  );
}
