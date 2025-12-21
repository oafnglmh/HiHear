import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:go_router/go_router.dart';
import 'package:hihear_mo/Services/streak_popup_service.dart';
import 'package:hihear_mo/core/constants/app_assets.dart';
import 'package:hihear_mo/l10n/app_localizations.dart';
import 'package:hihear_mo/presentation/blocs/lesson/lesson_bloc.dart';
import 'package:hihear_mo/presentation/painter/ripple_painter.dart';
import 'package:hihear_mo/share/UserShare.dart';
import 'package:lottie/lottie.dart';
import 'dart:math' as math;

import '../../../painter/lotus_pattern_painter.dart';

class GrammarLessonPage extends StatefulWidget {
  final String id;
  const GrammarLessonPage({super.key, required this.id});

  @override
  State<GrammarLessonPage> createState() => _GrammarLessonPageState();
}

class _GrammarLessonPageState extends State<GrammarLessonPage>
    with TickerProviderStateMixin {
  int _currentGrammarIndex = 0;
  bool _showTranslation = false;
  late FlutterTts _flutterTts;
  bool _isSpeaking = false;

  late AnimationController _lotusController;
  late AnimationController _floatingController;
  late AnimationController _rippleController;
  late AnimationController _fadeController;
  late final l10n = AppLocalizations.of(context)!;

  @override
  void initState() {
    super.initState();
    _initTts();
    _initAnimations();
    context.read<LessonBloc>().add(LessonEvent.loadLessonById(widget.id));
  }

  void _initAnimations() {
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

    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..forward();
  }

  void _initTts() {
    _flutterTts = FlutterTts();
    _flutterTts.setLanguage("vi-VN");
    _flutterTts.setSpeechRate(0.5);
    _flutterTts.setVolume(1.0);
    _flutterTts.setPitch(1.0);

    _flutterTts.setCompletionHandler(() {
      setState(() {
        _isSpeaking = false;
      });
    });
  }

  Future<void> _speak(String text) async {
    if (_isSpeaking) {
      await _flutterTts.stop();
      setState(() {
        _isSpeaking = false;
      });
    } else {
      setState(() {
        _isSpeaking = true;
      });
      await _flutterTts.speak(text);
    }
  }

  @override
  void dispose() {
    _flutterTts.stop();
    _lotusController.dispose();
    _floatingController.dispose();
    _rippleController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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

          SafeArea(
            child: BlocBuilder<LessonBloc, LessonState>(
              builder: (context, state) {
                return state.when(
                  initial: () => const SizedBox.shrink(),
                  loading: () => Center(
                    child: Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFD4AF37).withOpacity(0.3),
                            blurRadius: 20,
                          ),
                        ],
                      ),
                      child: const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Color(0xFFD4AF37),
                        ),
                      ),
                    ),
                  ),
                  data: (lessons) {
                    if (lessons.isEmpty) {
                      return _buildEmptyState();
                    }

                    final lesson = lessons.first;
                    final grammars = lesson.exercises.isNotEmpty
                        ? lesson.exercises.first.grammars
                        : [];

                    if (grammars.isEmpty) {
                      return _buildEmptyState();
                    }

                    return Column(
                      children: [
                        _buildAppBar(),
                        _buildProgressBar(grammars.length),
                        Expanded(
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                _buildLessonHeader(lesson),
                                const SizedBox(height: 24),
                                _buildGrammarCard(
                                  grammars[_currentGrammarIndex],
                                ),
                                const SizedBox(height: 24),
                                _buildNavigationButtons(grammars.length),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                  error: (message) => _buildErrorState(message),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return FadeTransition(
      opacity: _fadeController,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withOpacity(0.25),
                    Colors.white.withOpacity(0.15),
                  ],
                ),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: const Color(0xFFD4AF37).withOpacity(0.5),
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: IconButton(
                onPressed: () async {
                  final userId = UserShare().id;
                  if (userId != null && userId.isNotEmpty) {
                    await StreakPopupService().markLessonCompleted(userId);
                    print('[GrammarLesson] Marked completed for user: $userId');
                  }
                  context.go("/home");
                },
                icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
              ),
            ),
            const SizedBox(width: 16),
            const Expanded(
              child: Text(
                'Học Ngữ Pháp',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
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
                size: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressBar(int total) {
    return AnimatedBuilder(
      animation: _floatingController,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(
            0,
            math.sin(_floatingController.value * math.pi * 2) * 3,
          ),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.white.withOpacity(0.25),
                  Colors.white.withOpacity(0.15),
                ],
              ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: const Color(0xFFD4AF37).withOpacity(0.5),
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 15,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      l10n.grammarLessonProgressSentence(
                        _currentGrammarIndex + 1,
                        total,
                      ),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFFD4AF37), Color(0xFFB8941E)],
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '${((_currentGrammarIndex + 1) / total * 100).toInt()}%',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    height: 12,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: (_currentGrammarIndex + 1) / total,
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xFFD4AF37), Color(0xFFB8941E)],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildLessonHeader(dynamic lesson) {
    return AnimatedBuilder(
      animation: _floatingController,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(
            0,
            math.sin(_floatingController.value * math.pi * 2 + 0.5) * 4,
          ),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.white.withOpacity(0.95),
                  Colors.white.withOpacity(0.9),
                ],
              ),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: const Color(0xFFD4AF37), width: 3),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFFD4AF37), Color(0xFFB8941E)],
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFD4AF37).withOpacity(0.3),
                            blurRadius: 8,
                          ),
                        ],
                      ),
                      child: Text(
                        lesson.level ?? l10n.grammarLessonLevelEasy,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2D5016).withOpacity(0.15),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: const Color(0xFF2D5016).withOpacity(0.3),
                        ),
                      ),
                      child: Text(
                        lesson.category ?? l10n.grammarLessonCategoryGrammar,
                        style: const TextStyle(
                          color: Color(0xFF2D5016),
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  lesson.title ?? l10n.grammarLessonDefaultTitle,
                  style: const TextStyle(
                    color: Color(0xFF0D4D2D),
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  lesson.description ?? '',
                  style: const TextStyle(
                    color: Color(0xFF2D5016),
                    fontSize: 14,
                    height: 1.6,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildGrammarCard(dynamic grammar) {
    return AnimatedBuilder(
      animation: _floatingController,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(
            0,
            math.sin(_floatingController.value * math.pi * 2 + 1) * 5,
          ),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.white.withOpacity(0.95),
                  Colors.white.withOpacity(0.9),
                ],
              ),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: const Color(0xFFD4AF37), width: 3),
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
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xFFD4AF37).withOpacity(0.15),
                        const Color(0xFFB8941E).withOpacity(0.1),
                      ],
                    ),
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(21),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFFD4AF37), Color(0xFFB8941E)],
                              ),
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(
                                    0xFFD4AF37,
                                  ).withOpacity(0.3),
                                  blurRadius: 8,
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.auto_stories,
                              color: Colors.white,
                              size: 22,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            l10n.grammarLessonGrammarRuleTitle,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF0D4D2D),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        grammar.grammarRule ?? '',
                        style: const TextStyle(
                          fontSize: 15,
                          color: Color(0xFF2D5016),
                          height: 1.7,
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  height: 2,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xFFD4AF37).withOpacity(0.3),
                        Colors.transparent,
                        const Color(0xFFD4AF37).withOpacity(0.3),
                      ],
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFF2D7A4F), Color(0xFF1B5A37)],
                              ),
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(
                                    0xFF2D7A4F,
                                  ).withOpacity(0.3),
                                  blurRadius: 8,
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.chat_bubble_outline,
                              color: Colors.white,
                              size: 22,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            l10n.grammarLessonExampleTitle,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF0D4D2D),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      Container(
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              const Color(0xFFDA291C).withOpacity(0.1),
                              const Color(0xFFDA291C).withOpacity(0.05),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: const Color(0xFFDA291C).withOpacity(0.3),
                            width: 2,
                          ),
                        ),
                        child: Row(
                          children: [
                            const Text('🇻🇳', style: TextStyle(fontSize: 24)),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                grammar.example ?? '',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF0D4D2D),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            InkWell(
                              onTap: () => _speak(grammar.example ?? ''),
                              borderRadius: BorderRadius.circular(25),
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  gradient: _isSpeaking
                                      ? const LinearGradient(
                                          colors: [
                                            Color(0xFFD4AF37),
                                            Color(0xFFB8941E),
                                          ],
                                        )
                                      : null,
                                  color: _isSpeaking ? null : Colors.white,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: _isSpeaking
                                        ? Colors.transparent
                                        : const Color(
                                            0xFFDA291C,
                                          ).withOpacity(0.3),
                                    width: 2,
                                  ),
                                  boxShadow: _isSpeaking
                                      ? [
                                          BoxShadow(
                                            color: const Color(
                                              0xFFD4AF37,
                                            ).withOpacity(0.4),
                                            blurRadius: 12,
                                          ),
                                        ]
                                      : null,
                                ),
                                child: Icon(
                                  _isSpeaking
                                      ? Icons.volume_up
                                      : Icons.volume_up_outlined,
                                  color: _isSpeaking
                                      ? Colors.white
                                      : const Color(0xFFDA291C),
                                  size: 22,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 16),

                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _showTranslation = !_showTranslation;
                          });
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          padding: const EdgeInsets.all(18),
                          decoration: BoxDecoration(
                            gradient: _showTranslation
                                ? LinearGradient(
                                    colors: [
                                      const Color(0xFFD4AF37).withOpacity(0.2),
                                      const Color(0xFFD4AF37).withOpacity(0.1),
                                    ],
                                  )
                                : LinearGradient(
                                    colors: [
                                      const Color(0xFF2D5016).withOpacity(0.1),
                                      const Color(0xFF2D5016).withOpacity(0.05),
                                    ],
                                  ),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: _showTranslation
                                  ? const Color(0xFFD4AF37).withOpacity(0.5)
                                  : const Color(0xFF2D5016).withOpacity(0.3),
                              width: 2,
                            ),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.language,
                                        color: _showTranslation
                                            ? const Color(0xFFD4AF37)
                                            : const Color(0xFF2D5016),
                                        size: 22,
                                      ),
                                      const SizedBox(width: 12),
                                      Text(
                                        l10n.grammarLessonTranslationTitle,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: _showTranslation
                                              ? const Color(0xFFD4AF37)
                                              : const Color(0xFF2D5016),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Icon(
                                    _showTranslation
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: _showTranslation
                                        ? const Color(0xFFD4AF37)
                                        : const Color(0xFF2D5016),
                                    size: 22,
                                  ),
                                ],
                              ),
                              if (_showTranslation) ...[
                                const SizedBox(height: 12),
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.7),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    grammar.meaning ?? '',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFF0D4D2D),
                                    ),
                                  ),
                                ),
                              ],
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
      },
    );
  }

  Widget _buildNavigationButtons(int total) {
    return Row(
      children: [
        if (_currentGrammarIndex > 0)
          Expanded(
            child: Container(
              height: 56,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withOpacity(0.2),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: OutlinedButton.icon(
                onPressed: () {
                  setState(() {
                    _currentGrammarIndex--;
                    _showTranslation = false;
                    _isSpeaking = false;
                  });
                  _flutterTts.stop();
                },
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.white.withOpacity(0.2),
                  foregroundColor: Colors.white,
                  side: BorderSide(
                    color: Colors.white.withOpacity(0.5),
                    width: 2,
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                icon: const Icon(Icons.arrow_back, size: 20),
                label: Text(
                  l10n.grammarLessonPreviousButton,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        if (_currentGrammarIndex > 0) const SizedBox(width: 12),
        Expanded(
          child: Container(
            height: 56,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFD4AF37).withOpacity(0.4),
                  blurRadius: 15,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: ElevatedButton(
              onPressed: () {
                if (_currentGrammarIndex < total - 1) {
                  setState(() {
                    _currentGrammarIndex++;
                    _showTranslation = false;
                    _isSpeaking = false;
                  });
                  _flutterTts.stop();
                } else {
                  _flutterTts.stop();
                  UserShare().debugPrint();
                  context.read<LessonBloc>().add(
                    LessonEvent.saveCompleteLesson(
                      lessonId: widget.id,
                      userId: UserShare().id ?? '',
                    ),
                  );
                  _showCompletionDialog();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD4AF37),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _currentGrammarIndex < total - 1
                        ? l10n.grammarLessonNextButton
                        : l10n.grammarLessonCompleteButton,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(
                    _currentGrammarIndex < total - 1
                        ? Icons.arrow_forward
                        : Icons.check_circle,
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(32),
        margin: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white.withOpacity(0.9),
              Colors.white.withOpacity(0.8),
            ],
          ),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: const Color(0xFFD4AF37), width: 2),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 20),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFFD4AF37).withOpacity(0.2),
                    const Color(0xFFD4AF37).withOpacity(0.1),
                  ],
                ),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.info_outline,
                size: 64,
                color: Color(0xFFD4AF37),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              l10n.grammarLessonEmptyTitle,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color(0xFF2D5016),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState(String message) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(32),
        margin: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white.withOpacity(0.9),
              Colors.white.withOpacity(0.8),
            ],
          ),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: const Color(0xFFDA291C), width: 2),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 20),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFFDA291C).withOpacity(0.2),
                    const Color(0xFFDA291C).withOpacity(0.1),
                  ],
                ),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.error_outline,
                size: 64,
                color: Color(0xFFDA291C),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              l10n.grammarLessonErrorTitle,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0D4D2D),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              style: const TextStyle(fontSize: 14, color: Color(0xFF2D5016)),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFD4AF37).withOpacity(0.3),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: ElevatedButton.icon(
                onPressed: () {
                  context.read<LessonBloc>().add(
                    LessonEvent.loadLessonById(widget.id),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD4AF37),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                icon: const Icon(Icons.refresh, size: 20),
                label: Text(
                  l10n.grammarLessonErrorRetryButton,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showCompletionDialog() {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.75),
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.white.withOpacity(0.98),
                Colors.white.withOpacity(0.95),
              ],
            ),
            borderRadius: BorderRadius.circular(32),
            border: Border.all(color: const Color(0xFFD4AF37), width: 3),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 40,
                offset: const Offset(0, 15),
              ),
              BoxShadow(
                color: const Color(0xFFD4AF37).withOpacity(0.3),
                blurRadius: 30,
                spreadRadius: -5,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
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
                  size: 28,
                ),
              ),
              const SizedBox(height: 16),
              Lottie.asset(
                AppAssets.passAnimation,
                height: 180,
                width: 180,
                repeat: false,
              ),
              const SizedBox(height: 16),
              Text(
                l10n.grammarLessonCompletionTitle,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0D4D2D),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                l10n.grammarLessonCompletionMessage,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF2D5016),
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 24),
              Container(
                width: double.infinity,
                height: 56,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFD4AF37).withOpacity(0.4),
                      blurRadius: 15,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: ElevatedButton.icon(
                  onPressed: () {
                    context.go("/home");
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD4AF37),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  icon: const Icon(Icons.home, size: 22),
                  label: Text(
                    l10n.grammarLessonCompletionHomeButton,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
