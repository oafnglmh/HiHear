import 'package:equatable/equatable.dart';

class SpeakingState extends Equatable {
  final bool isRecording;
  final bool showFeedback;
  final bool showPopup;
  final int currentLesson;
  final double score;
  final String feedback;

  const SpeakingState({
    this.isRecording = false,
    this.showFeedback = false,
    this.showPopup = false,
    this.currentLesson = 0,
    this.score = 0,
    this.feedback = "",
  });

  SpeakingState copyWith({
    bool? isRecording,
    bool? showFeedback,
    bool? showPopup,
    int? currentLesson,
    double? score,
    String? feedback,
  }) {
    return SpeakingState(
      isRecording: isRecording ?? this.isRecording,
      showFeedback: showFeedback ?? this.showFeedback,
      showPopup: showPopup ?? this.showPopup,
      currentLesson: currentLesson ?? this.currentLesson,
      score: score ?? this.score,
      feedback: feedback ?? this.feedback,
    );
  }

  @override
  List<Object?> get props => [
    isRecording,
    showFeedback,
    showPopup,
    currentLesson,
    score,
    feedback,
  ];
}
