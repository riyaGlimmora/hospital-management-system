import { Navigate, Outlet } from 'react-router-dom';
import { useAuth } from '../context/AuthContext';

/**
 * Gates a route to a set of allowed roles. Must be nested inside ProtectedRoute
 * so `user` is guaranteed to exist. Redirects to /unauthorized otherwise.
 *
 * Usage: <Route element={<RoleRoute allow={['admin', 'receptionist']} />}>
 */
export default function RoleRoute({ allow = [] }) {
  const { user } = useAuth();

  if (!user || !allow.includes(user.role)) {
    return <Navigate to="/unauthorized" replace />;
  }

  return <Outlet />;
}
