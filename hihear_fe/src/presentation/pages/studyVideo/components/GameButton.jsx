import React from 'react';
import { Gamepad2, Lock } from 'lucide-react';

export const GameButton = ({ canPlay, onClick }) => {
  return (
    <button
      onClick={onClick}
      disabled={!canPlay}
      className={`w-full flex items-center gap-3 px-6 py-4 rounded-2xl font-bold text-lg transition-all transform ${
        canPlay
          ? 'bg-gradient-to-r  from-purple-600 to-pink-600 text-white hover:from-purple-700 hover:to-pink-700 hover:scale-105 hover:shadow-xl active:scale-95'
          : 'bg-gray-300 text-gray-500 cursor-not-allowed'
      }`}
    >
      {canPlay ? (
        <>
          <Gamepad2 size={24} />
          <span>Chơi trò chơi nhận lượt học</span>
        </>
      ) : (
        <>
          <Lock size={24} />
          <span>Đã chơi hôm nay</span>
        </>
      )}
    </button>
  );
};