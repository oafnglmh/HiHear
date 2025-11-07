import React, { useState } from "react";
import "./css/users.css";
import {
  Users as UsersIcon,
  CheckCircle,
  UserPlus,
  Search,
  BookOpen,
  User,
  Trash2,
  Edit2,
  Eye,
  Zap,
  UserCheck,
  UserX,
  Star,
} from "lucide-react";

export default function Users() {
  const [searchTerm, setSearchTerm] = useState("");
  const [filterRole, setFilterRole] = useState("all");

  const users = [
    {
      id: 1,
      name: "Nguyễn Văn An",
      email: "nguyenvanan@email.com",
      role: "student",
      level: "Sơ cấp",
      lessons: 12,
      status: "active",
      joined: "15/10/2024",
    },
    {
      id: 2,
      name: "Trần Thị Bình",
      email: "tranthib@email.com",
      role: "student",
      level: "Trung cấp",
      lessons: 28,
      status: "active",
      joined: "20/09/2024",
    },
    {
      id: 3,
      name: "Lê Văn Cường",
      email: "levanc@email.com",
      role: "teacher",
      level: "Giáo viên",
      lessons: 45,
      status: "active",
      joined: "05/08/2024",
    },
    // ... các user khác
  ];

  const filteredUsers = users.filter((user) => {
    const matchesSearch =
      user.name.toLowerCase().includes(searchTerm.toLowerCase()) ||
      user.email.toLowerCase().includes(searchTerm.toLowerCase());
    const matchesRole = filterRole === "all" || user.role === filterRole;
    return matchesSearch && matchesRole;
  });

  return (
    <div className="users-container">
      {/* Header */}
      <div className="users-header">
        <div className="header-content">
          <h1 className="users-title">
            <UsersIcon size={28} className="lucide-icon" />
            Quản Lý Người Dùng
            <UsersIcon size={28} className="lucide-icon" />
          </h1>
          <p className="users-subtitle">
            Quản lý và theo dõi tất cả người dùng trong hệ thống HiHear
          </p>
        </div>
        <div className="header-pattern"></div>
      </div>

      {/* Stats */}
      <div className="users-stats">
        <div className="stat-box stat-total">
          <UserCheck className="stat-icon" size={32} />
          <div className="stat-info">
            <h3 className="stat-number">1,234</h3>
            <p className="stat-label">Tổng học viên</p>
          </div>
        </div>
        <div className="stat-box stat-active">
          <CheckCircle className="stat-icon" size={32} />
          <div className="stat-info">
            <h3 className="stat-number">892</h3>
            <p className="stat-label">Đang hoạt động</p>
          </div>
        </div>
        <div className="stat-box stat-new">
          <Star className="stat-icon" size={32} />
          <div className="stat-info">
            <h3 className="stat-number">45</h3>
            <p className="stat-label">Mới tuần này</p>
          </div>
        </div>
        <div className="stat-box stat-teachers">
          <User className="stat-icon" size={32} />
          <div className="stat-info">
            <h3 className="stat-number">24</h3>
            <p className="stat-label">Giáo viên</p>
          </div>
        </div>
      </div>

      {/* Toolbar */}
      <div className="users-card">
        <div className="users-toolbar">
          <div className="toolbar-left">
            <div className="search-box">
              <Search size={20} className="search-icon" />
              <input
                type="text"
                placeholder="Tìm kiếm theo tên hoặc email..."
                value={searchTerm}
                onChange={(e) => setSearchTerm(e.target.value)}
                className="search-input"
              />
            </div>
            <div className="filter-box">
              <span className="filter-label">Vai trò:</span>
              <select
                value={filterRole}
                onChange={(e) => setFilterRole(e.target.value)}
                className="filter-select"
              >
                <option value="all">Tất cả</option>
                <option value="student">Học viên</option>
                <option value="teacher">Giáo viên</option>
                <option value="admin">Quản trị</option>
              </select>
            </div>
          </div>
          <button className="add-user-btn">
            <UserPlus size={20} />
            Thêm người dùng
          </button>
        </div>

        {/* Table */}
        <div className="table-container">
          <table className="users-table">
            <thead>
              <tr>
                <th>ID</th>
                <th>Họ và tên</th>
                <th>Email</th>
                <th>Vai trò</th>
                <th>Trình độ</th>
                <th>Bài học</th>
                <th>Trạng thái</th>
                <th>Tham gia</th>
                <th>Thao tác</th>
              </tr>
            </thead>
            <tbody>
              {filteredUsers.map((user) => (
                <tr key={user.id} className="table-row">
                  <td className="user-id">#{user.id}</td>
                  <td className="user-name">
                    <div className="name-cell">
                      <div className="user-avatar">{user.name.charAt(0)}</div>
                      <span>{user.name}</span>
                    </div>
                  </td>
                  <td className="user-email">{user.email}</td>
                  <td>
                    <span className={`role-badge role-${user.role}`}>
                      {user.role === "student" && "Học viên"}
                      {user.role === "teacher" && "Giáo viên"}
                      {user.role === "admin" && "Quản trị"}
                    </span>
                  </td>
                  <td className="user-level">{user.level}</td>
                  <td className="user-lessons">{user.lessons} bài</td>
                  <td>
                    <span className={`status-badge status-${user.status}`}>
                      {user.status === "active"
                        ? "Hoạt động"
                        : "Không hoạt động"}
                    </span>
                  </td>
                  <td className="user-joined">{user.joined}</td>
                  <td className="user-actions">
                    <button
                      className="action-btn view-btn"
                      title="Xem chi tiết"
                      style={{
                        border: "none",
                        background: "transparent",
                        cursor: "pointer",
                        padding: "6px",
                        borderRadius: "4px",
                      }}
                    >
                      <Eye size={18} style={{ color: "#3b82f6" }} />
                    </button>

                    <button
                      className="action-btn edit-btn"
                      title="Chỉnh sửa"
                      style={{
                        border: "none",
                        background: "transparent",
                        cursor: "pointer",
                        padding: "6px",
                        borderRadius: "4px",
                      }}
                    >
                      <Edit2 size={18} style={{ color: "#f59e0b" }} />
                    </button>

                    <button
                      className="action-btn delete-btn"
                      title="Xóa"
                      style={{
                        border: "none",
                        background: "transparent",
                        cursor: "pointer",
                        padding: "6px",
                        borderRadius: "4px",
                      }}
                    >
                      <Trash2 size={18} style={{ color: "#ef4444" }} />
                    </button>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>

        <div className="pagination">
          <button className="page-btn">« Trước</button>
          <button className="page-btn active">1</button>
          <button className="page-btn">2</button>
          <button className="page-btn">3</button>
          <button className="page-btn">Sau »</button>
        </div>
      </div>
    </div>
  );
}
