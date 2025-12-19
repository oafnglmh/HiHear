import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hihear_mo/Services/streak_popup_service.dart';
import 'package:hihear_mo/share/UserShare.dart';
import 'package:lottie/lottie.dart';
import 'package:hihear_mo/domain/entities/lesson/lession_entity.dart';
import 'package:hihear_mo/presentation/blocs/lesson/lesson_bloc.dart';
import 'package:hihear_mo/core/constants/app_assets.dart';
import '../../../painter/lotus_pattern_painter.dart';
import '../../../painter/ripple_painter.dart';
import 'models/vocab_question.dart';
import 'dart:math' as math;

class VocabLessonPage extends StatefulWidget {
  final String id;
  const VocabLessonPage({super.key, required this.id});

  @override
  State<VocabLessonPage> createState() => _VocabLessonPageState();
}

class _VocabLessonPageState extends State<VocabLessonPage>
    with TickerProviderStateMixin {
  int _currentQuestionIndex = 0;
  int _correctAnswers = 0;
  bool _hasAnswered = false;
  String? _selectedAnswer;
  late AnimationController _feedbackController;
  late AnimationController _lotusController;
  late AnimationController _floatingController;
  late AnimationController _rippleController;
  List<VocabQuestion> _questions = [];

  bool get _isCorrect =>
      _selectedAnswer == _questions[_currentQuestionIndex].correctAnswer;

  @override
  void initState() {
    super.initState();
    context.read<LessonBloc>().add(LessonEvent.loadLessonById(widget.id));

    _feedbackController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _lotusController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 4000),
    )..repeat(reverse: true);

    _floatingController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    )..repeat(reverse: true);

    _rippleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    )..repeat();
  }

  @override
  void dispose() {
    _feedbackController.dispose();
    _lotusController.dispose();
    _floatingController.dispose();
    _rippleController.dispose();
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
      builder: (context) => _FeedbackBottomSheet(
        isCorrect: _isCorrect,
        explanation: _questions[_currentQuestionIndex].explanation,
        correctAnswer: _questions[_currentQuestionIndex].correctAnswer,
        onSave: () async {
          print("Saving vocabulary...");
          UserShare().debugPrint();

          await UserShare().loadUser();
          print("AFTER loadUser()");
          UserShare().debugPrint();

          final question = _questions[_currentQuestionIndex];

          context.read<LessonBloc>().add(
            LessonEvent.saveVocabulary(
              word: question.question,
              meaning: question.correctAnswer,
              category: "Từ Vựng",
              userId: UserShare().id ?? '',
            ),
          );
        },

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
      builder: (context) => _ResultDialog(
        percentage: percentage,
        isPassed: isPassed,
        correctAnswers: _correctAnswers,
        totalQuestions: _questions.length,
        onComplete: () async {
          if (isPassed) {
            UserShare().debugPrint();
            context.read<LessonBloc>().add(
              LessonEvent.saveCompleteLesson(
                lessonId: widget.id,
                userId: UserShare().id ?? '',
              ),
            );
            final userId = UserShare().id;
            if (userId != null && userId.isNotEmpty) {
              await StreakPopupService().markLessonCompleted(userId);
              print('[VocabLesson] Marked completed for user: $userId');
            }
          }
          context.go('/home');
        },
      ),
    );
  }

  List<VocabQuestion> _buildQuestions(List<LessionEntity> lessons) {
    if (lessons.isEmpty) return [];

    return lessons.first.exercises
        .expand((e) => e.vocabularies)
        .map(
          (v) => VocabQuestion(
            question: v.question,
            correctAnswer: v.correctAnswer,
            wrongAnswer: v.choices.firstWhere(
              (c) => c != v.correctAnswer,
              orElse: () => '',
            ),
            explanation: 'Học từ: ${v.correctAnswer}',
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LessonBloc, LessonState>(
      builder: (context, state) {
        return state.when(
          initial: () => const Scaffold(body: SizedBox.shrink()),
          loading: () => Scaffold(
            body: Stack(
              fit: StackFit.expand,
              children: [
                _buildLotusBackground(),
                const Center(
                  child: CircularProgressIndicator(color: Color(0xFFD4AF37)),
                ),
              ],
            ),
          ),
          data: (lessons) {
            _questions = _buildQuestions(lessons);

            if (_questions.isEmpty) {
              return Scaffold(
                body: Stack(
                  fit: StackFit.expand,
                  children: [
                    _buildLotusBackground(),
                    const Center(
                      child: Text(
                        'Không có câu hỏi',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ],
                ),
              );
            }

            final progress = (_currentQuestionIndex + 1) / _questions.length;
            final currentQuestion = _questions[_currentQuestionIndex];

            return Scaffold(
              body: Stack(
                fit: StackFit.expand,
                children: [
                  _buildLotusBackground(),
                  SafeArea(
                    child: Column(
                      children: [
                        _buildHeader(progress),
                        Expanded(child: _buildQuestionContent(currentQuestion)),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
          error: (message) => Scaffold(
            body: Stack(
              fit: StackFit.expand,
              children: [
                _buildLotusBackground(),
                Center(
                  child: Text(
                    'Lỗi: $message',
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildLotusBackground() {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF0A5C36),
                Color(0xFF1B7F4E),
                Color(0xFF0D6B3D),
                Color(0xFF0D4D2D),
              ],
            ),
          ),
        ),

        AnimatedBuilder(
          animation: _lotusController,
          builder: (context, child) {
            return CustomPaint(
              painter: LotusPatternPainter(
                animationValue: _lotusController.value,
              ),
              size: Size.infinite,
            );
          },
        ),

        AnimatedBuilder(
          animation: _rippleController,
          builder: (context, child) {
            return CustomPaint(
              painter: RipplePainter(animationValue: _rippleController.value),
              size: Size.infinite,
            );
          },
        ),
      ],
    );
  }

  Widget _buildHeader(double progress) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white.withOpacity(0.95),
            Colors.white.withOpacity(0.9),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFD4AF37), width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () => context.go('/home'),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1B7F4E).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.close,
                    color: Color(0xFF1B7F4E),
                    size: 22,
                  ),
                ),
              ),
              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Từ vựng cơ bản',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2D5016),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Câu ${_currentQuestionIndex + 1}/${_questions.length}',
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),

              AnimatedBuilder(
                animation: _floatingController,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(
                      0,
                      math.sin(_floatingController.value * math.pi * 2) * 3,
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFFD4AF37), Color(0xFFB8941E)],
                        ),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFD4AF37).withOpacity(0.4),
                            blurRadius: 8,
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.star, color: Colors.white, size: 16),
                          const SizedBox(width: 4),
                          Text(
                            '$_correctAnswers',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),

          const SizedBox(height: 12),

          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 8,
              backgroundColor: Colors.grey[200],
              valueColor: const AlwaysStoppedAnimation<Color>(
                Color(0xFFD4AF37),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionContent(VocabQuestion question) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: _floatingController,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(
                    0,
                    math.sin(_floatingController.value * math.pi * 2) * 5,
                  ),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.white.withOpacity(0.95),
                          Colors.white.withOpacity(0.9),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: const Color(0xFFD4AF37),
                        width: 3,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 25,
                          offset: const Offset(0, 10),
                        ),
                        BoxShadow(
                          color: const Color(0xFFD4AF37).withOpacity(0.3),
                          blurRadius: 30,
                          spreadRadius: -5,
                          offset: const Offset(0, 15),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFFD4AF37), Color(0xFFB8941E)],
                            ),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFFD4AF37).withOpacity(0.4),
                                blurRadius: 15,
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.local_florist,
                            color: Colors.white,
                            size: 32,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          question.question,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Color(0xFF2D5016),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 32),

            _buildAnswerOptions(question),
          ],
        ),
      ),
    );
  }

  Widget _buildAnswerOptions(VocabQuestion question) {
    final answers = [question.correctAnswer, question.wrongAnswer]..shuffle();

    return Column(
      children: answers
          .map(
            (answer) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: _buildAnswerOption(answer, question),
            ),
          )
          .toList(),
    );
  }

  Widget _buildAnswerOption(String answer, VocabQuestion question) {
    final isSelected = _selectedAnswer == answer;
    final isCorrect = answer == question.correctAnswer;
    final showResult = _hasAnswered && isSelected;
    Color borderColor;
    Color backgroundColor;
    Widget? trailing;

    if (showResult) {
      if (isCorrect) {
        borderColor = const Color(0xFFD4AF37);
        backgroundColor = const Color(0xFFD4AF37).withOpacity(0.15);
        trailing = Container(
          padding: const EdgeInsets.all(6),
          decoration: const BoxDecoration(
            color: Color(0xFFD4AF37),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.check, color: Colors.white, size: 20),
        );
      } else {
        borderColor = Colors.grey;
        backgroundColor = Colors.grey.withOpacity(0.1);
        trailing = Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: Colors.grey[600],
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.close, color: Colors.white, size: 20),
        );
      }
    } else {
      borderColor = const Color(0xFFD4AF37).withOpacity(0.3);
      backgroundColor = Colors.white.withOpacity(0.95);
      trailing = null;
    }

    return GestureDetector(
      onTap: () => _selectAnswer(answer),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: borderColor, width: 2.5),
          boxShadow: [
            BoxShadow(
              color: borderColor.withOpacity(0.2),
              blurRadius: showResult && isCorrect ? 15 : 5,
              offset: Offset(0, showResult && isCorrect ? 8 : 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                answer,
                style: const TextStyle(
                  color: Color(0xFF2D5016),
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            if (trailing != null) ...[const SizedBox(width: 12), trailing],
          ],
        ),
      ),
    );
  }
}

