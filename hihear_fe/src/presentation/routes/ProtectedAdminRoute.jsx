import React from "react";
import { Navigate, Outlet } from "react-router-dom";

const ProtectedAdminRoute = () => {
  const token = localStorage.getItem("token");
  const userRole = localStorage.getItem("role");

  if (!token || userRole !== "ADMIN") {
    return <Navigate to="/404" replace />;
  }
  return <Outlet />;
};

export default ProtectedAdminRoute;
