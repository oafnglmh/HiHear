import React from 'react';
import { X, AlertCircle } from 'lucide-react';
import { GameButton } from './GameButton';

export const LimitModal = ({ isOpen, onClose, canPlayGame, onStartGame }) => {
  if (!isOpen) return null;

  return (
    <div className="fixed inset-0 bg-black/60 backdrop-blur-sm flex items-center justify-center z-50 p-4">
      <div className="bg-white rounded-3xl p-8 max-w-md w-full shadow-2xl">
        <button
          onClick={onClose}
          className="float-right p-2 rounded-full hover:bg-gray-100 transition-colors"
        >
          <X size={24} className="text-gray-500" />
        </button>

        <div className="w-20 h-20 mx-auto mb-6 bg-gradient-to-br from-amber-400 to-orange-500 rounded-full flex items-center justify-center">
          <AlertCircle size={40} className="text-white" />
        </div>

        <h3 className="text-2xl font-bold text-gray-900 mb-4 text-center">
          Đã hết lượt học hôm nay
        </h3>

        <p className="text-gray-600 text-center mb-6">
          Bạn đã sử dụng hết 5 lượt học miễn phí trong ngày.
        </p>

        {canPlayGame && (
          <div className="mb-6">
            <div className="bg-gradient-to-r from-purple-50 to-pink-50 p-4 rounded-2xl border-2 border-purple-200 mb-4">
              <p className="text-sm text-purple-900 text-center font-semibold mb-2">
                Muốn thêm lượt học?
              </p>
              <p className="text-xs text-purple-700 text-center">
                Chơi trò chơi và hoàn thành 3 thử thách để nhận thêm 1 lượt học!
              </p>
            </div>

            <GameButton
              canPlay={canPlayGame}
              onClick={() => {
                onClose();
                onStartGame();
              }}
            />
          </div>
        )}

        <button
          onClick={onClose}
          className="w-full bg-gradient-to-r from-emerald-600 to-emerald-700 text-white py-3 rounded-xl font-semibold hover:from-emerald-700 hover:to-emerald-800 transition-all"
        >
          {canPlayGame ? 'Để sau' : 'Đã hiểu'}
        </button>
      </div>
    </div>
  );
};