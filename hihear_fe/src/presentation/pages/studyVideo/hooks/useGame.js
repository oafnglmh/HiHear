import { useState, useEffect, useCallback } from 'react';
import { GAME_CONFIG, GAME_STATES, GAME_STORAGE_KEY } from '../utils/gameConstants';

export const useGame = () => {
  const [canPlayToday, setCanPlayToday] = useState(true);
  const [currentGate, setCurrentGate] = useState(0);
  const [completedGates, setCompletedGates] = useState([]);
  const [gameState, setGameState] = useState(GAME_STATES.PLAYING);
  const [showGame, setShowGame] = useState(false);

  useEffect(() => {
    checkDailyGameStatus();
  }, []);

  const checkDailyGameStatus = () => {
    const today = new Date().toDateString();
    const savedData = JSON.parse(
      localStorage.getItem(GAME_STORAGE_KEY) || '{}'
    );

    if (savedData.date === today) {
      setCanPlayToday(false);
    } else {
      setCanPlayToday(true);
    }
  };

  const startGame = () => {
    if (!canPlayToday) return false;
    
    setShowGame(true);
    setCurrentGate(0);
    setCompletedGates([]);
    setGameState(GAME_STATES.PLAYING);
    return true;
  };

  const openGateChallenge = (gateIndex) => {
    setCurrentGate(gateIndex);
    setGameState(GAME_STATES.CHALLENGE);
  };

  const completeChallengeSuccess = () => {
    const newCompleted = [...completedGates, currentGate];
    setCompletedGates(newCompleted);

    if (newCompleted.length === GAME_CONFIG.TOTAL_GATES) {
      setGameState(GAME_STATES.COMPLETED);
      markGamePlayedToday();
      return true;
    } else {
      setGameState(GAME_STATES.PLAYING);
      return false;
    }
  };

  const completeChallengeFailed = () => {
    setGameState(GAME_STATES.FAILED);
    markGamePlayedToday();
  };

  const markGamePlayedToday = () => {
    const today = new Date().toDateString();
    localStorage.setItem(
      GAME_STORAGE_KEY,
      JSON.stringify({ date: today })
    );
    setCanPlayToday(false);
  };

  const closeGame = () => {
    setShowGame(false);
    setCurrentGate(0);
    setCompletedGates([]);
    setGameState(GAME_STATES.PLAYING);
  };

  return {
    canPlayToday,
    currentGate,
    completedGates,
    gameState,
    showGame,
    startGame,
    openGateChallenge,
    completeChallengeSuccess,
    completeChallengeFailed,
    closeGame,
  };
};