import React from "react";
import { Trophy, Lock, CheckCircle } from "lucide-react";
import { GAME_CONFIG } from "../utils/gameConstants";

export const GameCanvas = ({
  playerPos,
  completedGates,
  onGateClick,
  direction,
  playerImage,
}) => {
  const [isMoving, setIsMoving] = React.useState(false);
  const [lastPos, setLastPos] = React.useState(playerPos);

  React.useEffect(() => {
    if (playerPos.x !== lastPos.x || playerPos.y !== lastPos.y) {
      setIsMoving(true);
      const timer = setTimeout(() => setIsMoving(false), 150);
      setLastPos(playerPos);
      return () => clearTimeout(timer);
    }
  }, [playerPos, lastPos]);

  const getRotation = () => {
    if (!direction) return 0;
    const rotations = { up: -90, down: 90, left: 180, right: 0 };
    return rotations[direction] || 0;
  };

  return (
    <div className="relative w-full h-[600px] bg-gradient-to-br from-emerald-100 via-teal-50 to-blue-100 rounded-2xl overflow-hidden border-4 border-emerald-600 shadow-2xl">
      {/* Background decorative blurs */}
      <div className="absolute inset-0 opacity-10">
        <div className="absolute top-10 left-10 w-20 h-20 bg-emerald-500 rounded-full blur-xl"></div>
        <div className="absolute top-40 right-20 w-32 h-32 bg-blue-500 rounded-full blur-2xl"></div>
        <div className="absolute bottom-20 left-1/3 w-24 h-24 bg-teal-500 rounded-full blur-xl"></div>
      </div>

      {/* Path visualization */}
      <svg className="absolute inset-0 w-full h-full pointer-events-none">
        <defs>
          <linearGradient id="pathGradient" x1="0%" y1="0%" x2="100%" y2="0%">
            <stop offset="0%" stopColor="#10b981" stopOpacity="0.3" />
            <stop offset="100%" stopColor="#0ea5e9" stopOpacity="0.3" />
          </linearGradient>
        </defs>
        <path
          d={`M ${playerPos.x} ${playerPos.y} L 300 400 L 600 250 L 900 400`}
          stroke="url(#pathGradient)"
          strokeWidth="3"
          strokeDasharray="10,5"
          fill="none"
        />
      </svg>

      {/* Gates */}
      {GAME_CONFIG.GATE_POSITIONS.map((gate, index) => {
        const isCompleted = completedGates.includes(index);
        const isLocked = index > 0 && !completedGates.includes(index - 1);

        return (
          <div
            key={index}
            className="absolute transform -translate-x-1/2 -translate-y-1/2 cursor-pointer transition-all hover:scale-110"
            style={{ left: gate.x, top: gate.y }}
            onClick={() => !isLocked && onGateClick(index)}
          >
            <div
              className={`relative w-24 h-32 rounded-lg shadow-xl transition-all ${
                isCompleted
                  ? "bg-gradient-to-br from-green-400 to-emerald-600"
                  : isLocked
                  ? "bg-gradient-to-br from-gray-400 to-gray-600"
                  : "bg-gradient-to-br from-amber-400 to-orange-600 animate-pulse"
              }`}
            >
              <div className="absolute inset-0 flex flex-col items-center justify-center text-white">
                {isCompleted ? (
                  <CheckCircle size={32} className="mb-2" />
                ) : isLocked ? (
                  <Lock size={32} className="mb-2" />
                ) : (
                  <Trophy size={32} className="mb-2" />
                )}
                <span className="text-xs font-bold">{gate.label}</span>
              </div>

              {!isCompleted && !isLocked && (
                <div className="absolute inset-0 rounded-lg bg-gradient-to-br from-amber-300 to-orange-500 opacity-50 blur-md animate-pulse"></div>
              )}
            </div>

            <div className="absolute top-full mt-2 left-1/2 transform -translate-x-1/2 whitespace-nowrap">
              <span className="text-xs font-semibold text-gray-700 bg-white px-2 py-1 rounded-full shadow-md">
                {isCompleted
                  ? "✓ Hoàn thành"
                  : isLocked
                  ? "🔒 Khóa"
                  : "⭐ Sẵn sàng"}
              </span>
            </div>
          </div>
        );
      })}

      {/* Player Character with improved animation */}
      <div
        className="absolute transform -translate-x-1/2 -translate-y-1/2 transition-all duration-200 ease-out"
        style={{
          left: playerPos.x,
          top: playerPos.y,
        }}
      >
        <div className="relative">
          {/* Main character circle */}
          <div
            className={`w-16 h-16 bg-gradient-to-br from-blue-500 to-purple-600 rounded-full flex items-center justify-center shadow-xl border-4 border-white transition-all duration-150 overflow-hidden ${
              isMoving ? "scale-95" : "scale-100"
            }`}
            style={{
              transform: `rotate(${getRotation()}deg) ${
                isMoving ? "translateY(-4px)" : "translateY(0)"
              }`,
              transition: "transform 0.15s ease-out",
            }}
          >
            {playerImage ? (
              <img
                src={playerImage}
                alt="Player"
                className="w-full h-full object-cover transition-transform duration-150"
                style={{
                  transform: `rotate(${-getRotation()}deg)`,
                }}
              />
            ) : (
              <span
                className="text-2xl transition-transform duration-150"
                style={{
                  transform: `rotate(${-getRotation()}deg)`,
                  display: "inline-block",
                }}
              >
                🧑
              </span>
            )}
          </div>

          {/* Dynamic shadow */}
          <div
            className={`absolute -bottom-2 left-1/2 transform -translate-x-1/2 bg-black rounded-full blur-sm transition-all duration-150 ${
              isMoving ? "w-10 h-2 opacity-30" : "w-12 h-3 opacity-20"
            }`}
          ></div>

          {/* Movement effects */}
          {isMoving && (
            <>
              <div className="absolute inset-0 bg-blue-400 rounded-full animate-ping opacity-30"></div>
              <div className="absolute -top-1 -right-1 w-3 h-3 bg-yellow-400 rounded-full animate-bounce"></div>
            </>
          )}
        </div>
      </div>

      {/* Controls info */}
      <div className="absolute bottom-4 left-4 bg-white/90 backdrop-blur-sm px-4 py-3 rounded-xl shadow-lg">
        <p className="text-xs font-semibold text-gray-700 mb-1">Điều khiển:</p>
        <div className="flex gap-2 text-xs text-gray-600">
          <span className="px-2 py-1 bg-gray-200 rounded">↑↓←→</span>
          <span>hoặc</span>
          <span className="px-2 py-1 bg-gray-200 rounded">WASD</span>
        </div>
      </div>

      {/* Progress indicator */}
      <div className="absolute top-4 right-4 bg-white/90 backdrop-blur-sm px-4 py-3 rounded-xl shadow-lg">
        <p className="text-xs font-semibold text-gray-700 mb-1">Tiến độ:</p>
        <div className="flex gap-1">
          {[0, 1, 2].map((i) => (
            <div
              key={i}
              className={`w-8 h-8 rounded-full flex items-center justify-center ${
                completedGates.includes(i)
                  ? "bg-green-500 text-white"
                  : "bg-gray-300 text-gray-600"
              }`}
            >
              {completedGates.includes(i) ? "✓" : i + 1}
            </div>
          ))}
        </div>
      </div>
    </div>
  );
};
