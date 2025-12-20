export const formatTime = (seconds) => {
  if (!seconds || isNaN(seconds)) return '0:00';
  const mins = Math.floor(seconds / 60);
  const secs = Math.floor(seconds % 60);
  return `${mins}:${secs.toString().padStart(2, '0')}`;
};

export const formatDuration = (seconds) => {
  if (!seconds || isNaN(seconds)) return '0 phút';
  const minutes = Math.floor(seconds / 60);
  return `${minutes} phút`;
};