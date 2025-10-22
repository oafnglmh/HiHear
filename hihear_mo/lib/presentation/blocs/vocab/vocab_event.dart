import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class VocabEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

// --- Phần cũ ---
class LoadVocab extends VocabEvent {}

class SelectAnswer extends VocabEvent {
  final int selectedIndex;
  SelectAnswer(this.selectedIndex);
  @override
  List<Object?> get props => [selectedIndex];
}

class NextWord extends VocabEvent {}

class PlaySound extends VocabEvent {
  final String word;
  PlaySound(this.word);
  @override
  List<Object?> get props => [word];
}

// --- Phần mới ---
class MatchWord extends VocabEvent {
  final String english;
  final String vietnamese;
  MatchWord(this.english, this.vietnamese);
  @override
  List<Object?> get props => [english, vietnamese];
}

class TypeLetter extends VocabEvent {
  final String letter;
  TypeLetter(this.letter);
  @override
  List<Object?> get props => [letter];
}

class CheckInput extends VocabEvent {
  final BuildContext context;
  CheckInput(this.context);
}

class ResetInput extends VocabEvent {}

class UpdateInput extends VocabEvent {
  final String input;
  UpdateInput(this.input);

  @override
  List<Object?> get props => [input];
}
