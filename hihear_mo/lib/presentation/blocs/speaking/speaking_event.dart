import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class SpeakingEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ToggleRecording extends SpeakingEvent {}

class NextLesson extends SpeakingEvent {
  final BuildContext context;
  NextLesson(this.context);
}

class ShowFeedbackPopup extends SpeakingEvent {}

class HideFeedbackPopup extends SpeakingEvent {}
