import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:hihear_mo/presentation/pages/lession/vocab_complete_page.dart'
    show VocabCompletePage;
import 'vocab_event.dart';
import 'vocab_state.dart';

class VocabBloc extends Bloc<VocabEvent, VocabState> {
  final FlutterTts tts = FlutterTts();

  VocabBloc()
    : super(
        VocabState(
          currentIndex: 0,
          vocabList: [
            {
              "word": "Apple",
              "vn": "Táo",
              "image": "assets/images/HearuSad.png",
              "options": ["Táo", "Cam"],
              "correct": 0,
            },
            {
              "word": "Dog",
              "vn": "Chó",
              "image": "assets/images/HearuSad.png",
              "options": ["Mèo", "Chó"],
              "correct": 1,
            },
            {
              "word": "Cat",
              "vn": "Mèo",
              "image": "assets/images/HearuSad.png",
              "options": ["Mèo", "Chó"],
              "correct": 0,
            },
            {
              "word": "Orange",
              "vn": "Cam",
              "image": "assets/images/HearuSad.png",
              "options": ["Cam", "Táo"],
              "correct": 0,
            },
          ],
        ),
      ) {
    on<LoadVocab>((event, emit) => emit(state));
    on<SelectAnswer>(_onSelectAnswer);
    on<NextWord>(_onNextWord);
    on<PlaySound>(_onPlaySound);
    on<MatchWord>(_onMatchWord);
    on<TypeLetter>(_onTypeLetter);
    on<CheckInput>(_onCheckInput);
    on<ResetInput>(_onResetInput);
    on<UpdateInput>(_onUpdateInput);
  }

  void _onSelectAnswer(SelectAnswer event, Emitter<VocabState> emit) {
    final current = state.vocabList[state.currentIndex];
    final correct = event.selectedIndex == current['correct'];
    emit(state.copyWith(isCorrect: correct));
  }

  void _onUpdateInput(UpdateInput event, Emitter<VocabState> emit) {
    emit(state.copyWith(currentInput: event.input, inputCorrect: null));
  }

  void _onNextWord(NextWord event, Emitter<VocabState> emit) {
    if (state.currentIndex < state.vocabList.length - 1) {
      emit(
        state.copyWith(currentIndex: state.currentIndex + 1, isCorrect: null),
      );
    }
  }

  Future<void> _onPlaySound(PlaySound event, Emitter<VocabState> emit) async {
    await tts.setLanguage("en-US");
    await tts.setPitch(1);
    await tts.speak(event.word);
  }

  void _onMatchWord(MatchWord event, Emitter<VocabState> emit) {
    final correct = state.vocabList.any(
      (v) => v['word'] == event.english && v['vn'] == event.vietnamese,
    );
    if (correct) {
      final newMatched = Map<String, String>.from(state.matched)
        ..[event.english] = event.vietnamese;
      emit(state.copyWith(matched: newMatched));
    }
  }

  void _onTypeLetter(TypeLetter event, Emitter<VocabState> emit) {
    emit(state.copyWith(currentInput: state.currentInput + event.letter));
  }

  Future<void> _onCheckInput(CheckInput event, Emitter<VocabState> emit) async {
    final checkingIndex = state.currentIndex;

    final target = state.vocabList[checkingIndex]['word']
        .toString()
        .trim()
        .toUpperCase();
    final input = state.currentInput.trim().toUpperCase();
    final bool isCorrect = input == target;

    emit(state.copyWith(inputCorrect: isCorrect));

    await Future.delayed(const Duration(seconds: 4));

    if (state.currentIndex != checkingIndex) return;

    if (isCorrect) {
      if (checkingIndex < state.vocabList.length - 1) {
        emit(
          state.copyWith(
            currentIndex: checkingIndex + 1,
            currentInput: '',
            inputCorrect: null,
          ),
        );
      } else {
        emit(state.copyWith(currentInput: '', inputCorrect: null));
        await Future.delayed(const Duration(milliseconds: 500));
        Navigator.pushReplacement(
          event.context,
          MaterialPageRoute(builder: (_) => const VocabCompletePage()),
        );
      }
    } else {
      emit(state.copyWith(inputCorrect: null));
    }
  }

  void _onResetInput(ResetInput event, Emitter<VocabState> emit) {
    emit(state.copyWith(currentInput: "", inputCorrect: null));
  }
}
