import React, { useState } from "react";
import { NavLink } from "react-router-dom";
import {
  Home,
  Users,
  Settings,
  Menu,
  LogOut,
  Star,
  Book,
} from "lucide-react";
import "./css/Sidebar.css";

export default function Sidebar() {
  const [isOpen, setIsOpen] = useState(true);

  return (
    <aside className={`sidebar ${isOpen ? "open" : "collapsed"}`}>
      <div className="sidebar-header">

        <button
          className="sidebar-toggle"
          onClick={() => setIsOpen(!isOpen)}
          aria-label="Toggle sidebar"
        >
          <Menu />
        </button>

        <div className="sidebar-logo sidebar-link">
          <span>HiHear</span>
        </div>
      </div>

      <nav className="sidebar-nav">
        <NavLink
          to="/admin/dashboard"
          className={({ isActive }) =>
            `sidebar-link ${isActive ? "active" : ""}`
          }
        >
          <Home className="icon" />
          <span>Trang chủ</span>
        </NavLink>

        <NavLink
          to="/admin/users"
          className={({ isActive }) =>
            `sidebar-link ${isActive ? "active" : ""}`
          }
        >
          <Users className="icon" />
          <span>Người dùng</span>
        </NavLink>

        <NavLink
          to="/admin/lession"
          className={({ isActive }) =>
            `sidebar-link ${isActive ? "active" : ""}`
          }
        >
          <Book className="icon" />
          <span>Bài học</span>
        </NavLink>

        <NavLink
          to="/admin/settings"
          className={({ isActive }) =>
            `sidebar-link ${isActive ? "active" : ""}`
          }
        >
          <Settings className="icon" />
          <span>Cài đặt</span>
        </NavLink>
      </nav>

      <div className="sidebar-footer">
        <button className="logout-btn sidebar-link">
          <LogOut className="icon" size={18} />
          <span>Đăng xuất</span>
        </button>
        
      </div>
    </aside>
  );
}
