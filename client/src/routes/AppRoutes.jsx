import { Routes, Route, Navigate } from 'react-router-dom';
import Login from '../pages/auth/Login';
import ProtectedRoute from './ProtectedRoute';
import MainLayout from '../layouts/MainLayout';
import Dashboard from '../pages/dashboard/Dashboard';
import PatientList from '../pages/patients/PatientList';
import AddPatient from '../pages/patients/AddPatient';
import EditPatient from '../pages/patients/EditPatient';
import PatientDetails from '../pages/patients/PatientDetails';
import DoctorList from '../pages/doctors/DoctorList';
import AddDoctor from '../pages/doctors/AddDoctor';
import EditDoctor from '../pages/doctors/EditDoctor';
import DoctorDetails from '../pages/doctors/DoctorDetails';
import AppointmentList from '../pages/appointments/AppointmentList';
import AddAppointment from '../pages/appointments/AddAppointment';
import BillingList from '../pages/billing/BillingList';
import GenerateBill from '../pages/billing/GenerateBill';

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

          <Route path="/doctors" element={<DoctorList />} />
          <Route path="/doctors/new" element={<AddDoctor />} />
          <Route path="/doctors/:id" element={<DoctorDetails />} />
          <Route path="/doctors/:id/edit" element={<EditDoctor />} />

          <Route path="/appointments" element={<AppointmentList />} />
          <Route path="/appointments/new" element={<AddAppointment />} />

          <Route path="/billing" element={<BillingList />} />
          <Route path="/billing/new" element={<GenerateBill />} />
        </Route>
      </Route>

      <Route path="*" element={<Navigate to="/dashboard" replace />} />
    </Routes>
  );
}
