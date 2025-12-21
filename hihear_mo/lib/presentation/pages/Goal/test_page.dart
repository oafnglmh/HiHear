import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hihear_mo/core/constants/app_assets.dart';
import 'package:hihear_mo/l10n/app_localizations.dart';
import 'package:hihear_mo/presentation/blocs/Auth/auth_bloc.dart';
import 'package:lottie/lottie.dart';

class TestScreen extends StatefulWidget {
  final String language;

  const TestScreen({Key? key, required this.language}) : super(key: key);

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> with TickerProviderStateMixin {
  late Map<String, dynamic> testData;
  int currentLevelIndex = 0;
  int currentQuestionIndex = 0;
  int currentLevelScore = 0;
  List<String> completedLevels = [];
  String? selectedAnswer;
  bool isLoading = true;
  late AnimationController _pulseController;
  late final l10n = AppLocalizations.of(context)!;
  
  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _loadTestData();
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  void _loadTestData() async {
    String data = await rootBundle.loadString(
      'assets/data/test_${widget.language == 'english' ? 'en' : 'kr'}.json',
    );
    testData = json.decode(data);

    setState(() {
      isLoading = false;
    });
  }

  List<dynamic> get currentLevelQuestions {
    return testData['levels'][currentLevelIndex]['questions'];
  }

  String get currentLevel {
    return testData['levels'][currentLevelIndex]['level'];
  }

  void _selectAnswer(int index) {
    setState(() {
      selectedAnswer = index.toString();
    });
    _pulseController.forward().then((_) => _pulseController.reverse());
  }

  void _nextQuestion() {
    if (selectedAnswer == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.warning_amber_rounded, color: Colors.white),
              const SizedBox(width: 10),
              Expanded(child: Text(l10n.testSelectAnswerWarning)),
            ],
          ),
          backgroundColor: const Color(0xFFFF6B6B),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          margin: const EdgeInsets.all(20),
        ),
      );
      return;
    }

    int correctAnswer = currentLevelQuestions[currentQuestionIndex]['answer'];
    if (int.parse(selectedAnswer!) == correctAnswer) {
      currentLevelScore++;
    }

    if (currentQuestionIndex < currentLevelQuestions.length - 1) {
      setState(() {
        currentQuestionIndex++;
        selectedAnswer = null;
      });
    } else {
      _finishLevel();
    }
  }

  void _finishLevel() {
    bool passed = currentLevelScore >= 7;

    if (passed) {
      completedLevels.add(currentLevel);

      if (currentLevelIndex < testData['levels'].length - 1) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32),
            ),
            child: Container(
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32),
                color: Colors.white,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Lottie.asset(
                    AppAssets.successTestAnimation,
                    width: 120,
                    height: 120,
                    repeat: false,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    l10n.testCongratulations,
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFF6B6B),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    l10n.testPassedLevel(currentLevel),
                    style: TextStyle(fontSize: 15, color: Colors.grey[600]),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFFFF6B6B), Color(0xFFFF8E53)],
                      ),
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFFFF6B6B).withOpacity(0.4),
                          blurRadius: 12,
                          offset: Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Text(
                      '${l10n.testScore}: $currentLevelScore/10',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  Text(
                    l10n.testReadyNextChallenge,
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 28),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFFFF6B6B), Color(0xFFFF8E53)],
                      ),
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFFFF6B6B).withOpacity(0.4),
                          blurRadius: 16,
                          offset: Offset(0, 8),
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        setState(() {
                          currentLevelIndex++;
                          currentQuestionIndex = 0;
                          currentLevelScore = 0;
                          selectedAnswer = null;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Text(
                        l10n.testContinue,
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      } else {
        _showFinalResult(true);
      }
    } else {
      _showFinalResult(false);
    }
  }

  void _showFinalResult(bool passed) {
    String dataLevel;
    String finalLevel = completedLevels.isEmpty
        ? 'Chưa đạt A1'
        : 'Đạt ${completedLevels.last}';
    if (completedLevels.isEmpty) {
      dataLevel = 'A1';
      finalLevel = "Chưa đạt A1";
    } else {
      dataLevel = completedLevels.last;
      finalLevel = "Đạt ${completedLevels.last}";
    }
    final authBloc = context.read<AuthBloc>();
    authBloc.add(AuthEvent.updateLevel(dataLevel));
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
        child: Container(
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32),
            color: Colors.white,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Lottie.asset(
                passed
                    ? AppAssets.celebrationAnimation
                    : AppAssets.faileAnimation,
                width: 120,
                height: 120,
                repeat: true,
              ),
              const SizedBox(height: 20),
              Text(
                passed ? '🎉 Xuất sắc!' : '💪 Cố gắng lên!',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFF6B6B),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                'Trình độ của bạn:',
                style: TextStyle(fontSize: 15, color: Colors.grey[600]),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 28,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFFFF6B6B), Color(0xFFFF8E53)],
                  ),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFFFF6B6B).withOpacity(0.4),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Text(
                  finalLevel,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.quiz_rounded, color: Color(0xFFFF6B6B), size: 22),
                        const SizedBox(width: 10),
                        Text(
                          'Điểm $currentLevel: $currentLevelScore/10',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[800],
                          ),
                        ),
                      ],
                    ),
                    if (completedLevels.isNotEmpty) ...[
                      const SizedBox(height: 12),
                      Divider(color: Colors.grey[300]),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.emoji_events_rounded,
                            color: Color(0xFFFF6B6B),
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Flexible(
                            child: Text(
                              'Đã hoàn thành: ${completedLevels.join(", ")}',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[700],
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 28),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFFFF6B6B), Color(0xFFFF8E53)],
                  ),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFFFF6B6B).withOpacity(0.4),
                      blurRadius: 16,
                      offset: Offset(0, 8),
                    ),
                  ],
                ),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    setState(() {
                      currentLevelIndex = 0;
                      currentQuestionIndex = 0;
                      currentLevelScore = 0;
                      completedLevels.clear();
                      selectedAnswer = null;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'Hoàn thành',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFFFF6B6B),
                Color(0xFFFF8E53),
              ],
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(AppAssets.loadingAnimation, width: 150, height: 150),
                const SizedBox(height: 24),
                const Text(
                  'Đang tải bài test...',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    var question = currentLevelQuestions[currentQuestionIndex];

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        state.when(
          initial: () {},
          loading: () {},
          loggedOut: () {},
          error: (msg) {},
          authenticated: (user) async {
            await Future.delayed(const Duration(seconds: 2));
            context.go("/home");
          },
        );
      },
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFFFF6B6B),
                Color(0xFFFF8E53),
              ],
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Questions ${currentQuestionIndex + 1}/${currentLevelQuestions.length}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.25),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.star_rounded,
                                  color: Colors.white,
                                  size: 18,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  '$currentLevelScore',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: LinearProgressIndicator(
                          value: (currentQuestionIndex + 1) / currentLevelQuestions.length,
                          backgroundColor: Colors.white.withOpacity(0.3),
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          minHeight: 8,
                        ),
                      ),
                    ],
                  ),
                ),
                
                // White content area
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(32),
                        topRight: Radius.circular(32),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Level badge
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Color(0xFFFF6B6B), Color(0xFFFF8E53)],
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              'Test $currentLevel',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          
                          // Question
                          Text(
                            question['question'],
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                              height: 1.4,
                            ),
                          ),
                          const SizedBox(height: 28),
                          
                          // Options
                          Expanded(
                            child: ListView.builder(
                              itemCount: question['options'].length,
                              itemBuilder: (context, index) {
                                bool isSelected = selectedAnswer == index.toString();
                                return AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  margin: const EdgeInsets.only(bottom: 12),
                                  child: InkWell(
                                    onTap: () => _selectAnswer(index),
                                    borderRadius: BorderRadius.circular(16),
                                    child: Container(
                                      padding: const EdgeInsets.all(18),
                                      decoration: BoxDecoration(
                                        gradient: isSelected
                                            ? LinearGradient(
                                                colors: [Color(0xFFFF6B6B), Color(0xFFFF8E53)],
                                              )
                                            : null,
                                        color: isSelected ? null : Color(0xFFF5F5F5),
                                        borderRadius: BorderRadius.circular(16),
                                        boxShadow: isSelected
                                            ? [
                                                BoxShadow(
                                                  color: Color(0xFFFF6B6B).withOpacity(0.3),
                                                  blurRadius: 12,
                                                  offset: Offset(0, 4),
                                                ),
                                              ]
                                            : [],
                                      ),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 40,
                                            height: 40,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: isSelected
                                                  ? Colors.white.withOpacity(0.3)
                                                  : Colors.white,
                                            ),
                                            child: Center(
                                              child: Text(
                                                String.fromCharCode(65 + index),
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                  color: isSelected
                                                      ? Colors.white
                                                      : Color(0xFFFF6B6B),
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 16),
                                          Expanded(
                                            child: Text(
                                              question['options'][index],
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                                color: isSelected
                                                    ? Colors.white
                                                    : Colors.black87,
                                                height: 1.4,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          
                          const SizedBox(height: 16),
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Color(0xFFFF6B6B), Color(0xFFFF8E53)],
                              ),
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xFFFF6B6B).withOpacity(0.4),
                                  blurRadius: 16,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                            ),
                            child: ElevatedButton(
                              onPressed: _nextQuestion,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                                padding: const EdgeInsets.symmetric(vertical: 18),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    currentQuestionIndex == currentLevelQuestions.length - 1
                                        ? 'Hoàn thành'
                                        : 'Câu tiếp theo',
                                    style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  const Icon(
                                    Icons.arrow_forward_rounded,
                                    color: Colors.white,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}