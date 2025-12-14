import React from "react";
import { BrowserRouter, Routes, Route, Navigate } from "react-router-dom";
import PageWrapper from "../layouts/PageWrapper";
import HomePage from "../pages/Home/HomePage";
import LoginPage from "../pages/auth/pages/LoginPage";
import AdminLayout from "../layouts/AdminLayout";
import Lession from "../pages/admin/lessions/Lessons";
import Dashboard from "../pages/admin/dashboard/Dashboard";
import ProtectedAdminRoute from "./ProtectedAdminRoute";
import VietnameseLearningApp from "../pages/studyVideo/VietnameseLearningApp";

const NotFoundPage = () => (
  <PageWrapper>
    <h1>404 - Trang không tồn tại</h1>
  </PageWrapper>
);
const token = localStorage.getItem("token");
const AppRoutes = () => (
  <BrowserRouter>
    <Routes>
      <Route
        path="/"
        element={
          <PageWrapper>
            <HomePage />
          </PageWrapper>
        }
      />
      <Route
        path="/video"
        element={
          token ? (
            <PageWrapper>
              <VietnameseLearningApp />
            </PageWrapper>
          ) : (
            <Navigate to="/login" replace />
          )
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
      <Route element={<ProtectedAdminRoute />}>
        <Route
          path="/admin/dashboard"
          element={
            <AdminLayout>
              <Dashboard />
            </AdminLayout>
          }
        />
        <Route
          path="/admin/lession"
          element={
            <AdminLayout>
              <Lession />
            </AdminLayout>
          }
        />
      </Route>

      <Route path="/404" element={<NotFoundPage />} />
      <Route path="*" element={<NotFoundPage />} />
    </Routes>
  </BrowserRouter>
);

export default AppRoutes;
