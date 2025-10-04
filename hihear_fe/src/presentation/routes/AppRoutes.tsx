import React from "react";
import { BrowserRouter, Routes, Route } from "react-router-dom";
import PageWrapper from "../layouts/PageWrapper";
import HomePage from "../pages/HomePage";

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
    </Routes>
  </BrowserRouter>
);

export default AppRoutes;
