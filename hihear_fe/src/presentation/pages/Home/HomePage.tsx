import React, { useEffect, useRef, useState } from "react";
import {
  BookOpen,
  Star,
  BarChart3,
  Users,
  Mail,
  Phone,
  Globe,
  Award,
  CheckCircle,
  ClipboardList,
  Heart,
  Zap,
  Music,
  Download,
  Smartphone,
  PlayCircle,
  MessageCircle,
  Target,
  TrendingUp,
  Headphones,
  Coffee,
  UtensilsCrossed,
  Mountain,
  Home,
  ChevronRight,
  Apple,
  Volume, VolumeX
} from "lucide-react";
import "./css/home.css";
import { AppAssets } from "../../../Core/constant/AppAssets";
const TypingText = () => {
  const texts = ["Dễ dàng!", "Thú vị!", "Hiệu quả!"];
  const [textIndex, setTextIndex] = useState(0);
  const [displayText, setDisplayText] = useState("");
  const [isDeleting, setIsDeleting] = useState(false);
  const [charIndex, setCharIndex] = useState(0);

  useEffect(() => {
    const currentText = texts[textIndex];
    const speed = isDeleting ? 50 : 100;

    const timer = setTimeout(() => {
      if (!isDeleting) {
        if (charIndex < currentText.length) {
          setDisplayText(currentText.slice(0, charIndex + 1));
          setCharIndex(charIndex + 1);
        } else {
          setTimeout(() => setIsDeleting(true), 2000);
        }
      } else {
        if (charIndex > 0) {
          setDisplayText(currentText.slice(0, charIndex - 1));
          setCharIndex(charIndex - 1);
        } else {
          setIsDeleting(false);
          setTextIndex((textIndex + 1) % texts.length);
        }
      }
    }, speed);

    return () => clearTimeout(timer);
  }, [charIndex, isDeleting, textIndex]);

  return (
    <span className="typing-text">
      {displayText}
      <span className="cursor">|</span>
    </span>
  );
};

const RewardCard = ({ icon: Icon, title, desc, percent, color }) => {
  const [progress, setProgress] = useState(0);
  const [isVisible, setIsVisible] = useState(false);

  useEffect(() => {
    setIsVisible(true);
    const timer = setTimeout(() => setProgress(percent), 300);
    return () => clearTimeout(timer);
  }, [percent]);

  return (
    <div
      className={`reward-card reward-card-${color} ${
        isVisible ? "fade-in" : ""
      }`}
    >
      <div className="reward-icon-wrapper">
        <Icon className="reward-icon" />
      </div>
      <div className="reward-content">
        <h3 className="reward-title">{title}</h3>
        <p className="reward-desc">{desc}</p>
        <div className="progress-bar">
          <div
            className={`progress-fill progress-${color}`}
            style={{ width: `${progress}%` }}
          />
        </div>
        <span className="progress-text">{percent}% hoàn thành</span>
      </div>
    </div>
  );
};

