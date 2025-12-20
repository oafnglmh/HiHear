import React from 'react';
import { ArrowLeft, Clock, Award } from 'lucide-react';
import { VideoControls } from './VideoControls';
import { SubtitleDisplay } from './SubtitleDisplay';
import { useVideoPlayer } from '../hooks/useVideoPlayer';
import { useSubtitles } from '../hooks/useSubtitles';
import { getLevelColor } from '../utils/lessonHelpers';
import { formatDuration } from '../utils/timeFormatter';
import { formatTime } from '../utils/timeFormatter';

export const VideoPlayer = ({ lesson, onBack, onVideoEnd }) => {
  const { videoRef, isPlaying, currentTime, duration, togglePlayPause, seekTo } =
    useVideoPlayer(onVideoEnd);
  
  const { currentSubtitleVi, currentSubtitleOther } = useSubtitles(
    lesson,
    currentTime
  );

  return (
    <div className="min-h-screen bg-gradient-to-br from-gray-900 to-gray-800">
      <div className="max-w-5xl mx-auto px-4 py-8">
        <button
          onClick={onBack}
          className="flex items-center gap-2 text-white mb-6 hover:text-emerald-400 transition-colors"
        >
          <ArrowLeft size={20} />
          <span className="font-medium">Quay lại</span>
        </button>

        <div className="bg-gray-800 rounded-2xl overflow-hidden shadow-2xl">
          <div className="relative bg-black">
            <video
              ref={videoRef}
              src={lesson.lessonVideo.videoUrl}
              className="w-full aspect-video"
              onClick={togglePlayPause}
            />

            <VideoControls
              isPlaying={isPlaying}
              currentTime={currentTime}
              duration={duration}
              onTogglePlay={togglePlayPause}
              onSeek={seekTo}
              formatTime={formatTime}
            />
          </div>

          <SubtitleDisplay
            subtitleVi={currentSubtitleVi}
            subtitleOther={currentSubtitleOther}
          />

          <div className="p-6 bg-gray-800">
            <div className="flex items-start justify-between mb-4">
              <div>
                <h2 className="text-2xl font-bold text-white mb-2">
                  {lesson.title}
                </h2>
                <p className="text-gray-400">{lesson.description}</p>
              </div>
            </div>

            <div className="flex items-center gap-4 text-sm text-gray-400">
              <div className="flex items-center gap-1">
                <Clock size={16} />
                <span>{formatDuration(lesson.durationSeconds)}</span>
              </div>
              <div className="flex items-center gap-1">
                <Award size={16} className="text-amber-500" />
                <span>{lesson.xpReward} XP</span>
              </div>
              <div
                className={`px-3 py-1 rounded-full bg-gradient-to-r ${getLevelColor(
                  lesson.level
                )} text-white text-xs font-bold`}
              >
                {lesson.level}
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};