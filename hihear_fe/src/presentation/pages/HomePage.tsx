import React, { useEffect, useState } from "react";
import { motion } from "framer-motion";
import { Link } from "react-router-dom";
import {
  BookOpen,
  Star,
  BarChart3,
  Smile,
  Users,
  Mail,
  Phone,
  Globe,
  Award,
  CheckCircle,
  ClipboardList,
} from "lucide-react";
import { AppAssets } from "../../Core/AppAssets";
import { FadeInWhenVisible } from "../components/FadeInWhenVisible";

/* -------------------------
  TypingText: chữ "Better!" gõ & xoá lặp vô hạn
------------------------- */
const TypingText: React.FC = () => {
  const text = "Better!";
  const [displayText, setDisplayText] = useState("");
  const [isDeleting, setIsDeleting] = useState(false);
  const [index, setIndex] = useState(0);

  useEffect(() => {
    const speed = isDeleting ? 80 : 160;
    const t = setTimeout(() => {
      if (!isDeleting) {
        if (index < text.length) {
          setDisplayText((p) => p + text[index]);
          setIndex((v) => v + 1);
        } else {
          setIsDeleting(true);
        }
      } else {
        if (index > 0) {
          setDisplayText(text.slice(0, index - 1));
          setIndex((v) => v - 1);
        } else {
          setIsDeleting(false);
        }
      }
    }, speed);
    return () => clearTimeout(t);
  }, [index, isDeleting]);

  return (
    <motion.span
      className="text-blue-500 inline-block"
      style={{ fontFamily: "'Patrick Hand', cursive" }}
      animate={{ opacity: [0.85, 1, 0.85] }}
      transition={{ duration: 2, repeat: Infinity }}
    >
      {displayText}
      <motion.span
        className="inline-block w-[3px] bg-blue-400 ml-1 align-middle"
        animate={{ opacity: [0, 1, 0] }}
        transition={{ duration: 0.8, repeat: Infinity }}
      />
    </motion.span>
  );
};

/* -------------------------
  RewardCard: thẻ sao (thanh tiến trình động)
------------------------- */
const RewardCard: React.FC<{
  icon: React.ElementType;
  title: string;
  desc: string;
  percent: number;
  color: "blue" | "yellow" | "pink";
}> = ({ icon: Icon, title, desc, percent, color }) => {
  const [progress, setProgress] = useState(0);
  useEffect(() => {
    const timer = setTimeout(() => setProgress(percent), 350);
    return () => clearTimeout(timer);
  }, [percent]);

  const bgMap = {
    blue: "from-blue-50 to-blue-25 text-blue-700",
    yellow: "from-yellow-50 to-amber-50 text-amber-700",
    pink: "from-pink-50 to-rose-50 text-pink-700",
  } as const;
  const barMap = { blue: "bg-blue-500", yellow: "bg-amber-400", pink: "bg-pink-400" } as const;

  return (
    <div className={`p-6 rounded-2xl shadow-md bg-gradient-to-br ${bgMap[color]} w-full max-w-[520px]`}>
      <div className="flex items-start gap-4">
        <div className="w-12 h-12 bg-white/80 rounded-lg flex items-center justify-center shadow">
          <Icon className="w-6 h-6" />
        </div>
        <div className="flex-1">
          <h3 className="font-semibold text-lg mb-1">{title}</h3>
          <p className="text-gray-600 text-sm mb-3">{desc}</p>

          <div className="w-full h-2 bg-gray-200 rounded-full overflow-hidden">
            <motion.div
              className={`${barMap[color]} h-2 origin-left`}
              initial={{ scaleX: 0 }}
              animate={{ scaleX: progress / 100 }}
              transition={{ duration: 1.8, ease: "easeOut" }}
            />
          </div>

          <span className="text-xs text-gray-500 mt-2 inline-block">{percent}% hoàn thành</span>
        </div>
      </div>
    </div>
  );
};

