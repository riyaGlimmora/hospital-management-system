import { Routes, Route, Navigate } from 'react-router-dom';
import Login from '../pages/auth/Login';
import Register from '../pages/auth/Register';
import ProtectedRoute from './ProtectedRoute';
import RoleRoute from './RoleRoute';
import MainLayout from '../layouts/MainLayout';
import Dashboard from '../pages/dashboard/Dashboard';
import Unauthorized from '../pages/Unauthorized';
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
import AppointmentDetails from '../pages/appointments/AppointmentDetails';
import BillingList from '../pages/billing/BillingList';
import GenerateBill from '../pages/billing/GenerateBill';
import BillDetails from '../pages/billing/BillDetails';
import Profile from '../pages/profile/Profile';

const STAFF_ROLES = ['admin', 'receptionist'];

export default function AppRoutes() {
  return (
    <Routes>
      <Route path="/login" element={<Login />} />
      <Route path="/register" element={<Register />} />

      <Route element={<ProtectedRoute />}>
        <Route element={<MainLayout />}>
          <Route path="/" element={<Navigate to="/dashboard" replace />} />
          <Route path="/dashboard" element={<Dashboard />} />
          <Route path="/profile" element={<Profile />} />
          <Route path="/unauthorized" element={<Unauthorized />} />

          <Route path="/patients" element={<PatientList />} />
          <Route path="/patients/:id" element={<PatientDetails />} />
          <Route element={<RoleRoute allow={STAFF_ROLES} />}>
            <Route path="/patients/new" element={<AddPatient />} />
            <Route path="/patients/:id/edit" element={<EditPatient />} />
          </Route>

          <Route path="/doctors" element={<DoctorList />} />
          <Route path="/doctors/:id" element={<DoctorDetails />} />
          <Route element={<RoleRoute allow={STAFF_ROLES} />}>
            <Route path="/doctors/new" element={<AddDoctor />} />
            <Route path="/doctors/:id/edit" element={<EditDoctor />} />
          </Route>

          <Route path="/appointments" element={<AppointmentList />} />
          <Route path="/appointments/:id" element={<AppointmentDetails />} />
          <Route element={<RoleRoute allow={STAFF_ROLES} />}>
            <Route path="/appointments/new" element={<AddAppointment />} />
          </Route>

          <Route path="/billing" element={<BillingList />} />
          <Route path="/billing/:id" element={<BillDetails />} />
          <Route element={<RoleRoute allow={STAFF_ROLES} />}>
            <Route path="/billing/new" element={<GenerateBill />} />
          </Route>
        </Route>
      </Route>

      <Route path="*" element={<Navigate to="/dashboard" replace />} />
    </Routes>
  );
}
