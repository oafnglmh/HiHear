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
          <p className="dashboard-subtitle">Chào mừng đến với HiHear Admin Dashboard</p>
        </div>
        <div className="header-pattern"></div>
      </div>

      <div className="stats-grid">
        <div className="stat-card stat-card-users">
          <Users className="stat-icon" size={36} />
          <div className="stat-content">
            <h3 className="stat-number">1,234</h3>
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
            <h3 className="stat-number">892</h3>
            <p className="stat-label">Đang hoạt động</p>
          </div>
          <div className="stat-trend positive">+8%</div>
        </div>

        <div className="stat-card stat-card-completed">
          <CheckCircle className="stat-icon" size={36} />
          <div className="stat-content">
            <h3 className="stat-number">3,567</h3>
            <p className="stat-label">Hoàn thành</p>
          </div>
          <div className="stat-trend positive">+23%</div>
        </div>
      </div>

      {/* Main Content Grid */}
      <div className="content-grid">
        {/* Recent Activities */}
        <div className="dashboard-card recent-activities">
          <div className="card-header">
            <h2 className="card-title">
              <PieChart className="title-icon" size={20} />
              Hoạt động gần đây
            </h2>
          </div>
          <div className="card-content">
            <div className="activity-item">
              <div className="activity-dot"></div>
              <div className="activity-info">
                <p className="activity-text">Nguyễn Văn A đã hoàn thành bài học "Chào hỏi"</p>
                <span className="activity-time">5 phút trước</span>
              </div>
            </div>
            <div className="activity-item">
              <div className="activity-dot"></div>
              <div className="activity-info">
                <p className="activity-text">Trần Thị B đã đăng ký khóa học mới</p>
                <span className="activity-time">15 phút trước</span>
              </div>
            </div>
            <div className="activity-item">
              <div className="activity-dot"></div>
              <div className="activity-info">
                <p className="activity-text">Lê Văn C đã đạt 100 điểm bài kiểm tra</p>
                <span className="activity-time">30 phút trước</span>
              </div>
            </div>
            <div className="activity-item">
              <div className="activity-dot"></div>
              <div className="activity-info">
                <p className="activity-text">Phạm Thị D đã bắt đầu học bài "Số đếm"</p>
                <span className="activity-time">1 giờ trước</span>
              </div>
            </div>
            <div className="activity-item">
              <div className="activity-dot"></div>
              <div className="activity-info">
                <p className="activity-text">Hoàng Văn E đã nhận huy hiệu "Siêng năng"</p>
                <span className="activity-time">2 giờ trước</span>
              </div>
            </div>
          </div>
        </div>

        <div className="dashboard-card popular-lessons">
          <div className="card-header">
            <h2 className="card-title">
              <Star className="title-icon" size={20} />
              Bài học phổ biến
            </h2>
          </div>
          <div className="card-content">
            <div className="lesson-item">
              <div className="lesson-rank">1</div>
              <div className="lesson-info">
                <p className="lesson-name">Chào hỏi & Giới thiệu</p>
                <div className="lesson-progress">
                  <div className="progress-bar" style={{width: '85%'}}></div>
                </div>
              </div>
              <span className="lesson-count">456 học viên</span>
            </div>
            <div className="lesson-item">
              <div className="lesson-rank">2</div>
              <div className="lesson-info">
                <p className="lesson-name">Số đếm từ 1-100</p>
                <div className="lesson-progress">
                  <div className="progress-bar" style={{width: '72%'}}></div>
                </div>
              </div>
              <span className="lesson-count">389 học viên</span>
            </div>
            <div className="lesson-item">
              <div className="lesson-rank">3</div>
              <div className="lesson-info">
                <p className="lesson-name">Gia đình & Người thân</p>
                <div className="lesson-progress">
                  <div className="progress-bar" style={{width: '68%'}}></div>
                </div>
              </div>
              <span className="lesson-count">334 học viên</span>
            </div>
            <div className="lesson-item">
              <div className="lesson-rank">4</div>
              <div className="lesson-info">
                <p className="lesson-name">Đồ ăn & Thức uống</p>
                <div className="lesson-progress">
                  <div className="progress-bar" style={{width: '55%'}}></div>
                </div>
              </div>
              <span className="lesson-count">278 học viên</span>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}