import React from "react";
import "./css/Dashboard.css";
import {
  Users,
  Book,
  Zap,
  CheckCircle,
  BarChart2,
  Star,
  Plus,
  Settings,
  PieChart,
  Info,
} from "lucide-react";
export default function Dashboard() {
  return (
    <div className="dashboard-container">
      {/* Header */}
      <div className="dashboard-header">
        <div className="header-content">
          <h1 className="dashboard-title">
            <span className="bamboo-decoration">🎋</span>
            Tổng Quan Hệ Thống
            <span className="bamboo-decoration">🎋</span>
          </h1>
          <p className="dashboard-subtitle">
            Chào mừng đến với HiHear Admin Dashboard
          </p>
        </div>
        <div className="header-pattern"></div>
      </div>

      <div className="stats-grid">
        <div className="stat-card stat-card-users">
          <Users className="stat-icon" size={36} />
          <div className="stat-content">
            <h3 className="stat-number">3</h3>
            <p className="stat-label">Người học</p>
          </div>
          <div className="stat-trend positive">+12%</div>
        </div>

        <div className="stat-card stat-card-lessons">
          <Book className="stat-icon" size={36} />
          <div className="stat-content">
            <h3 className="stat-number">48</h3>
            <p className="stat-label">Bài học</p>
          </div>
          <div className="stat-trend positive">+5</div>
        </div>

        <div className="stat-card stat-card-active">
          <Zap className="stat-icon" size={36} />
          <div className="stat-content">
            <h3 className="stat-number">1</h3>
            <p className="stat-label">Đang hoạt động</p>
          </div>
          <div className="stat-trend positive">+8%</div>
        </div>

        <div className="stat-card stat-card-completed">
          <CheckCircle className="stat-icon" size={36} />
          <div className="stat-content">
            <h3 className="stat-number">40</h3>
            <p className="stat-label">Hoàn thành</p>
          </div>
          <div className="stat-trend positive">+23%</div>
        </div>
      </div>
    </div>
  );
}
