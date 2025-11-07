import React from "react";
import { BrowserRouter, Routes, Route } from "react-router-dom";
import PageWrapper from "../layouts/PageWrapper";
import HomePage from "../pages/Home/HomePage";
import LoginPage from "../pages/auth/pages/LoginPage";
import AdminLayout from "../layouts/AdminLayout";
import Lession from "../pages/admin/lessions/Lessons";
import Dashboard from "../pages/admin/dashboard/Dashboard";
import Users from "../pages/admin/users/Users";

const AppRoutes = () => (
  <BrowserRouter>
    <Routes>
      {/* Public routes */}
      <Route
        path="/"
        element={
          <PageWrapper>
            <HomePage />
          </PageWrapper>
        }
      />
      <Route
        path="/login"
        element={
          <PageWrapper>
            <LoginPage />
          </PageWrapper>
        }
      />

      {/* Admin routes */}
      <Route
        path="/admin/*"
        element={
          <AdminLayout>
            <Routes>
              <Route path="dashboard" element={<Dashboard />} />
              <Route path="users" element={<Users />} />
              <Route path="lession" element={<Lession />} />
            </Routes>
          </AdminLayout>
        }
      />
    </Routes>
  </BrowserRouter>
);

export default AppRoutes;
