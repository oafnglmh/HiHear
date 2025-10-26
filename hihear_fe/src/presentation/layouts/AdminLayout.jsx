import React from "react";
import Sidebar from "./Sidebar";;
import "./css/AdminLayout.css";

export default function AdminLayout({ children }) {
  return (
    <div className="admin-layout">
      <Sidebar />
      <div className="admin-main">
        <main className="admin-content">{children}</main>
      </div>
    </div>
  );
}
