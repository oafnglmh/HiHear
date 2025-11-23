import { Award, BookOpen, Coffee, Home, Mail } from "lucide-react";
import React from "react";

export default function Header() {
  const [scrolled, setScrolled] = React.useState(false);

  React.useEffect(() => {
    const handleScroll = () => {
      setScrolled(window.scrollY > 50);
    };
    window.addEventListener("scroll", handleScroll);
    return () => window.removeEventListener("scroll", handleScroll);
  }, []);

  return (
    <header className={`header ${scrolled ? "scrolled" : ""}`}>
      <div className="logo-section">
        <img
          src="https://cdn-icons-png.flaticon.com/512/3898/3898082.png"
          alt="HiHear Logo"
          className="logo-image"
        />
        <h1 className="brand-name">HiHear</h1>
      </div>

      <nav className="nav-links">
        <a href="#home">
          <Home size={18} /> Trang chủ
        </a>
        <a href="#features">
          <BookOpen size={18} /> Tính năng
        </a>
        <a href="#culture">
          <Coffee size={18} /> Văn hóa
        </a>
        <a href="#rewards">
          <Award size={18} /> Thành tích
        </a>
        <a href="#contact">
          <Mail size={18} /> Liên hệ
        </a>
      </nav>

      <div className="auth-buttons">
        <a href="/login" className="btn-login">
          Đăng nhập
        </a>
        <a href="/register" className="btn-register">
          Đăng ký
        </a>
      </div>
    </header>
  );
}
