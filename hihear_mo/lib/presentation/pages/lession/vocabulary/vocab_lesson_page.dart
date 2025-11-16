import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hihear_mo/core/constants/app_assets.dart';
import 'package:hihear_mo/core/constants/app_colors.dart';
import 'package:hihear_mo/core/constants/app_constants.dart';
import 'package:hihear_mo/core/constants/app_text_styles.dart';
import 'package:lottie/lottie.dart';

class VocabLessonPage extends StatefulWidget {
  const VocabLessonPage({super.key});

  @override
  State<VocabLessonPage> createState() => _VocabLessonPageState();
}

class _VocabLessonPageState extends State<VocabLessonPage>
    with TickerProviderStateMixin {
  int _currentQuestionIndex = 0;
  int _correctAnswers = 0;
  bool _hasAnswered = false;
  bool _isCorrect = false;
  String? _selectedAnswer;

  late AnimationController _progressController;
  late AnimationController _feedbackController;

  final List<VocabQuestion> _questions = [
    VocabQuestion(
      question: '"Xin chào" trong tiếng Việt có nghĩa là gì?',
      correctAnswer: 'Hello',
      wrongAnswer: 'Goodbye',
      explanation: 'Xin chào là lời chào hỏi khi gặp mặt',
    ),
    VocabQuestion(
      question: '"Cảm ơn" nghĩa là gì?',
      correctAnswer: 'Thank you',
      wrongAnswer: 'Sorry',
      explanation: 'Cảm ơn dùng để bày tỏ lòng biết ơn',
    ),
    VocabQuestion(
      question: '"Tạm biệt" có nghĩa là gì?',
      correctAnswer: 'Goodbye',
      wrongAnswer: 'Hello',
      explanation: 'Tạm biệt là lời chào khi chia tay',
    ),
    VocabQuestion(
      question: '"Xin lỗi" nghĩa là gì?',
      correctAnswer: 'Sorry',
      wrongAnswer: 'Excuse me',
      explanation: 'Xin lỗi dùng khi muốn xin lỗi ai đó',
    ),
    VocabQuestion(
      question: '"Vâng" có nghĩa là gì?',
      correctAnswer: 'Yes',
      wrongAnswer: 'No',
      explanation: 'Vâng là cách nói đồng ý một cách lịch sự',
    ),
    VocabQuestion(
      question: '"Không" nghĩa là gì?',
      correctAnswer: 'No',
      wrongAnswer: 'Maybe',
      explanation: 'Không là cách từ chối hoặc phủ định',
    ),
    VocabQuestion(
      question: '"Tên tôi là..." có nghĩa là gì?',
      correctAnswer: 'My name is...',
      wrongAnswer: 'I am from...',
      explanation: 'Dùng để giới thiệu tên của bản thân',
    ),
    VocabQuestion(
      question: '"Rất vui được gặp bạn" nghĩa là gì?',
      correctAnswer: 'Nice to meet you',
      wrongAnswer: 'See you later',
      explanation: 'Câu nói thể hiện sự vui mừng khi gặp ai đó',
    ),
    VocabQuestion(
      question: '"Bạn khỏe không?" có nghĩa là gì?',
      correctAnswer: 'How are you?',
      wrongAnswer: 'What is your name?',
      explanation: 'Câu hỏi thăm về tình trạng sức khỏe',
    ),
    VocabQuestion(
      question: '"Tôi khỏe" nghĩa là gì?',
      correctAnswer: 'I am fine',
      wrongAnswer: 'I am tired',
      explanation: 'Trả lời khi ai đó hỏi thăm sức khỏe',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _progressController = AnimationController(
      vsync: this,
      duration: AppDuration.medium,
    );
    _feedbackController = AnimationController(
      vsync: this,
      duration: AppDuration.long,
    );
  }

  @override
  void dispose() {
    _progressController.dispose();
    _feedbackController.dispose();
    super.dispose();
  }

  void _selectAnswer(String answer) {
    if (_hasAnswered) return;

    setState(() {
      _selectedAnswer = answer;
      _hasAnswered = true;
      _isCorrect = answer == _questions[_currentQuestionIndex].correctAnswer;
      if (_isCorrect) _correctAnswers++;
    });

    _feedbackController.forward();

    // Show bottom sheet feedback
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
      _isCorrect = false;
      _selectedAnswer = null;
    });
    _feedbackController.reset();
    _progressController.forward(from: 0);
  }

  void _showResultDialog() {
    final percentage = (_correctAnswers / _questions.length * 100).round();
    final isPassed = percentage >= 70;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: Container(
          constraints: BoxConstraints(maxWidth: 380),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(AppRadius.xLarge),
            boxShadow: [
              BoxShadow(
                color: (isPassed ? AppColors.bamboo1 : AppColors.vietnamRed)
                    .withOpacity(0.3),
                blurRadius: 30,
                offset: Offset(0, 15),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.only(
                  top: AppPadding.xxLarge,
                  left: AppPadding.xxLarge,
                  right: AppPadding.xxLarge,
                  bottom: AppPadding.xLarge,
                ),
                child: Column(
                  children: [
                    Lottie.asset(
                        isPassed
                            ? AppAssets.passAnimation
                            : AppAssets.errorAnimation,
                        height: 200,
                        width: 200,
                        repeat: false,
                      ),
                    
                    SizedBox(height: AppPadding.small),
                    Text(
                      isPassed ? 'Xuất sắc!' : 'Cố gắng lên!',
                      style: TextStyle(
                        color: AppColors.bamboo1,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                    SizedBox(height: AppPadding.small),
                    Text(
                      isPassed
                          ? 'Bạn đã vượt qua bài kiểm tra!'
                          : 'Hãy thử lại để đạt kết quả tốt hơn',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.bamboo1.withOpacity(0.95),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),

              // Body content
              Padding(
                padding: EdgeInsets.all(AppPadding.xxLarge),
                child: Column(
                  children: [
                    // Circular progress indicator
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        // Background circle
                        Container(
                          height: 160,
                          width: 160,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color:
                                (isPassed
                                        ? AppColors.bamboo1
                                        : AppColors.vietnamRed)
                                    .withOpacity(0.08),
                          ),
                        ),
                        // Progress indicator
                        SizedBox(
                          height: 140,
                          width: 140,
                          child: CircularProgressIndicator(
                            value: percentage / 100,
                            strokeWidth: 12,
                            backgroundColor: Colors.grey.withOpacity(0.15),
                            valueColor: AlwaysStoppedAnimation<Color>(
                              isPassed
                                  ? AppColors.bamboo1
                                  : AppColors.vietnamRed,
                            ),
                            strokeCap: StrokeCap.round,
                          ),
                        ),
                        // Score text
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '$percentage%',
                              style: TextStyle(
                                fontSize: 42,
                                fontWeight: FontWeight.bold,
                                color: isPassed
                                    ? AppColors.bamboo1
                                    : AppColors.vietnamRed,
                                height: 1,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'điểm số',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey[600],
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    SizedBox(height: AppPadding.xLarge),

                    // Stats container
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppPadding.large,
                        vertical: AppPadding.medium,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(AppRadius.large),
                        border: Border.all(color: Colors.grey[200]!, width: 1),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildStatItem(
                            icon: Icons.check_circle_rounded,
                            label: 'Đúng',
                            value: '$_correctAnswers',
                            color: AppColors.bamboo1,
                          ),
                          _buildVerticalDivider(),
                          _buildStatItem(
                            icon: Icons.cancel_rounded,
                            label: 'Sai',
                            value: '${_questions.length - _correctAnswers}',
                            color: AppColors.vietnamRed,
                          ),
                          _buildVerticalDivider(),
                          _buildStatItem(
                            icon: Icons.format_list_numbered_rounded,
                            label: 'Tổng',
                            value: '${_questions.length}',
                            color: Colors.blue[600]!,
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: AppPadding.xLarge),

                    // Action buttons
                    Row(
                      children: [
                        
                        Expanded(
                          flex: isPassed ? 1 : 1,
                          child: _buildDialogButton(
                            'Hoàn thành',
                            Icons.home_rounded,
                            isPassed ? AppColors.bamboo1 : AppColors.vietnamRed,
                            () {
                              context.go('/home');
                            },
                            textColor: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper widget cho stats item
  Widget _buildStatItem({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color, size: 26),
        SizedBox(height: 6),
        Text(
          value,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: color,
            height: 1,
          ),
        ),
        SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  // Helper widget cho vertical divider
  Widget _buildVerticalDivider() {
    return Container(height: 45, width: 1, color: Colors.grey[300]);
  }

  // Updated button widget
  Widget _buildDialogButton(
    String text,
    IconData icon,
    Color bgColor,
    VoidCallback onTap, {
    Color textColor = Colors.white,
    Color? borderColor,
  }) {
    final bool isOutlined = borderColor != null;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.medium),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: AppPadding.large),
          decoration: BoxDecoration(
            color: isOutlined ? Colors.white : bgColor,
            borderRadius: BorderRadius.circular(AppRadius.medium),
            border: isOutlined
                ? Border.all(color: borderColor, width: 2)
                : null,
            boxShadow: isOutlined
                ? null
                : [
                    BoxShadow(
                      color: bgColor.withOpacity(0.3),
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: textColor, size: 20),
              SizedBox(width: AppPadding.small),
              Text(
                text,
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _resetLesson() {
    setState(() {
      _currentQuestionIndex = 0;
      _correctAnswers = 0;
      _hasAnswered = false;
      _isCorrect = false;
      _selectedAnswer = null;
    });
    _feedbackController.reset();
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = _questions[_currentQuestionIndex];
    final progress = (_currentQuestionIndex + 1) / _questions.length;

    return Scaffold(
      body: Stack(
        children: [
          const _GradientBackground(),
          SafeArea(
            child: Column(
              children: [
                _buildHeader(progress),
                Expanded(
                  child: Center(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.all(AppPadding.large),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildQuestionCard(currentQuestion),
                          SizedBox(height: AppPadding.xLarge),
                          _buildAnswerOptions(currentQuestion),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(double progress) {
    return Container(
      padding: EdgeInsets.all(AppPadding.large),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
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
                  padding: EdgeInsets.all(AppPadding.small + 2),
                  decoration: BoxDecoration(
                    color: AppColors.bamboo1.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(AppRadius.medium),
                  ),
                  child: Icon(Icons.close, color: AppColors.bamboo1, size: 22),
                ),
              ),
              SizedBox(width: AppPadding.medium),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Từ vựng cơ bản",
                      style: AppTextStyles.cardTitle.copyWith(fontSize: 16),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 2),
                    Text(
                      'Câu ${_currentQuestionIndex + 1}/${_questions.length}',
                      style: AppTextStyles.cardDescription.copyWith(
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: AppPadding.medium,
                  vertical: AppPadding.small - 1,
                ),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.goldLight, AppColors.goldDark],
                  ),
                  borderRadius: BorderRadius.circular(AppRadius.medium),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.goldLight.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Icon(Icons.star, color: Colors.white, size: 16),
                    SizedBox(width: 4),
                    Text(
                      '$_correctAnswers',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: AppPadding.medium),
          ClipRRect(
            borderRadius: BorderRadius.circular(AppRadius.small),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 6,
              backgroundColor: AppColors.progressBackground,
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.bamboo2),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionCard(VocabQuestion question) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppPadding.xLarge),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(AppRadius.xLarge),
        border: Border.all(
          color: AppColors.goldLight.withOpacity(0.3),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(AppPadding.large),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.goldLight.withOpacity(0.2),
                  AppColors.goldDark.withOpacity(0.2),
                ],
              ),
              shape: BoxShape.circle,
            ),
            child: Text('❓', style: TextStyle(fontSize: 40)),
          ),
          SizedBox(height: AppPadding.large),
          Text(
            question.question,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnswerOptions(VocabQuestion question) {
    final answers = [question.correctAnswer, question.wrongAnswer]..shuffle();

    return Column(
      children: answers.map((answer) {
        final isSelected = _selectedAnswer == answer;
        final isCorrectAnswer = answer == question.correctAnswer;
        final showResult = _hasAnswered && isSelected;

        // Style for selected answer
        Color borderColor = AppColors.goldLight.withOpacity(0.3);
        Color backgroundColor = Colors.white.withOpacity(0.95);
        double elevation = 0;
        Widget? trailing;

        if (showResult) {
          if (isCorrectAnswer) {
            borderColor = AppColors.goldLight;
            backgroundColor = AppColors.goldLight.withOpacity(0.15);
            elevation = 8;
            trailing = Container(
              padding: EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: AppColors.goldLight,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.check, color: Colors.white, size: 20),
            );
          } else {
            borderColor = AppColors.textSecondary;
            backgroundColor = AppColors.textSecondary.withOpacity(0.1);
            trailing = Container(
              padding: EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: AppColors.textSecondary,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.close, color: Colors.white, size: 20),
            );
          }
        }

        return Padding(
          padding: EdgeInsets.only(bottom: AppPadding.medium),
          child: GestureDetector(
            onTap: () => _selectAnswer(answer),
            child: AnimatedContainer(
              duration: AppDuration.short,
              padding: EdgeInsets.symmetric(
                horizontal: AppPadding.large,
                vertical: AppPadding.large + 4,
              ),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(AppRadius.large),
                border: Border.all(color: borderColor, width: 2.5),
                boxShadow: [
                  BoxShadow(
                    color: borderColor.withOpacity(0.2),
                    blurRadius: elevation,
                    offset: Offset(0, elevation / 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      answer,
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  if (trailing != null) ...[
                    SizedBox(width: AppPadding.medium),
                    trailing,
                  ],
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

// ========== FEEDBACK BOTTOM SHEET ==========
class _FeedbackBottomSheet extends StatefulWidget {
  final bool isCorrect;
  final String explanation;
  final VoidCallback onNext;

  const _FeedbackBottomSheet({
    required this.isCorrect,
    required this.explanation,
    required this.onNext,
  });

  @override
  State<_FeedbackBottomSheet> createState() => _FeedbackBottomSheetState();
}

class _FeedbackBottomSheetState extends State<_FeedbackBottomSheet>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: AppDuration.medium,
    );

    _slideAnimation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();

    // Auto close after 3.5 seconds
    Future.delayed(const Duration(milliseconds: 3500), () {
      if (mounted) {
        widget.onNext();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _slideAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(
            0,
            MediaQuery.of(context).size.height * _slideAnimation.value,
          ),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: widget.isCorrect
                    ? [AppColors.bamboo1, AppColors.bamboo2]
                    : [AppColors.goldLight, AppColors.goldDark],
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(AppRadius.xLarge + 4),
                topRight: Radius.circular(AppRadius.xLarge + 4),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 20,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.all(AppPadding.xLarge),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Drag indicator
                    Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    SizedBox(height: AppPadding.large),

                    Lottie.asset(
                      widget.isCorrect
                          ? AppAssets.successAnimation
                          : AppAssets.errorAnimation,
                      height: 200,
                      width: 200,
                      repeat: false,
                    ),

                    SizedBox(height: AppPadding.large),

                    Text(
                      widget.isCorrect
                          ? 'Chính xác! 🎉'
                          : 'Cố gắng thêm nhé! 💪',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: AppPadding.medium),

                    Container(
                      padding: EdgeInsets.all(AppPadding.large),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(AppRadius.large),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.3),
                          width: 1.5,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(AppPadding.small),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(
                                AppRadius.small,
                              ),
                            ),
                            child: Icon(
                              Icons.lightbulb_outline,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                          SizedBox(width: AppPadding.medium),
                          Expanded(
                            child: Text(
                              widget.explanation,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                height: 1.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: AppPadding.large),

                    GestureDetector(
                      onTap: widget.onNext,
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                          vertical: AppPadding.large,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(AppRadius.medium),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Tiếp tục',
                              style: TextStyle(
                                color: widget.isCorrect
                                    ? AppColors.bamboo1
                                    : AppColors.goldDark,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(width: AppPadding.small),
                            Icon(
                              Icons.arrow_forward_rounded,
                              color: widget.isCorrect
                                  ? AppColors.bamboo1
                                  : AppColors.goldDark,
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

// ========== MODELS ==========
class VocabQuestion {
  final String question;
  final String correctAnswer;
  final String wrongAnswer;
  final String explanation;

  VocabQuestion({
    required this.question,
    required this.correctAnswer,
    required this.wrongAnswer,
    required this.explanation,
  });
}

// ========== BACKGROUND ==========
class _GradientBackground extends StatelessWidget {
  const _GradientBackground();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.bamboo1, AppColors.bamboo2, AppColors.bamboo3],
        ),
      ),
    );
  }
}
