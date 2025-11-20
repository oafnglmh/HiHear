import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hihear_mo/domain/entities/lesson/lession_entity.dart';
import 'package:hihear_mo/presentation/blocs/lesson/lesson_bloc.dart';
import 'widgets/lesson_header.dart';
import 'widgets/question_content.dart';
import 'widgets/feedback_bottom_sheet.dart';
import 'widgets/result_dialog.dart';
import 'widgets/gradient_background.dart';
import 'models/vocab_question.dart';

class VocabLessonPage extends StatefulWidget {
  final String id;
  const VocabLessonPage({super.key, required this.id});

  @override
  State<VocabLessonPage> createState() => _VocabLessonPageState();
}

class _VocabLessonPageState extends State<VocabLessonPage>
    with SingleTickerProviderStateMixin {
  int _currentQuestionIndex = 0;
  int _correctAnswers = 0;
  bool _hasAnswered = false;
  String? _selectedAnswer;
  late AnimationController _feedbackController;
  List<VocabQuestion> _questions = [];

  bool get _isCorrect =>
      _selectedAnswer == _questions[_currentQuestionIndex].correctAnswer;

  @override
  void initState() {
    super.initState();
    context.read<LessonBloc>().add(LessionEvent.loadLessonById(widget.id));
    _feedbackController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  void _selectAnswer(String answer) {
    if (_hasAnswered) return;

    setState(() {
      _selectedAnswer = answer;
      _hasAnswered = true;
      if (_isCorrect) _correctAnswers++;
    });

    _feedbackController.forward();
    _showFeedbackBottomSheet();
  }

  void _showFeedbackBottomSheet() {
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      enableDrag: false,
      backgroundColor: Colors.transparent,
      builder: (context) => FeedbackBottomSheet(
        isCorrect: _isCorrect,
        explanation: _questions[_currentQuestionIndex].explanation,
        onNext: () {
          Navigator.pop(context);
          if (_currentQuestionIndex < _questions.length - 1) {
            _nextQuestion();
          } else {
            _showResultDialog();
          }
        },
      ),
    );
  }

  void _nextQuestion() {
    setState(() {
      _currentQuestionIndex++;
      _hasAnswered = false;
      _selectedAnswer = null;
    });
    _feedbackController.reset();
  }

  void _showResultDialog() {
    final percentage = (_correctAnswers / _questions.length * 100).round();
    final isPassed = percentage >= 70;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => ResultDialog(
        percentage: percentage,
        isPassed: isPassed,
        correctAnswers: _correctAnswers,
        totalQuestions: _questions.length,
        onComplete: () => context.go('/home'),
      ),
    );
  }

  List<VocabQuestion> _buildQuestions(List<LessionEntity> lessons) {
    if (lessons.isEmpty) return [];

    return lessons.first.exercises
        .expand((e) => e.vocabularies)
        .map((v) => VocabQuestion(
              question: v.question,
              correctAnswer: v.correctAnswer,
              wrongAnswer: v.choices.firstWhere(
                (c) => c != v.correctAnswer,
                orElse: () => '',
              ),
              explanation: 'Học từ: ${v.correctAnswer}',
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LessonBloc, LessonState>(
      builder: (context, state) {
        return state.when(
          initial: () => const Scaffold(body: SizedBox.shrink()),
          loading: () => const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          ),
          data: (lessons) {
            _questions = _buildQuestions(lessons);

            if (_questions.isEmpty) {
              return const Scaffold(
                body: Center(child: Text('Không có câu hỏi')),
              );
            }

            final progress = (_currentQuestionIndex + 1) / _questions.length;
            final currentQuestion = _questions[_currentQuestionIndex];

            return Scaffold(
              body: Stack(
                children: [
                  const GradientBackground(),
                  SafeArea(
                    child: Column(
                      children: [
                        LessonHeader(
                          progress: progress,
                          currentIndex: _currentQuestionIndex,
                          totalQuestions: _questions.length,
                          correctAnswers: _correctAnswers,
                          onClose: () => context.go('/home'),
                        ),
                        Expanded(
                          child: QuestionContent(
                            question: currentQuestion,
                            hasAnswered: _hasAnswered,
                            selectedAnswer: _selectedAnswer,
                            onAnswerSelected: _selectAnswer,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
          error: (message) => Scaffold(
            body: Center(child: Text('Lỗi: $message')),
          ),
        );
      },
    );
  }
}