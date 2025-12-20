import React from 'react';
import { Play, Pause } from 'lucide-react';

export const VideoControls = ({
  isPlaying,
  currentTime,
  duration,
  onTogglePlay,
  onSeek,
  formatTime,
}) => {
  return (
    <>
      {!isPlaying && (
        <div className="absolute inset-0 flex items-center justify-center bg-black/30">
          <button
            onClick={onTogglePlay}
            className="w-20 h-20 bg-emerald-600 rounded-full flex items-center justify-center hover:bg-emerald-700 transition-all transform hover:scale-110"
          >
            <Play size={40} className="text-white ml-2" fill="white" />
          </button>
        </div>
      )}

      <div className="absolute bottom-0 left-0 right-0 bg-gradient-to-t from-black/80 to-transparent p-4">
        <div className="flex items-center gap-4">
          <button
            onClick={onTogglePlay}
            className="text-white hover:text-emerald-400 transition-colors"
          >
            {isPlaying ? <Pause size={24} /> : <Play size={24} />}
          </button>

          <div className="flex-1">
            <input
              type="range"
              min="0"
              max={duration}
              value={currentTime}
              onChange={(e) => onSeek(Number(e.target.value))}
              className="w-full h-1 bg-gray-600 rounded-lg appearance-none cursor-pointer"
              style={{
                background: `linear-gradient(to right, #10b981 0%, #10b981 ${
                  (currentTime / duration) * 100
                }%, #4b5563 ${(currentTime / duration) * 100}%, #4b5563 100%)`,
              }}
            />
          </div>

          <span className="text-white text-sm font-medium min-w-[80px] text-right">
            {formatTime(currentTime)} / {formatTime(duration)}
          </span>
        </div>
      </div>
    </>
  );
};