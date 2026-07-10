import { UserCircle, Mail, ShieldCheck, LogOut } from 'lucide-react';
import { useAuth } from '../../context/AuthContext';

const ROLE_STYLES = {
  admin: 'bg-[#D9A441]/10 text-[#8a6a1f] border-[#D9A441]/30',
  receptionist: 'bg-blue-50 text-blue-700 border-blue-100',
  doctor: 'bg-emerald-50 text-emerald-700 border-emerald-100',
};

function getInitials(name) {
  if (!name) {
    return '?';
  }
  return name
    .split(' ')
    .filter(Boolean)
    .slice(0, 2)
    .map((part) => part[0].toUpperCase())
    .join('');
}

function InfoRow({ icon: Icon, label, value }) {
  return (
    <div className="flex items-center gap-3 border-b border-slate-100 px-5 py-4 last:border-b-0">
      <div className="flex h-9 w-9 shrink-0 items-center justify-center rounded-full bg-slate-100 text-slate-500">
        <Icon size={16} />
      </div>
      <div>
        <p className="text-xs font-medium uppercase tracking-wide text-slate-400">{label}</p>
        <p className="mt-0.5 text-sm text-slate-800">{value ?? '—'}</p>
      </div>
    </div>
  );
}

export default function Profile() {
  const { user, logout } = useAuth();

  const roleStyle = ROLE_STYLES[user?.role] ?? 'bg-slate-50 text-slate-600 border-slate-200';

  return (
    <div className="mx-auto max-w-2xl space-y-6">
      <div>
        <h1 className="font-['Manrope',sans-serif] text-2xl font-semibold text-slate-800">
          Profile
        </h1>
        <p className="mt-1 text-sm text-slate-500">Your account details.</p>
      </div>

      <div className="rounded-lg border border-slate-200 bg-white p-6">
        <div className="flex items-center gap-4">
          <div className="flex h-16 w-16 items-center justify-center rounded-full bg-[#0F6B66] text-xl font-semibold text-white">
            {getInitials(user?.fullName)}
          </div>
          <div>
            <h2 className="font-['Manrope',sans-serif] text-lg font-semibold text-slate-800">
              {user?.fullName ?? 'User'}
            </h2>
            <span
              className={`mt-1 inline-flex items-center rounded-full border px-2.5 py-0.5 text-xs font-medium capitalize ${roleStyle}`}
            >
              {user?.role ?? '—'}
            </span>
          </div>
        </div>
      </div>

      <div className="rounded-lg border border-slate-200 bg-white">
        <InfoRow icon={UserCircle} label="Full Name" value={user?.fullName} />
        <InfoRow icon={Mail} label="Email" value={user?.email} />
        <InfoRow icon={ShieldCheck} label="Role" value={user?.role ? user.role.charAt(0).toUpperCase() + user.role.slice(1) : '—'} />
      </div>

      <div className="rounded-lg border border-slate-200 bg-white p-5">
        <p className="text-sm text-slate-500">
          Signed in on this device. Signing out will end your current session.
        </p>
        <button
          type="button"
          onClick={logout}
          className="mt-4 flex items-center gap-2 rounded-md border border-red-100 px-4 py-2.5 text-sm font-medium text-red-600 hover:bg-red-50"
        >
          <LogOut size={16} />
          Sign out
        </button>
      </div>
    </div>
  );
}