const App = () => {
  const [scrolled, setScrolled] = useState(false);
  const [showDownloadPage, setShowDownloadPage] = useState(false);

  useEffect(() => {
    const handleScroll = () => {
      setScrolled(window.scrollY > 50);
    };
    window.addEventListener("scroll", handleScroll);
    return () => window.removeEventListener("scroll", handleScroll);
  }, []);
  const videoRef = useRef<HTMLVideoElement>(null);
  const [isMuted, setIsMuted] = useState(true);
  const toggleSound = () => {
    if (videoRef.current) {
      videoRef.current.muted = !videoRef.current.muted;
      setIsMuted(videoRef.current.muted);
      if (!videoRef.current.paused) {
        videoRef.current.play();
      }
    }
  };
  if (showDownloadPage) {
    return (
      <div className="download-page">
        <div className="bamboo-bg" />
        <div className="download-container">
          <button
            className="back-button"
            onClick={() => setShowDownloadPage(false)}
          >
            <Home size={20} />
            Về trang chủ
          </button>

          <div className="download-content">
            <div className="download-hero">
              <div className="download-badge">
                <Download size={20} />
                Tải xuống ứng dụng
              </div>

              <h1 className="download-title">
                Trải nghiệm HiHear
                <br />
                trên điện thoại của bạn
              </h1>

              <p className="download-subtitle">
                Học tiếng Việt mọi lúc, mọi nơi với ứng dụng HiHear. Tải ngay để
                bắt đầu hành trình khám phá ngôn ngữ và văn hóa Việt Nam!
              </p>

              <div className="download-buttons">
                <a
                  href="https://play.google.com/store"
                  className="store-button"
                  target="_blank"
                  rel="noopener noreferrer"
                >
                  <div className="store-icon">
                    <PlayCircle size={30} />
                  </div>
                  <div className="store-info">
                    <div className="store-label">Tải trên</div>
                    <div className="store-name">Google Play</div>
                  </div>
                  <ChevronRight size={24} color="#1a5f3f" />
                </a>

                <a
                  href="https://www.apple.com/app-store/"
                  className="store-button"
                  target="_blank"
                  rel="noopener noreferrer"
                >
                  <div className="store-icon">
                    <Apple size={30} />
                  </div>
                  <div className="store-info">
                    <div className="store-label">Tải trên</div>
                    <div className="store-name">App Store</div>
                  </div>
                  <ChevronRight size={24} color="#1a5f3f" />
                </a>
              </div>
            </div>

            <div className="download-features">
              <div className="feature-list">
                <div className="feature-item">
                  <div className="feature-icon">
                    <Smartphone size={28} />
                  </div>
                  <div className="feature-text">
                    <h3>Giao diện thân thiện</h3>
                    <p>Thiết kế trực quan, dễ sử dụng cho mọi lứa tuổi</p>
                  </div>
                </div>

                <div className="feature-item">
                  <div className="feature-icon">
                    <Headphones size={28} />
                  </div>
                  <div className="feature-text">
                    <h3>Phát âm chuẩn</h3>
                    <p>Luyện nghe và nói với giọng người Việt bản địa</p>
                  </div>
                </div>

                <div className="feature-item">
                  <div className="feature-icon">
                    <Target size={28} />
                  </div>
                  <div className="feature-text">
                    <h3>Học có mục tiêu</h3>
                    <p>Đặt mục tiêu và theo dõi tiến độ mỗi ngày</p>
                  </div>
                </div>

                <div className="feature-item">
                  <div className="feature-icon">
                    <TrendingUp size={28} />
                  </div>
                  <div className="feature-text">
                    <h3>Tiến bộ nhanh chóng</h3>
                    <p>Phương pháp học hiện đại, hiệu quả cao</p>
                  </div>
                </div>
              </div>
            </div>
          </div>

          <div className="app-screenshots">
            <div className="screenshot-card">
              <img
                src="https://images.unsplash.com/photo-1512941937669-90a1b58e7e9c?w=400"
                alt="App Screenshot 1"
              />
              <div className="screenshot-label">Màn hình chính</div>
            </div>
            <div className="screenshot-card">
              <img
                src="https://images.unsplash.com/photo-1551650975-87deedd944c3?w=400"
                alt="App Screenshot 2"
              />
              <div className="screenshot-label">Bài học</div>
            </div>
            <div className="screenshot-card">
              <img
                src="https://images.unsplash.com/photo-1551836022-d5d88e9218df?w=400"
                alt="App Screenshot 3"
              />
              <div className="screenshot-label">Thành tích</div>
            </div>
          </div>
        </div>
      </div>
    );
  }

  return (
    <div className="app-container">
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
          <a href="/login" className="btn-register">
            Đăng ký
          </a>
        </div>
      </header>
      <section id="home" className="hero">
        <div className="hero-content">
          <h1 className="hero-title">
            Học tiếng Việt
            <br />
            từ cơ bản đến nâng cao
            <br />
            <TypingText />
          </h1>

          <p className="hero-subtitle">
            Ứng dụng học tiếng Việt hiện đại dành cho người nước ngoài — giúp
            bạn nắm vững phát âm, từ vựng và văn hóa Việt Nam qua các bài học
            tương tác đầy màu sắc.
          </p>

          <div className="feature-tags">
            <div className="feature-tag">
              <BookOpen size={20} color="#1a5f3f" />
              <span>Bài học thực tế</span>
            </div>
            <div className="feature-tag">
              <Headphones size={20} color="#f59e0b" />
              <span>Phát âm chuẩn</span>
            </div>
            <div className="feature-tag">
              <Heart size={20} color="#f43f5e" />
              <span>Văn hóa Việt Nam</span>
            </div>
          </div>

          <button
            className="btn-start"
            onClick={() => setShowDownloadPage(true)}
          >
            <Download size={22} />
            Bắt đầu học ngay
          </button>
        </div>

        <div className="hero-image">
          <img
            src="https://images.unsplash.com/photo-1528127269322-539801943592?w=800"
            alt="Vietnamese bamboo"
          />
          <div className="floating-badge">🎋</div>
        </div>
      </section>
      <section id="culture" className="culture-section">
        <div className="culture-content">
          <div className="culture-header">
            <h2 className="culture-title">Khám phá văn hóa Việt Nam</h2>
            <p className="culture-subtitle">
              Học tiếng Việt đi cùng với hiểu biết sâu sắc về văn hóa, ẩm thực
              và con người Việt Nam
            </p>
          </div>

          <div className="culture-grid">
            <div className="culture-card">
              <span className="culture-icon">🎋</span>
              <h3>Tre Việt Nam</h3>
              <p>
                Cây tre là biểu tượng của sự kiên cường và linh hoạt trong văn
                hóa Việt. Học cách sử dụng từ ngữ liên quan đến thiên nhiên
                trong giao tiếp hàng ngày.
              </p>
            </div>

            <div className="culture-card">
              <span className="culture-icon">🍜</span>
              <h3>Ẩm thực Việt</h3>
              <p>
                Khám phá từ vựng về món ăn Việt Nam từ phở, bánh mì đến cà phê.
                Học cách gọi món và trò chuyện về đồ ăn như người bản địa.
              </p>
            </div>

            <div className="culture-card">
              <span className="culture-icon">🏮</span>
              <h3>Lễ hội truyền thống</h3>
              <p>
                Tìm hiểu về Tết Nguyên Đán, Trung thu và các lễ hội đặc sắc. Nắm
                vững cách chúc mừng và giao tiếp trong các dịp đặc biệt.
              </p>
            </div>
          </div>
        </div>
      </section>
      {/* Stats */}
      <section id="features" className="stats-section">
        <div className="stats-grid">
          <div className="stat-card">
            <BookOpen className="stat-icon" size={60} color="#1a5f3f" />
            <h3 className="stat-number" style={{ color: "#1a5f3f" }}>
              5.000+
            </h3>
            <p className="stat-label">Bài học phong phú</p>
          </div>
          <div className="stat-card">
            <Star className="stat-icon" size={60} color="#fbbf24" />
            <h3 className="stat-number" style={{ color: "#fbbf24" }}>
              15.000+
            </h3>
            <p className="stat-label">Từ vựng thực tế</p>
          </div>
          <div className="stat-card">
            <Users className="stat-icon" size={60} color="#f43f5e" />
            <h3 className="stat-number" style={{ color: "#f43f5e" }}>
              10.000+
            </h3>
            <p className="stat-label">Học viên quốc tế</p>
          </div>
        </div>
      </section>
      {/* Rewards */}
      <section id="rewards" className="rewards-section">
        <div className="section-header">
          <span className="section-badge">🌟 HỆ THỐNG HỌC TẬP THÔNG MINH</span>
          <h2 className="section-title">
            Học tiếng Việt chưa bao giờ
            <br />
            dễ dàng và thú vị đến thế
          </h2>
          <p className="section-desc">
            Theo dõi tiến độ, nhận phần thưởng và khám phá văn hóa Việt Nam —
            mỗi bài học đều mang đến trải nghiệm học tập đáng nhớ.
          </p>
        </div>

        <div className="rewards-content">
          <div className="reward-cards">
            <RewardCard
              icon={ClipboardList}
              title="Lộ trình cá nhân hóa"
              desc="Hệ thống gợi ý bài học phù hợp với trình độ và mục tiêu của bạn."
              percent={95}
              color="blue"
            />
            <RewardCard
              icon={Award}
              title="Huy hiệu & phần thưởng"
              desc="Nhận huy hiệu đặc biệt khi hoàn thành các cột mốc quan trọng."
              percent={88}
              color="yellow"
            />
            <RewardCard
              icon={BarChart3}
              title="Theo dõi tiến độ"
              desc="Xem biểu đồ chi tiết về sự tiến bộ của bạn mỗi ngày."
              percent={92}
              color="pink"
            />
          </div>

          <div className="rewards-sidebar">
            <div className="rating-card">
              <div className="rating-circle">
                <Star size={45} />
                <div className="rating-number">4.9</div>
                <div className="rating-label">Đánh giá</div>
              </div>
            </div>

            <div className="mini-stats">
              <div className="mini-stat">
                <div>
                  <div
                    className="mini-stat-number"
                    style={{ color: "#1a5f3f" }}
                  >
                    5.000+
                  </div>
                  <div className="mini-stat-label">Bài học được tạo</div>
                </div>
                <CheckCircle size={35} color="#1a5f3f" />
              </div>
              <div className="mini-stat">
                <div>
                  <div
                    className="mini-stat-number"
                    style={{ color: "#f43f5e" }}
                  >
                    12.000+
                  </div>
                  <div className="mini-stat-label">Bài học hoàn thành</div>
                </div>
                <Star size={35} color="#fbbf24" />
              </div>
              <div className="mini-stat">
                <div>
                  <div
                    className="mini-stat-number"
                    style={{ color: "#3b82f6" }}
                  >
                    10.000+
                  </div>
                  <div className="mini-stat-label">Học viên hoạt động</div>
                </div>
                <Users size={35} color="#3b82f6" />
              </div>
            </div>
          </div>
        </div>
      </section>
      <section id="testimonials" className="testimonials-section">
        <div className="section-header">
          <span className="section-badge">TRẢI NGHIỆM HỌC VIÊN</span>
          <h2 className="section-title">Học viên nói gì về HiHear?</h2>
        </div>

        <div className="testimonials-grid">
          <div className="testimonial-card">
            <img
              src="https://cdn2.fptshop.com.vn/unsafe/1920x0/filters:format(webp):quality(75)/cac_tap_phim_co_su_tham_gia_cua_cha_eun_woo_1_9f8d8eff57.jpg"
              alt="Cha un woo"
              className="testimonial-avatar"
            />
            <p className="testimonial-text">
              "Ứng dụng tuyệt vời! Tôi đã học được rất nhiều từ vựng và cách
              phát âm chuẩn tiếng Việt trong vài tuần."
            </p>
            <h4 className="testimonial-name">Cha Un Woo (Hàn Quốc)</h4>
          </div>

          <div className="testimonial-card">
            <img
              src="https://vcdn1-thethao.vnecdn.net/2025/10/28/messi-1761617057-1761617067-17-6298-1176-1761617206.jpg?w=1200&h=0&q=100&dpr=1&fit=crop&s=2mbtZ2lK5vmypydcVeie_A"
              alt="Lionel Andrés Messi"
              className="testimonial-avatar"
            />
            <p className="testimonial-text">
              "Giao diện đẹp, bài học thú vị và dễ hiểu. Tôi cảm thấy tự tin hơn
              khi nói chuyện với người Việt!"
            </p>
            <h4 className="testimonial-name">
              Lionel Andrés Messi (Argentina)
            </h4>
          </div>

          <div className="testimonial-card">
            <img
              src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT1-MXUc6ZkxBNNdj3-YW8SSJX-WGgjUXsxWg&s"
              alt="elon musk"
              className="testimonial-avatar"
            />
            <p className="testimonial-text">
              "Hệ thống phần thưởng giúp tôi có động lực học mỗi ngày. Rất thích
              phần văn hóa Việt Nam!"
            </p>
            <h4 className="testimonial-name">Elon Musk (Mỹ)</h4>
          </div>
        </div>
      </section>
      <section
      style={{
        width: "100vw",
        height: "100vh",
        display: "flex",
        justifyContent: "center",
        alignItems: "center",
        overflow: "hidden",
        position: "relative",
      }}
    >
      <video
        ref={videoRef}
        src={AppAssets.video01}
        style={{ width: "100%", height: "100%", objectFit: "cover" }}
        autoPlay
        loop
        muted
        playsInline
      />

      <button
        onClick={toggleSound}
        style={{
          position: "absolute",
          top: 20,
          left: 20,
          background: "rgba(0,0,0,0.5)",
          border: "none",
          borderRadius: "50%",
          padding: 10,
          cursor: "pointer",
        }}
      >
        {isMuted ? (
          <VolumeX size={50} color="white" />
        ) : (
          <Volume size={50} color="white" />
        )}
      </button>
    </section>

      <footer id="contact" className="footer">
        <div className="footer-content">
          <div className="footer-header">
            <h2 className="footer-title">Bắt đầu hành trình học tiếng Việt</h2>
            <p className="footer-subtitle">
              Cùng HiHear khám phá vẻ đẹp của ngôn ngữ và văn hóa Việt Nam
            </p>
          </div>

          <div className="newsletter">
            <input
              type="email"
              placeholder="Nhập email của bạn"
              className="newsletter-input"
            />
            <button className="newsletter-button">Đăng ký ngay</button>
          </div>

          <div className="footer-grid">
            <div className="footer-column">
              <h3>HiHear</h3>
              <p>
                Ứng dụng học tiếng Việt hàng đầu cho người nước ngoài — giúp bạn
                nắm vững ngôn ngữ và hiểu sâu văn hóa Việt Nam.
              </p>
            </div>

            <div className="footer-column">
              <h3>Dịch vụ</h3>
              <ul>
                <li>
                  <BookOpen size={18} /> Lộ trình học tập
                </li>
                <li>
                  <Star size={18} /> Phần thưởng & huy hiệu
                </li>
                <li>
                  <BarChart3 size={18} /> Theo dõi tiến độ
                </li>
                <li>
                  <Heart size={18} /> Văn hóa Việt Nam
                </li>
              </ul>
            </div>

            <div className="footer-column">
              <h3>Liên hệ</h3>
              <ul>
                <li>
                  <Phone size={18} /> 0384252407
                </li>
                <li>
                  <Mail size={18} /> hcassano.dev@gmail.com
                </li>
                <li>
                  <Globe size={18} /> hihear.vn
                </li>
              </ul>
            </div>

            <div className="footer-column">
              <h3>Theo dõi</h3>
              <p>Cập nhật tin tức, mẹo học tập và tính năng mới từ HiHear.</p>
            </div>
          </div>

          <div className="footer-bottom">
            <p>
              © 2025 HiHear — Học tiếng Việt dễ dàng & hiệu quả | Được phát
              triển bởi HHTeam
            </p>
          </div>
        </div>
      </footer>
    </div>
  );
};

export default App;
