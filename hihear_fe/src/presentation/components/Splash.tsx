import React from "react";
import { motion, AnimatePresence } from "framer-motion";
import { AppAssets } from "../../Core/AppAssets";

interface SplashProps {
  isVisible: boolean;
}

const Splash: React.FC<SplashProps> = ({ isVisible }) => {
  return (
    <AnimatePresence>
      {isVisible && (
        <motion.div
          key="splash"
          initial={{ opacity: 1 }}
          exit={{ opacity: 0 }}
          transition={{ duration: 0.6, ease: "easeInOut" }}
          className="fixed inset-0 z-50 flex flex-col items-center justify-center bg-gradient-to-b from-orange-500 to-yellow-500 text-white"
        >
          <motion.div
            initial={{ scale: 0.8, opacity: 0 }}
            animate={{ scale: 1, opacity: 1 }}
            transition={{ duration: 0.6, ease: "easeOut" }}
            className="flex flex-col items-center justify-center"
          >
            <motion.div
              animate={{ rotate: [0, 10, -10, 0] }}
              transition={{ repeat: Infinity, duration: 1.6 }}
              className="text-6xl font-extrabold tracking-wide drop-shadow-lg"
            >
              <img src={AppAssets.logo} alt="Logo" />
            </motion.div>
          </motion.div>
          <motion.div
            initial={{ width: 0 }}
            animate={{ width: "80%" }}
            transition={{ duration: 0.8, ease: "easeInOut", delay: 0.3 }}
            className="absolute bottom-10 h-1 bg-white/70 rounded-full"
          />
        </motion.div>
      )}
    </AnimatePresence>
  );
};

export default Splash;