const HomePage: React.FC = () => {
  return (
    <div className="min-h-screen bg-gradient-to-b from-orange-50 to-yellow-50 text-gray-800">
      {/* Header */}
      <header className="flex justify-between items-center px-6 md:px-12 py-4 bg-white/90 backdrop-blur-sm sticky top-0 z-50 shadow">
        <div className="flex items-center gap-3">
          <img src={AppAssets.logo} alt="HiHear" className="w-16 h-16 object-contain" />
          <h1 className="text-2xl font-bold text-orange-500" style={{ fontFamily: "'Fredoka One', cursive" }}>
            HiHear
          </h1>
        </div>

        <nav className="hidden md:flex items-center gap-8 font-medium text-gray-700">
          <a href="#home" className="hover:text-orange-500">Trang chủ</a>
          <a href="#features" className="hover:text-orange-500">Tính năng</a>
          <a href="#rewards" className="hover:text-orange-500">Thành tích</a>
          <a href="#contact" className="hover:text-orange-500">Liên hệ</a>
        </nav>

        <div className="flex items-center gap-3">
          <button className="text-sm font-medium text-gray-600 hover:text-orange-500">Đăng nhập</button>
          <Link to="/register" className="bg-orange-500 text-white px-4 py-2 rounded-full font-bold shadow hover:bg-orange-600 transition">
            Đăng ký
          </Link>
        </div>
      </header>

      {/* Hero */}
      <section id="home" className="flex flex-col lg:flex-row items-center gap-10 px-6 md:px-20 py-16 md:py-24">
        <motion.div className="max-w-xl" initial={{ opacity: 0, y: 30 }} animate={{ opacity: 1, y: 0 }} transition={{ duration: 0.8 }}>
          <h1 className="text-5xl md:text-[64px] font-extrabold mb-4" style={{ fontFamily: "'Patrick Hand', cursive" }}>
            HiHear — Học tiếng Anh <br /> hiệu quả <br />
            <span className="text-blue-500"><TypingText /></span>
          </h1>

          <p className="text-gray-600 text-lg mb-6">
            Ứng dụng học tiếng Anh dành cho mọi lứa tuổi — giúp bạn luyện nghe, nói và phát âm
            qua các bài học tương tác, phần thưởng hấp dẫn và hệ thống tiến độ thông minh.
          </p>

          <div className="flex flex-wrap gap-3 mb-6">
            <div className="flex items-center gap-2 bg-white/80 px-3 py-2 rounded-full shadow-sm">
              <BookOpen className="w-5 h-5 text-green-500" /> <span className="text-sm">Bài học cá nhân hóa</span>
            </div>
            <div className="flex items-center gap-2 bg-white/80 px-3 py-2 rounded-full shadow-sm">
              <Star className="w-5 h-5 text-amber-400" /> <span className="text-sm">Phần thưởng & huy hiệu</span>
            </div>
            <div className="flex items-center gap-2 bg-white/80 px-3 py-2 rounded-full shadow-sm">
              <Users className="w-5 h-5 text-pink-500" /> <span className="text-sm">Cộng đồng học tập</span>
            </div>
          </div>

          <Link to="/learn" className="inline-block bg-blue-600 hover:bg-blue-700 text-white px-6 py-3 rounded-2xl font-semibold shadow">
            Bắt đầu học
          </Link>
        </motion.div>

        <motion.div className="relative flex-1 max-w-[760px]" initial={{ opacity: 0, x: 40 }} animate={{ opacity: 1, x: 0 }} transition={{ duration: 0.8 }}>
          <img src="https://images.pexels.com/photos/4144222/pexels-photo-4144222.jpeg" alt="learning" className="w-full rounded-3xl shadow-2xl" />
          <motion.img src={AppAssets.hearuHi} alt="mascot" className="absolute -top-8 -right-8 w-28 rounded-lg shadow-lg border-4 border-white"
            animate={{ y: [0, -10, 0] }} transition={{ repeat: Infinity, duration: 3 }} />
        </motion.div>
      </section>

      {/* Stats */}
      <section id="features" className="px-6 md:px-20 py-12">
        <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
          <div className="bg-white p-6 rounded-2xl shadow text-center">
            <BookOpen className="mx-auto w-8 h-8 text-blue-500 mb-3" />
            <h3 className="text-2xl font-bold text-blue-600">10.000+</h3>
            <p className="text-gray-500 mt-1">Bài học hoàn thành</p>
          </div>
          <div className="bg-white p-6 rounded-2xl shadow text-center">
            <Star className="mx-auto w-8 h-8 text-amber-400 mb-3" />
            <h3 className="text-2xl font-bold text-amber-500">5.000+</h3>
            <p className="text-gray-500 mt-1">Huy hiệu đạt được</p>
          </div>
          <div className="bg-white p-6 rounded-2xl shadow text-center">
            <Users className="mx-auto w-8 h-8 text-pink-500 mb-3" />
            <h3 className="text-2xl font-bold text-pink-500">2.000+</h3>
            <p className="text-gray-500 mt-1">Người dùng đang học</p>
          </div>
        </div>
      </section>

      {/* Rewards */}
      <FadeInWhenVisible>
        <section id="rewards" className="px-6 md:px-20 py-16 bg-gradient-to-b from-yellow-50 to-orange-50">
          <div className="max-w-5xl mx-auto text-center mb-10">
            <p className="uppercase text-sm tracking-wider text-amber-500 font-semibold mb-3">HỆ THỐNG THÀNH TÍCH THÔNG MINH</p>
            <h2 className="text-3xl md:text-4xl font-bold" style={{ fontFamily: "'Patrick Hand', cursive" }}>
              Biến việc học thành trải nghiệm thú vị <br />
              và tạo động lực mỗi ngày
            </h2>
            <p className="text-gray-600 mt-4 max-w-2xl mx-auto">
              Theo dõi tiến độ, nhận sao thưởng và đạt được huy hiệu — mọi bước tiến nhỏ đều được ghi nhận để bạn tiến xa hơn.
            </p>
          </div>

          <div className="flex flex-col lg:flex-row items-start gap-12">
            <div className="flex-1 flex flex-col gap-6">
              <RewardCard icon={ClipboardList} title="Lộ trình học rõ ràng" desc="Hệ thống gợi ý bài học và mục tiêu phù hợp với từng cấp độ của bạn." percent={95} color="blue" />
              <RewardCard icon={Award} title="Sao thưởng & huy hiệu" desc="Nhận sao khi hoàn thành bài học và huy hiệu đặc biệt khi đạt cột mốc." percent={88} color="yellow" />
              <RewardCard icon={BarChart3} title="Theo dõi tiến bộ" desc="Xem sự tiến triển qua biểu đồ chi tiết — giúp bạn luôn có động lực học tập." percent={92} color="pink" />
            </div>

            <div className="w-full lg:w-[360px]">
              <motion.div className="rounded-full w-40 h-40 mx-auto flex items-center justify-center shadow-lg border-4 border-amber-300 mb-6"
                initial={{ scale: 0.9 }} animate={{ scale: 1 }} transition={{ duration: 0.6 }}>
                <div className="text-center">
                  <Star className="mx-auto mb-1 text-amber-400" />
                  <div className="text-3xl font-bold">4.9</div>
                  <div className="text-sm text-gray-500">Đánh giá trung bình</div>
                </div>
              </motion.div>

              <div className="grid grid-cols-1 gap-4">
                <div className="bg-white p-4 rounded-xl shadow flex items-center justify-between">
                  <div>
                    <div className="text-xl font-bold text-blue-600">10.000+</div>
                    <div className="text-sm text-gray-500">Bài học tạo</div>
                  </div>
                  <CheckCircle className="w-6 h-6 text-green-500" />
                </div>
                <div className="bg-white p-4 rounded-xl shadow flex items-center justify-between">
                  <div>
                    <div className="text-xl font-bold text-emerald-600">8.500+</div>
                    <div className="text-sm text-gray-500">Bài học hoàn thành</div>
                  </div>
                  <Star className="w-6 h-6 text-amber-400" />
                </div>
                <div className="bg-white p-4 rounded-xl shadow flex items-center justify-between">
                  <div>
                    <div className="text-xl font-bold text-pink-500">2.000+</div>
                    <div className="text-sm text-gray-500">Người học đang hoạt động</div>
                  </div>
                  <Users className="w-6 h-6 text-pink-500" />
                </div>
              </div>
            </div>
          </div>
        </section>
      </FadeInWhenVisible>

      {/* Testimonials */}
      <FadeInWhenVisible>
        <section id="testimonials" className="py-16 px-6 md:px-20">
          <h2 className="text-3xl text-center font-bold mb-8" style={{ fontFamily: "'Patrick Hand', cursive" }}>Người học nói gì?</h2>
          <div className="flex flex-wrap justify-center gap-8">
            {[
              { name: "Minh Hoàng", text: "Ứng dụng giúp mình luyện nói và nghe tự nhiên hơn mỗi ngày.", avatar: "https://cdn-icons-png.flaticon.com/512/2922/2922510.png" },
              { name: "Thương Hoài", text: "Giao diện đẹp, dễ sử dụng, học mà cảm giác như chơi!", avatar: "https://cdn-icons-png.flaticon.com/512/2922/2922506.png" },
              { name: "Hearu", text: "Hệ thống phần thưởng khiến mình có động lực học đều đặn hơn.", avatar: "https://cdn-icons-png.flaticon.com/512/2922/2922561.png" },
            ].map((t, i) => (
              <motion.div key={i} whileHover={{ y: -6 }} className="bg-white p-6 rounded-2xl shadow-md max-w-sm text-center">
                <img src={t.avatar} alt={t.name} className="w-14 h-14 rounded-full mx-auto mb-3" />
                <p className="text-gray-600 italic mb-3">“{t.text}”</p>
                <h4 className="font-semibold text-orange-500">{t.name}</h4>
              </motion.div>
            ))}
          </div>
        </section>
      </FadeInWhenVisible>

      {/* Footer */}
      <footer className="bg-gradient-to-br from-yellow-50 to-amber-100 py-12 text-gray-700">
        <div className="container mx-auto px-6 md:px-12 text-center">
          <h2 className="text-2xl md:text-3xl font-[Chewy] text-orange-500 mb-3">Học tiếng Anh chủ động</h2>
          <p className="text-gray-600 mb-6">
            Cùng HiHear — xây dựng thói quen học tiếng Anh vui vẻ, hiệu quả và bền vững cho mọi người.
          </p>

          <div className="flex flex-col sm:flex-row justify-center items-center gap-3 mb-8">
            <input
              type="email"
              placeholder="Nhập email của bạn"
              className="px-4 py-3 rounded-full border border-gray-300 w-72 focus:outline-none focus:ring-2 focus:ring-yellow-400"
            />
            <button className="bg-sky-400 hover:bg-sky-500 text-white px-6 py-3 rounded-full font-semibold shadow-md transition">Đăng ký</button>
          </div>

          <div className="grid grid-cols-1 md:grid-cols-4 gap-8 text-left md:text-center mb-8">
            <div>
              <h3 className="font-bold text-lg mb-2">HiHear</h3>
              <p className="text-sm text-gray-600">
                Ứng dụng giúp người học tiếng Anh ở mọi độ tuổi luyện tập hiệu quả, duy trì động lực và tiến bộ mỗi ngày.
              </p>
            </div>
            <div>
              <h3 className="font-bold text-lg mb-2">Dịch vụ</h3>
              <ul className="space-y-1 text-sm">
                <li className="flex items-center justify-center md:justify-start gap-2"><BookOpen className="w-4 h-4 text-blue-500" /> Lộ trình học tập</li>
                <li className="flex items-center justify-center md:justify-start gap-2"><Star className="w-4 h-4 text-amber-400" /> Phần thưởng & huy hiệu</li>
                <li className="flex items-center justify-center md:justify-start gap-2"><BarChart3 className="w-4 h-4 text-green-500" /> Theo dõi tiến độ</li>
              </ul>
            </div>
            <div>
              <h3 className="font-bold text-lg mb-2">Liên hệ</h3>
              <ul className="space-y-1 text-sm">
                <li className="flex items-center justify-center md:justify-start gap-2"><Phone className="w-4 h-4 text-sky-500" /> +84 123 456 789</li>
                <li className="flex items-center justify-center md:justify-start gap-2"><Mail className="w-4 h-4 text-sky-500" /> support@hihear.vn</li>
                <li className="flex items-center justify-center md:justify-start gap-2"><Globe className="w-4 h-4 text-sky-500" /> hihear.vn</li>
              </ul>
            </div>
            <div>
              <h3 className="font-bold text-lg mb-2">Cập nhật</h3>
              <p className="text-sm text-gray-600">Theo dõi tin tức, mẹo học tập và tính năng mới nhất từ HiHear.</p>
            </div>
          </div>

          <p className="text-gray-500 text-sm mt-6">
            © 2025 HiHear — Học tiếng Anh vui & hiệu quả | Phát triển bởi HiHear Team
          </p>
        </div>
      </footer>
    </div>
  );
};

export default HomePage;
