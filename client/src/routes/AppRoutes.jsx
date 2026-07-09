import { Routes, Route, Navigate } from 'react-router-dom';
import Login from '../pages/auth/Login';
import ProtectedRoute from './ProtectedRoute';
import MainLayout from '../layouts/MainLayout';
import Dashboard from '../pages/dashboard/Dashboard';
import PatientList from '../pages/patients/PatientList';
import AddPatient from '../pages/patients/AddPatient';
import EditPatient from '../pages/patients/EditPatient';
import PatientDetails from '../pages/patients/PatientDetails';

function ComingSoon({ title }) {
  return (
    <div className="flex h-full min-h-[60vh] flex-col items-center justify-center rounded-lg border border-dashed border-slate-300 bg-white">
      <p className="font-['Manrope',sans-serif] text-lg font-semibold text-slate-700">
        {title}
      </p>
      <p className="mt-1 text-sm text-slate-400">This page is coming soon.</p>
    </div>
  );
}

export default function AppRoutes() {
  return (
    <Routes>
      <Route path="/login" element={<Login />} />

      <Route element={<ProtectedRoute />}>
        <Route element={<MainLayout />}>
          <Route path="/" element={<Navigate to="/dashboard" replace />} />
          <Route path="/dashboard" element={<Dashboard />} />
          <Route path="/patients" element={<PatientList />} />
          <Route path="/patients/new" element={<AddPatient />} />
          <Route path="/patients/:id" element={<PatientDetails />} />
          <Route path="/patients/:id/edit" element={<EditPatient />} />
          <Route path="/doctors" element={<ComingSoon title="Doctors" />} />
          <Route path="/appointments" element={<ComingSoon title="Appointments" />} />
          <Route path="/billing" element={<ComingSoon title="Billing" />} />
        </Route>
      </Route>

      <Route path="*" element={<Navigate to="/dashboard" replace />} />
    </Routes>
  );
}
