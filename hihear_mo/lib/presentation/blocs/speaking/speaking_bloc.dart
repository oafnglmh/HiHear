import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'speaking_event.dart';
import 'speaking_state.dart';

class SpeakingBloc extends Bloc<SpeakingEvent, SpeakingState> {
  final List<String> lessons = const [
    "Hello, how are you?",
    "Nice to meet you!",
    "I love learning English.",
  ];

  SpeakingBloc() : super(const SpeakingState()) {
    on<ToggleRecording>(_onToggleRecording);
    on<NextLesson>(_onNextLesson);
    on<ShowFeedbackPopup>((event, emit) {
      emit(state.copyWith(showPopup: true));
    });
    on<HideFeedbackPopup>((event, emit) {
      emit(state.copyWith(showPopup: false));
    });
  }

  Future<void> _onToggleRecording(
    ToggleRecording event,
    Emitter<SpeakingState> emit,
  ) async {
    if (state.isRecording) {
      emit(state.copyWith(isRecording: false));
      await Future.delayed(const Duration(seconds: 1));

      final score =
          75 + (25 * (0.5 - (DateTime.now().millisecond % 100) / 100));
      emit(
        state.copyWith(
          score: score,
          feedback: "Good effort! Try to improve pronunciation clarity.",
        ),
      );

      add(ShowFeedbackPopup());
    } else {
      emit(state.copyWith(isRecording: true, showFeedback: false));
    }
  }

  void _onNextLesson(NextLesson event, Emitter<SpeakingState> emit) {
    final nextIndex = (state.currentLesson + 1) % lessons.length;
    emit(state.copyWith(currentLesson: nextIndex, showPopup: false));
  }
}
