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
  Volume,
  VolumeX,
  Map,
  Video,
} from "lucide-react";
import "./css/home.css";
import { AppAssets } from "../../../Core/constant/AppAssets";
import Header from "../layout/header";
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
      <Header />

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
            onClick={() => setShowDownloadPage(false)}
          >
            <Download size={22} />
            Bắt đầu học ngay
          </button>
          <div className="download-buttons">
            <div className="store-buttons">
              <a
                href="https://apps.apple.com/app/your-app-id"
                target="_blank"
                rel="noopener noreferrer"
                className="store-button app-store"
              >
                <svg
                  viewBox="0 0 24 24"
                  fill="currentColor"
                  width="24"
                  height="24"
                >
                  <path d="M18.71 19.5C17.88 20.74 17 21.95 15.66 21.97C14.32 22 13.89 21.18 12.37 21.18C10.84 21.18 10.37 21.95 9.1 22C7.79 22.05 6.8 20.68 5.96 19.47C4.25 17 2.94 12.45 4.7 9.39C5.57 7.87 7.13 6.91 8.82 6.88C10.1 6.86 11.32 7.75 12.11 7.75C12.89 7.75 14.37 6.68 15.92 6.84C16.57 6.87 18.39 7.1 19.56 8.82C19.47 8.88 17.39 10.1 17.41 12.63C17.44 15.65 20.06 16.66 20.09 16.67C20.06 16.74 19.67 18.11 18.71 19.5ZM13 3.5C13.73 2.67 14.94 2.04 15.94 2C16.07 3.17 15.6 4.35 14.9 5.19C14.21 6.04 13.07 6.7 11.95 6.61C11.8 5.46 12.36 4.26 13 3.5Z" />
                </svg>
                <div className="store-text">
                  <span className="store-label">Tải trên</span>
                  <span className="store-name">App Store</span>
                </div>
              </a>

              <a
                href="https://play.google.com/store/apps/details?id=your.package.name"
                target="_blank"
                rel="noopener noreferrer"
                className="store-button google-play"
              >
                <svg
                  viewBox="0 0 24 24"
                  fill="currentColor"
                  width="24"
                  height="24"
                >
                  <path d="M3,20.5V3.5C3,2.91 3.34,2.39 3.84,2.15L13.69,12L3.84,21.85C3.34,21.6 3,21.09 3,20.5M16.81,15.12L6.05,21.34L14.54,12.85L16.81,15.12M20.16,10.81C20.5,11.08 20.75,11.5 20.75,12C20.75,12.5 20.53,12.9 20.18,13.18L17.89,14.5L15.39,12L17.89,9.5L20.16,10.81M6.05,2.66L16.81,8.88L14.54,11.15L6.05,2.66Z" />
                </svg>
                <div className="store-text">
                  <span className="store-label">Tải trên</span>
                  <span className="store-name">Google Play</span>
                </div>
              </a>
            </div>
          </div>
        </div>

        <div className="hero-image">
          <img src={AppAssets.hand} alt="Vietnamese bamboo" />
          <div className="floating-badge">
            <img src={AppAssets.hearuHi}></img>
          </div>
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
              <div className="card-image bamboo"></div>
              <h3>Tre Việt Nam</h3>
              <p>
                Cây tre là biểu tượng của sự kiên cường và linh hoạt trong văn
                hóa Việt. Học cách sử dụng từ ngữ liên quan đến thiên nhiên
                trong giao tiếp hàng ngày.
              </p>
            </div>

            <div className="culture-card">
              <div className="card-image cuisine"></div>
              <h3>Ẩm thực Việt</h3>
              <p>
                Khám phá từ vựng về món ăn Việt Nam từ phở, bánh mì đến cà phê.
                Học cách gọi món và trò chuyện về đồ ăn như người bản địa.
              </p>
            </div>

            <div className="culture-card">
              <div className="card-image festival"></div>
              <h3>Lễ hội truyền thống</h3>
              <p>
                Tìm hiểu về Tết Nguyên Đán, Trung thu và các lễ hội đặc sắc. Nắm
                vững cách chúc mừng và giao tiếp trong các dịp đặc biệt.
              </p>
            </div>
          </div>
        </div>
      </section>
      <section id="features" className="app-showcase-section">
        <div className="showcase-container">
          <div className="section-header">
            <h2 className="section-title">
              Ứng dụng học tiếng Việt
              <br />
              toàn diện cho người nước ngoài
            </h2>
            <p className="section-desc">
              Được thiết kế đặc biệt để giúp bạn học tiếng Việt một cách hiệu
              quả, từ phát âm cơ bản đến giao tiếp thành thạo.
            </p>
          </div>

          <div className="showcase-content">
            {/* Features List */}
            <div className="features-list">
              <div className="feature-item">
                <div className="feature-icon-wrapper green">
                  <MessageCircle size={28} />
                </div>
                <div className="feature-text">
                  <h3>Trò chuyện với AI</h3>
                  <p>
                    Luyện tập hội thoại thực tế với trợ lý AI thông minh, phản
                    hồi tức thì
                  </p>
                </div>
              </div>

              <div className="feature-item">
                <div className="feature-icon-wrapper blue">
                  <Map size={28} />
                </div>
                <div className="feature-text">
                  <h3>Lộ trình rõ ràng</h3>
                  <p>
                    Học theo từng cấp độ từ A1 đến C2 với lộ trình được thiết kế
                    khoa học
                  </p>
                </div>
              </div>

              <div className="feature-item">
                <div className="feature-icon-wrapper orange">
                  <Video size={28} />
                </div>
                <div className="feature-text">
                  <h3>Học qua video</h3>
                  <p>
                    Bài giảng video sinh động với phụ đề song ngữ và bài tập
                    tương tác
                  </p>
                </div>
              </div>

              <div className="feature-item">
                <div className="feature-icon-wrapper purple">
                  <Headphones size={28} />
                </div>
                <div className="feature-text">
                  <h3>Luyện phát âm</h3>
                  <p>
                    Công nghệ nhận diện giọng nói giúp bạn nói tiếng Việt chuẩn
                    như người bản địa
                  </p>
                </div>
              </div>

              <div className="feature-item">
                <div className="feature-icon-wrapper yellow">
                  <Star size={28} />
                </div>
                <div className="feature-text">
                  <h3>Bài tập đa dạng</h3>
                  <p>
                    Trắc nghiệm, điền từ, nghe viết và nhiều dạng bài tập thú vị
                    khác
                  </p>
                </div>
              </div>

              <div className="feature-item">
                <div className="feature-icon-wrapper pink">
                  <Award size={28} />
                </div>
                <div className="feature-text">
                  <h3>Theo dõi tiến độ</h3>
                  <p>
                    Thống kê chi tiết về quá trình học và nhận huy hiệu khi đạt
                    mục tiêu
                  </p>
                </div>
              </div>
            </div>

            <div className="app-preview">
              <div className="phone-mockup">
                <div className="phone-frame">
                  <div className="phone-notch"></div>
                  <div className="phone-screen">
                    <img
                      src={AppAssets.ai}
                      alt="App Screenshot"
                    />
                    <div className="screen-overlay">
                      <div className="overlay-badge">
                        <Star size={16} />
                        <span>4.9/5</span>
                      </div>
                    </div>
                  </div>
                </div>

                <div className="floating-card card-1">
                  <MessageCircle size={20} color="#1a5f3f" />
                  <span>AI Chat</span>
                </div>
                <div className="floating-card card-2">
                  <Video size={20} color="#f59e0b" />
                  <span>Video Lessons</span>
                </div>
                <div className="floating-card card-3">
                  <Award size={20} color="#f43f5e" />
                  <span>Achievements</span>
                </div>
              </div>
            </div>
          </div>

          {/* Stats */}
          <div className="app-stats">
            <div className="stat-item">
              <h3 className="stat-number" style={{ color: "#1a5f3f" }}>
                5.000+
              </h3>
              <p className="stat-label">Bài học</p>
            </div>
            <div className="stat-divider"></div>
            <div className="stat-item">
              <h3 className="stat-number" style={{ color: "#f59e0b" }}>
                15.000+
              </h3>
              <p className="stat-label">Từ vựng</p>
            </div>
            <div className="stat-divider"></div>
            <div className="stat-item">
              <h3 className="stat-number" style={{ color: "#f43f5e" }}>
                10.000+
              </h3>
              <p className="stat-label">Học viên</p>
            </div>
            <div className="stat-divider"></div>
            <div className="stat-item">
              <h3 className="stat-number" style={{ color: "#3b82f6" }}>
                4.9/5
              </h3>
              <p className="stat-label">Đánh giá</p>
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
