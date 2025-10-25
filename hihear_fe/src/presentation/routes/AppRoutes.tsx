import React from "react";
import { BrowserRouter, Routes, Route } from "react-router-dom";
import PageWrapper from "../layouts/PageWrapper";
import HomePage from "../pages/Home/HomePage";
import LoginPage from "../pages/auth/pages/LoginPage";

const AppRoutes: React.FC = () => (
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
        path="/login"
        element={
          <PageWrapper>
            <LoginPage />
          </PageWrapper>
        }
      />
    </Routes>
  </BrowserRouter>
);

export default AppRoutes;
