export const GAME_CONFIG = {
  TOTAL_GATES: 3,
  REWARD_LESSONS: 1,
  PLAYER_SPEED: 5,
  GATE_POSITIONS: [
    { x: 300, y: 400, label: 'Cổng 1' },
    { x: 600, y: 250, label: 'Cổng 2' },
    { x: 900, y: 400, label: 'Cổng 3' },
  ],
};

export const GAME_STORAGE_KEY = 'dailyGamePlayed';

export const PLAYER_CONTROLS = {
  UP: ['ArrowUp', 'W', 'w'],
  DOWN: ['ArrowDown', 'S', 's'],
  LEFT: ['ArrowLeft', 'A', 'a'],
  RIGHT: ['ArrowRight', 'D', 'd'],
};

export const GAME_STATES = {
  PLAYING: 'playing',
  CHALLENGE: 'challenge',
  COMPLETED: 'completed',
  FAILED: 'failed',
};
