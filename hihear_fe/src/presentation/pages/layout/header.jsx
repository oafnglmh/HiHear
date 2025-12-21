import React, { useState, useEffect } from "react";
import {
  Award,
  BookOpen,
  Coffee,
  Home,
  Mail,
  PlayCircle,
  LogOut,
  Menu,
  X,
} from "lucide-react";
import { useAuth } from "../auth/hooks/useAuth";
import { AppAssets } from "../../../Core/constant/AppAssets";

export default function Header() {
  const [scrolled, setScrolled] = useState(false);
  const { logout } = useAuth();
  const [user, setUser] = useState(() => {
    const storedUser = localStorage.getItem("user");
    return storedUser ? JSON.parse(storedUser) : null;
  });

  useEffect(() => {
    const handleScroll = () => {
      setScrolled(window.scrollY > 50);
    };

    window.addEventListener("scroll", handleScroll);
    return () => window.removeEventListener("scroll", handleScroll);
  }, []);

  const handleLogout = () => {
    logout();
    setUser(null);
  };

  const navItems = [
    { path: "/", icon: Home, label: "Trang chủ" },
    { path: "/#features", icon: BookOpen, label: "Tính năng" },
    { path: "/#culture", icon: Coffee, label: "Văn hóa" },
    { path: "/#rewards", icon: Award, label: "Thành tích" },
    { path: "/#contact", icon: Mail, label: "Liên hệ" },
    { path: "/video", icon: PlayCircle, label: "Học qua video" },
  ];

  const NavLink = ({ item, onClick }) => {
    const Icon = item.icon;
    return (
      <a
        href={item.path}
        onClick={onClick}
        className="flex items-center gap-2 px-4 py-2 rounded-lg transition-all duration-300 hover:bg-blue-50 hover:text-blue-600 text-gray-700"
      >
        <Icon size={18} />
        <span className="font-medium">{item.label}</span>
      </a>
    );
  };

  return (
    <header
      className={`fixed top-0 left-0 right-0 z-50 transition-all duration-300 ${
        scrolled
          ? "bg-white shadow-lg py-3"
          : "bg-white/95 backdrop-blur-sm py-4"
      }`}
    >
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="flex items-center justify-between">
          <a href="/" className="flex items-center gap-3 group">
            <div className="relative">
              <img
                src={AppAssets.logo}
                alt="HiHear Logo"
                className="w-20 h-15 transition-transform duration-300 group-hover:scale-110"
              />
            </div>
            <h1 className="text-2xl font-bold bg-gradient-to-r from-blue-600 to-purple-600 bg-clip-text text-transparent">
              HiHear
            </h1>
          </a>

          <nav className="hidden lg:flex items-center gap-1">
            {navItems.map((item, index) => (
              <NavLink key={index} item={item} />
            ))}
          </nav>

          <div className="hidden lg:flex items-center gap-3">
            {!user ? (
              <>
                <a
                  href="/login"
                  className="px-5 py-2 bg-gradient-to-r from-blue-600 to-purple-600 text-white font-medium rounded-lg hover:shadow-lg hover:scale-105 transition-all duration-300"
                >
                  Đăng nhập
                </a>
              </>
            ) : (
              <div className="flex items-center gap-3 pl-3 pr-2 py-2 rounded-full bg-gradient-to-r from-blue-50 to-purple-50 border border-blue-100">
                <img
                  src={
                    user.avatarUrl ||
                    `https://ui-avatars.com/api/?name=${user.firstName}&background=4F46E5&color=fff&bold=true`
                  }
                  alt="User avatar"
                  className="w-8 h-8 rounded-full border-2 border-white shadow-sm"
                />
                <span className="font-medium text-gray-700">
                  {user.firstName}
                </span>
                <button
                  onClick={handleLogout}
                  className="p-2 rounded-full hover:bg-red-100 text-red-600 transition-colors duration-300"
                  aria-label="Đăng xuất"
                >
                  <LogOut size={18} />
                </button>
              </div>
            )}
          </div>
        </div>
      </div>

      <style>{`
        @keyframes fade-in {
          from {
            opacity: 0;
            transform: translateY(-10px);
          }
          to {
            opacity: 1;
            transform: translateY(0);
          }
        }

        .animate-fade-in {
          animation: fade-in 0.3s ease-out;
        }
      `}</style>
    </header>
  );
}
