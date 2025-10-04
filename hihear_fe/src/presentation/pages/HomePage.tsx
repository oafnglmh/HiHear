import React from "react";
import { Link } from "react-router-dom";
import { motion } from "framer-motion";
import { Sparkles, PlayCircle, BookOpen, Volume2 } from "lucide-react";

const HomePage: React.FC = () => {
  return (
    <div className="relative flex flex-col items-center justify-center h-screen overflow-hidden bg-gradient-to-br from-orange-400 via-yellow-300 to-orange-500">
      <motion.div
        className="absolute w-96 h-96 bg-orange-200 rounded-full mix-blend-multiply filter blur-3xl opacity-40 animate-pulse"
        animate={{ y: [0, -30, 0] }}
        transition={{ duration: 6, repeat: Infinity }}
        style={{ top: "10%", left: "5%" }}
      />
      <motion.div
        className="absolute w-96 h-96 bg-yellow-200 rounded-full mix-blend-multiply filter blur-3xl opacity-40 animate-pulse"
        animate={{ y: [0, 30, 0] }}
        transition={{ duration: 5, repeat: Infinity }}
        style={{ bottom: "10%", right: "5%" }}
      />

      <motion.div
        initial={{ scale: 0, rotate: -20, opacity: 0 }}
        animate={{ scale: 1, rotate: 0, opacity: 1 }}
        transition={{ type: "spring", stiffness: 100, damping: 10 }}
        className="flex flex-col items-center mb-8 z-10"
      >
        <Sparkles className="w-14 h-14 text-white mb-3 drop-shadow-lg" />
        <h1 className="text-5xl font-extrabold text-white drop-shadow-md text-center">
          Chào mừng đến với HiHear 🧡
        </h1>
        <p className="text-white text-lg mt-2 font-medium opacity-90">
          Ứng dụng học tiếng Anh cùng AI — vừa học vừa chơi!
        </p>
      </motion.div>

      <div className="flex flex-wrap justify-center gap-6 z-10">
        <motion.div
          whileHover={{ scale: 1.1, rotate: 2 }}
          whileTap={{ scale: 0.95 }}
          transition={{ type: "spring", stiffness: 300 }}
        >
          <Link
            to="/learn"
            className="flex items-center gap-2 bg-white text-orange-500 font-bold px-6 py-3 rounded-2xl shadow-lg hover:shadow-xl"
          >
            <BookOpen className="w-6 h-6" />
            Học Ngay
          </Link>
        </motion.div>

        <motion.div
          whileHover={{ scale: 1.1, rotate: -2 }}
          whileTap={{ scale: 0.95 }}
          transition={{ type: "spring", stiffness: 300 }}
        >
          <Link
            to="/practice"
            className="flex items-center gap-2 bg-orange-600 text-white font-bold px-6 py-3 rounded-2xl shadow-lg hover:bg-orange-700"
          >
            <PlayCircle className="w-6 h-6" />
            Luyện Tập
          </Link>
        </motion.div>

        <motion.div
          whileHover={{ scale: 1.1, rotate: 1 }}
          whileTap={{ scale: 0.95 }}
          transition={{ type: "spring", stiffness: 300 }}
        >
          <Link
            to="/listen"
            className="flex items-center gap-2 bg-yellow-200 text-orange-700 font-bold px-6 py-3 rounded-2xl shadow-lg hover:bg-yellow-300"
          >
            <Volume2 className="w-6 h-6" />
            Nghe Thử
          </Link>
        </motion.div>
      </div>

      <motion.footer
        className="absolute bottom-4 text-white font-medium opacity-80 text-sm"
        animate={{ opacity: [0.6, 1, 0.6] }}
        transition={{ duration: 3, repeat: Infinity }}
      >
        © 2025 HiHear — Học tiếng Anh thật vui 🎵
      </motion.footer>
    </div>
  );
};

export default HomePage;
