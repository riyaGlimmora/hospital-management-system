import { useState } from 'react';
import { NavLink, Outlet, Link } from 'react-router-dom';
import {
  LayoutDashboard,
  Users,
  Stethoscope,
  CalendarDays,
  Receipt,
  Menu,
  X,
  LogOut,
} from 'lucide-react';
import { useAuth } from '../context/AuthContext';

const NAV_ITEMS = [
  { to: '/dashboard', label: 'Dashboard', icon: LayoutDashboard },
  { to: '/patients', label: 'Patients', icon: Users },
  { to: '/doctors', label: 'Doctors', icon: Stethoscope },
  { to: '/appointments', label: 'Appointments', icon: CalendarDays },
  { to: '/billing', label: 'Billing', icon: Receipt },
];

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

export default function MainLayout() {
  const [isSidebarOpen, setIsSidebarOpen] = useState(false);
  const { user, logout } = useAuth();

  return (
    <div className="flex h-screen bg-[#F5F7F8] font-['Inter',sans-serif]">
      <div
        className={`fixed inset-0 z-30 bg-black/40 transition-opacity md:hidden ${
          isSidebarOpen ? 'opacity-100' : 'pointer-events-none opacity-0'
        }`}
        onClick={() => setIsSidebarOpen(false)}
      />

      <aside
        className={`fixed inset-y-0 left-0 z-40 flex w-64 flex-col bg-[#0B3B39] transition-transform duration-200 ease-out md:static md:translate-x-0 ${
          isSidebarOpen ? 'translate-x-0' : '-translate-x-full'
        }`}
      >
        <div className="flex items-center justify-between px-6 py-5">
          <span className="font-['Manrope',sans-serif] text-lg font-semibold tracking-tight text-white">
            MediCore HMS
          </span>
          <button
            type="button"
            className="text-white/70 hover:text-white md:hidden"
            onClick={() => setIsSidebarOpen(false)}
          >
            <X size={20} />
          </button>
        </div>

        <nav className="mt-2 flex-1 space-y-1 px-3">
          {NAV_ITEMS.map(({ to, label, icon: Icon }) => (
            <NavLink
              key={to}
              to={to}
              onClick={() => setIsSidebarOpen(false)}
              className={({ isActive }) =>
                `group relative flex items-center gap-3 rounded-md px-3 py-2.5 text-sm font-medium transition-colors ${
                  isActive
                    ? 'bg-white/10 text-white'
                    : 'text-white/60 hover:bg-white/5 hover:text-white'
                }`
              }
            >
              {({ isActive }) => (
                <>
                  <span
                    className={`absolute left-0 top-1/2 h-5 -translate-y-1/2 rounded-r-full bg-[#D9A441] transition-all ${
                      isActive ? 'w-1' : 'w-0'
                    }`}
                  />
                  <Icon size={18} strokeWidth={2} />
                  {label}
                </>
              )}
            </NavLink>
          ))}
        </nav>

        <div className="border-t border-white/10 px-6 py-4">
          <p className="text-xs text-white/40">MediCore Hospital Management</p>
        </div>
      </aside>

      <div className="flex flex-1 flex-col overflow-hidden">
        <header className="flex items-center justify-between border-b border-slate-200 bg-white px-4 py-3 md:px-6">
          <button
            type="button"
            className="text-slate-500 hover:text-slate-700 md:hidden"
            onClick={() => setIsSidebarOpen(true)}
          >
            <Menu size={22} />
          </button>

          <div className="hidden md:block" />

          <div className="flex items-center gap-3">
            <Link
              to="/profile"
              className="hidden text-right sm:block hover:opacity-80"
            >
              <p className="text-sm font-medium text-slate-800">{user?.fullName ?? 'User'}</p>
              <p className="text-xs capitalize text-slate-400">{user?.role ?? ''}</p>
            </Link>
            <Link
              to="/profile"
              className="flex h-9 w-9 items-center justify-center rounded-full bg-[#0F6B66] text-sm font-semibold text-white hover:opacity-90"
            >
              {getInitials(user?.fullName)}
            </Link>
            <button
              type="button"
              onClick={logout}
              className="ml-2 flex items-center gap-1.5 rounded-md px-3 py-2 text-sm font-medium text-slate-500 transition-colors hover:bg-slate-100 hover:text-slate-800"
            >
              <LogOut size={16} />
              <span className="hidden sm:inline">Logout</span>
            </button>
          </div>
        </header>

        <main className="flex-1 overflow-y-auto p-4 md:p-8">
          <Outlet />
        </main>
      </div>
    </div>
  );
}
