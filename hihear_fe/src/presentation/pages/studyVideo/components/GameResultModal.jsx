import React from 'react';
import { Trophy, X as XIcon, Heart } from 'lucide-react';
import { GAME_CONFIG } from '../utils/gameConstants';

export const GameResultModal = ({ isSuccess, onClose, onAddLesson }) => {
  const handleClose = () => {
    if (isSuccess) {
      onAddLesson();
    }
    onClose();
  };

  return (
    <div className="fixed inset-0 bg-black/70 backdrop-blur-sm flex items-center justify-center z-50 p-4">
      <div className="bg-white rounded-3xl p-8 max-w-md w-full shadow-2xl text-center">
        {isSuccess ? (
          <>
            <div className="w-32 h-32 mx-auto mb-6 bg-gradient-to-br from-amber-400 to-orange-500 rounded-full flex items-center justify-center animate-bounce">
              <Trophy size={64} className="text-white" />
            </div>

            <h2 className="text-4xl font-extrabold text-transparent bg-clip-text bg-gradient-to-r from-amber-500 to-orange-600 mb-4">
              Chiến thắng!
            </h2>

            <p className="text-gray-600 text-lg mb-6">
              Bạn đã hoàn thành {GAME_CONFIG.TOTAL_GATES} thử thách!
            </p>

            <div className="bg-gradient-to-r from-emerald-50 to-teal-50 p-6 rounded-2xl mb-6">
              <div className="flex items-center justify-center gap-3 mb-2">
                <Heart size={32} className="text-emerald-600" fill="currentColor" />
                <span className="text-5xl font-extrabold text-emerald-600">
                  +{GAME_CONFIG.REWARD_LESSONS}
                </span>
              </div>
              <p className="text-emerald-700 font-semibold">
                Lượt học mới đã được thêm!
              </p>
            </div>

            <button
              onClick={handleClose}
              className="w-full py-4 rounded-2xl bg-gradient-to-r from-emerald-600 to-emerald-700 text-white font-bold text-lg hover:from-emerald-700 hover:to-emerald-800 transition-all transform hover:scale-105"
            >
              Tuyệt vời!
            </button>
          </>
        ) : (
          <>
            <div className="w-32 h-32 mx-auto mb-6 bg-gradient-to-br from-gray-400 to-gray-600 rounded-full flex items-center justify-center">
              <XIcon size={64} className="text-white" />
            </div>

            <h2 className="text-3xl font-bold text-gray-900 mb-4">
              Trò chơi kết thúc
            </h2>

            <p className="text-gray-600 text-lg mb-6">
              Đáp án không chính xác. Hãy thử lại vào ngày mai để nhận thêm lượt học!
            </p>

            <button
              onClick={handleClose}
              className="w-full py-4 rounded-2xl bg-gradient-to-r from-gray-600 to-gray-700 text-white font-bold text-lg hover:from-gray-700 hover:to-gray-800 transition-all"
            >
              Đóng
            </button>
          </>
        )}
      </div>
    </div>
  );
};