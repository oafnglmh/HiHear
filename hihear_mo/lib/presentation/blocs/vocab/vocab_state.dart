import 'package:equatable/equatable.dart';

const _noInputCorrect = Object();

class VocabState extends Equatable {
  final int currentIndex;
  final bool? isCorrect;
  final List<Map<String, dynamic>> vocabList;
  final Map<String, String> matched;
  final String currentInput;
  final bool? inputCorrect;

  const VocabState({
    required this.currentIndex,
    required this.vocabList,
    this.isCorrect,
    this.matched = const {},
    this.currentInput = "",
    this.inputCorrect,
  });

  VocabState copyWith({
    int? currentIndex,
    bool? isCorrect,
    Map<String, String>? matched,
    String? currentInput,
    Object? inputCorrect = _noInputCorrect,
  }) {
    final bool? _inputCorrectValue = inputCorrect == _noInputCorrect
        ? this.inputCorrect
        : inputCorrect as bool?;
    return VocabState(
      currentIndex: currentIndex ?? this.currentIndex,
      vocabList: vocabList,
      isCorrect: isCorrect,
      matched: matched ?? this.matched,
      currentInput: currentInput ?? this.currentInput,
      inputCorrect: _inputCorrectValue,
    );
  }

  @override
  List<Object?> get props => [
    currentIndex,
    isCorrect,
    vocabList,
    matched,
    currentInput,
    inputCorrect,
  ];
}
