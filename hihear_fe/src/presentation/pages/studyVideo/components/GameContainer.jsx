import React, { useState, useEffect } from "react";
import { X, Info } from "lucide-react";
import { GameCanvas } from "./GameCanvas";
import { GameChallengeModal } from "./GameChallengeModal";
import { GameResultModal } from "./GameResultModal";
import { usePlayerMovement } from "../hooks/usePlayerMovement";
import { getGateChallenge } from "../services/gameChallengeService";
import { GAME_STATES } from "../utils/gameConstants";
import { AppAssets } from "../../../../Core/constant/AppAssets";

export const GameContainer = ({
  gameState,
  completedGates,
  currentGate,
  onGateReached,
  onChallengeSuccess,
  onChallengeFailed,
  onGameComplete,
  onClose,
}) => {
  const [currentChallenge, setCurrentChallenge] = useState(null);
  const [showChallengeModal, setShowChallengeModal] = useState(false);
  const [showResultModal, setShowResultModal] = useState(false);

  const isPlaying = gameState === GAME_STATES.PLAYING && !showChallengeModal;

  const handleGateReach = (gateIndex) => {
    if (completedGates.includes(gateIndex)) return;
    if (gateIndex > 0 && !completedGates.includes(gateIndex - 1)) return;

    onGateReached(gateIndex);
    const challenge = getGateChallenge(gateIndex);
    setCurrentChallenge(challenge);
    setShowChallengeModal(true);
  };

  const { playerPos, resetPosition } = usePlayerMovement(
    handleGateReach,
    isPlaying
  );

  const handleChallengeSuccess = () => {
    setShowChallengeModal(false);
    const gameCompleted = onChallengeSuccess();

    if (gameCompleted) {
      setTimeout(() => {
        setShowResultModal(true);
      }, 500);
    }
  };

  const handleChallengeFailed = () => {
    setShowChallengeModal(false);
    onChallengeFailed();

    setTimeout(() => {
      setShowResultModal(true);
    }, 500);
  };

  const handleCloseChallenge = () => {
    setShowChallengeModal(false);
  };

  const handleCloseResult = () => {
    setShowResultModal(false);
    onClose();
  };

  return (
    <div className="fixed inset-0 bg-gradient-to-br from-purple-900 via-blue-900 to-teal-900 flex items-center justify-center z-40 p-4">
      <div className="max-w-6xl w-full">
        <div className="flex items-center justify-between mb-6">
          <div className="flex items-center gap-4">
            <div className="bg-white/10 backdrop-blur-md px-6 py-3 rounded-2xl border border-white/20">
              <h2 className="text-2xl font-bold text-white">
                Phiêu lưu học tiếng Việt
              </h2>
            </div>

            <div className="bg-amber-500/90 backdrop-blur-md px-4 py-2 rounded-xl flex items-center gap-2">
              <Info size={20} className="text-white" />
              <span className="text-white font-semibold text-sm">
                Đi đến cổng và trả lời đúng để nhận lượt học!
              </span>
            </div>
          </div>

          <button
            onClick={onClose}
            className="bg-red-500 hover:bg-red-600 text-white p-3 rounded-xl transition-colors"
          >
            <X size={24} />
          </button>
        </div>

        <GameCanvas
          playerPos={playerPos}
          completedGates={completedGates}
          onGateClick={handleGateReach}
          direction="right"
          playerImage={AppAssets.logo}
        />

        <div className="mt-6 bg-white/10 backdrop-blur-md px-6 py-4 rounded-2xl border border-white/20">
          <p className="text-white text-center">
            <span className="font-bold">Mục tiêu:</span> Di chuyển nhân vật đến
            3 cổng và trả lời đúng các câu hỏi tiếng Việt để nhận thêm lượt học!
          </p>
        </div>
      </div>

      {showChallengeModal && currentChallenge && (
        <GameChallengeModal
          challenge={currentChallenge}
          onSuccess={handleChallengeSuccess}
          onFail={handleChallengeFailed}
          onClose={handleCloseChallenge}
        />
      )}

      {showResultModal && (
        <GameResultModal
          isSuccess={gameState === GAME_STATES.COMPLETED}
          onClose={handleCloseResult}
          onAddLesson={onGameComplete}
        />
      )}
    </div>
  );
};
