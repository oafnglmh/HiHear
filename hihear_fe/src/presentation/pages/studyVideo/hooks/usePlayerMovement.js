import { useState, useEffect, useCallback } from "react";
import { PLAYER_CONTROLS, GAME_CONFIG } from "../utils/gameConstants";

export const usePlayerMovement = (onReachGate, isPlaying) => {
  const [playerPos, setPlayerPos] = useState({ x: 100, y: 300 });
  const [pressedKeys, setPressedKeys] = useState(new Set());
  const [lastReachedGate, setLastReachedGate] = useState(null);

  useEffect(() => {
    if (!isPlaying) return;

    const handleKeyDown = (e) => {
      const allControls = Object.values(PLAYER_CONTROLS).flat();
      if (allControls.includes(e.key)) {
        e.preventDefault();
        setPressedKeys((prev) => new Set(prev).add(e.key));
      }
    };

    const handleKeyUp = (e) => {
      setPressedKeys((prev) => {
        const newSet = new Set(prev);
        newSet.delete(e.key);
        return newSet;
      });
    };

    window.addEventListener("keydown", handleKeyDown);
    window.addEventListener("keyup", handleKeyUp);

    return () => {
      window.removeEventListener("keydown", handleKeyDown);
      window.removeEventListener("keyup", handleKeyUp);
    };
  }, [isPlaying]);

  useEffect(() => {
    if (!isPlaying || pressedKeys.size === 0) return;

    const moveInterval = setInterval(() => {
      setPlayerPos((prev) => {
        let newX = prev.x;
        let newY = prev.y;

        pressedKeys.forEach((key) => {
          if (PLAYER_CONTROLS.UP.includes(key))
            newY -= GAME_CONFIG.PLAYER_SPEED;
          if (PLAYER_CONTROLS.DOWN.includes(key))
            newY += GAME_CONFIG.PLAYER_SPEED;
          if (PLAYER_CONTROLS.LEFT.includes(key))
            newX -= GAME_CONFIG.PLAYER_SPEED;
          if (PLAYER_CONTROLS.RIGHT.includes(key))
            newX += GAME_CONFIG.PLAYER_SPEED;
        });
        newX = Math.max(20, Math.min(1180, newX));
        newY = Math.max(20, Math.min(580, newY));

        return { x: newX, y: newY };
      });
    }, 30);

    return () => clearInterval(moveInterval);
  }, [pressedKeys, isPlaying]);

  useEffect(() => {
    if (!isPlaying) return;

    GAME_CONFIG.GATE_POSITIONS.forEach((gate, index) => {
      const distance = Math.sqrt(
        Math.pow(playerPos.x - gate.x, 2) + Math.pow(playerPos.y - gate.y, 2)
      );

      if (distance < 60) {
        onReachGate(index);
      }
      if (distance > 80 && lastReachedGate === index) {
        setLastReachedGate(null);
      }
    });
  }, [playerPos, isPlaying, onReachGate]);

  const resetPosition = () => {
    setPlayerPos({ x: 100, y: 300 });
  };

  return {
    playerPos,
    resetPosition,
  };
};