class _FeedbackBottomSheet extends StatelessWidget {
  final bool isCorrect;
  final String explanation;
  final String correctAnswer;
  final VoidCallback onSave;
  final VoidCallback onNext;

  const _FeedbackBottomSheet({
    required this.isCorrect,
    required this.explanation,
    required this.correctAnswer,
    required this.onSave,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.white, Colors.white.withOpacity(0.98)],
        ),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 20),

          Lottie.asset(
            isCorrect ? AppAssets.passAnimation : AppAssets.errorAnimation,
            height: 120,
            width: 120,
            repeat: false,
          ),
          const SizedBox(height: 16),

          Text(
            isCorrect ? 'Chính xác! ' : 'Sai rồi! ',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: isCorrect
                  ? const Color(0xFF1B7F4E)
                  : const Color(0xFFDA291C),
            ),
          ),
          const SizedBox(height: 12),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFD4AF37).withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: const Color(0xFFD4AF37).withOpacity(0.3),
                width: 1.5,
              ),
            ),
            child: Column(
              children: [
                const Row(
                  children: [
                    Icon(
                      Icons.lightbulb_outline,
                      color: Color(0xFFD4AF37),
                      size: 20,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Giải thích',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2D5016),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  explanation,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey[800],
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          Row(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  height: 54,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFD4AF37).withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: onSave,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFD4AF37),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.bookmark, size: 20),
                        const SizedBox(width: 6),
                        Flexible(
                          child: Text(
                            'Lưu từ',
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.3,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),

              Expanded(
                flex: 3,
                child: Container(
                  height: 54,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF1B7F4E).withOpacity(0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: onNext,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1B7F4E),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Tiếp tục',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                        ),
                        SizedBox(width: 8),
                        Icon(Icons.arrow_forward_rounded, size: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ResultDialog extends StatelessWidget {
  final int percentage;
  final bool isPassed;
  final int correctAnswers;
  final int totalQuestions;
  final VoidCallback onComplete;

  const _ResultDialog({
    required this.percentage,
    required this.isPassed,
    required this.correctAnswers,
    required this.totalQuestions,
    required this.onComplete,
  });

  @override
  Widget build(BuildContext context) {
    final color = isPassed ? const Color(0xFF1B7F4E) : const Color(0xFFDA291C);

    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 380),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.white.withOpacity(0.98)],
          ),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: const Color(0xFFD4AF37), width: 2),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.3),
              blurRadius: 30,
              offset: const Offset(0, 15),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [color.withOpacity(0.1), color.withOpacity(0.05)],
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(22),
                  topRight: Radius.circular(22),
                ),
              ),
              child: Column(
                children: [
                  Lottie.asset(
                    isPassed
                        ? AppAssets.passAnimation
                        : AppAssets.errorAnimation,
                    height: 150,
                    width: 150,
                    repeat: false,
                  ),
                  const SizedBox(height: 12),

                  Text(
                    isPassed ? 'Xuất sắc! ' : 'Cố gắng lên! ',
                    style: TextStyle(
                      color: color,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    isPassed
                        ? 'Bạn đã vượt qua bài kiểm tra!'
                        : 'Hãy thử lại để đạt kết quả tốt hơn',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        height: 140,
                        width: 140,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: color.withOpacity(0.08),
                        ),
                      ),
                      SizedBox(
                        height: 120,
                        width: 120,
                        child: CircularProgressIndicator(
                          value: percentage / 100,
                          strokeWidth: 10,
                          backgroundColor: Colors.grey.withOpacity(0.15),
                          valueColor: AlwaysStoppedAnimation(color),
                          strokeCap: StrokeCap.round,
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '$percentage%',
                            style: TextStyle(
                              fontSize: 38,
                              fontWeight: FontWeight.bold,
                              color: color,
                              height: 1,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'điểm số',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: const Color(0xFFD4AF37).withOpacity(0.2),
                        width: 1.5,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildStatItem(
                          Icons.check_circle_rounded,
                          'Đúng',
                          '$correctAnswers',
                          const Color(0xFF1B7F4E),
                        ),
                        Container(
                          height: 40,
                          width: 1,
                          color: Colors.grey[300],
                        ),
                        _buildStatItem(
                          Icons.cancel_rounded,
                          'Sai',
                          '${totalQuestions - correctAnswers}',
                          const Color(0xFFDA291C),
                        ),
                        Container(
                          height: 40,
                          width: 1,
                          color: Colors.grey[300],
                        ),
                        _buildStatItem(
                          Icons.format_list_numbered_rounded,
                          'Tổng',
                          '$totalQuestions',
                          const Color(0xFFD4AF37),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  Container(
                    width: double.infinity,
                    height: 54,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: color.withOpacity(0.3),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: onComplete,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: color,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.home_rounded, size: 22),
                          SizedBox(width: 8),
                          Text(
                            'Hoàn thành',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(
    IconData icon,
    String label,
    String value,
    Color color,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color, size: 24),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: color,
            height: 1,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
