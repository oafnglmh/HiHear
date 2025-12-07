import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:go_router/go_router.dart';
import 'package:hihear_mo/core/constants/app_assets.dart';
import 'package:hihear_mo/presentation/blocs/lesson/lesson_bloc.dart';
import 'package:lottie/lottie.dart';
import 'dart:math' as math;

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
          // Background gradient
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

          // Lotus pattern background
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

          // Ripple effects
          AnimatedBuilder(
            animation: _rippleController,
            builder: (context, child) {
              return CustomPaint(
                painter: RipplePainter(
                  animationValue: _rippleController.value,
                ),
                size: Size.infinite,
              );
            },
          ),

          // Content
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
                        valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFD4AF37)),
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
                                _buildGrammarCard(grammars[_currentGrammarIndex]),
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
                  saved: () {
                    return const SizedBox.shrink();
                  },
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
                onPressed: () => Navigator.pop(context),
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.white,
                ),
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
          offset: Offset(0, math.sin(_floatingController.value * math.pi * 2) * 3),
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
                      'Câu ${_currentGrammarIndex + 1}/$total',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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
          offset: Offset(0, math.sin(_floatingController.value * math.pi * 2 + 0.5) * 4),
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
                        lesson.level ?? 'Dễ',
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
                        lesson.category ?? 'Ngữ pháp',
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
                  lesson.title ?? 'Bài học',
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
          offset: Offset(0, math.sin(_floatingController.value * math.pi * 2 + 1) * 5),
          child: Container(
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
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Grammar Rule Section
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xFFD4AF37).withOpacity(0.15),
                        const Color(0xFFB8941E).withOpacity(0.1),
                      ],
                    ),
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(21)),
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
                                  color: const Color(0xFFD4AF37).withOpacity(0.3),
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
                          const Text(
                            'Quy tắc ngữ pháp',
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

                // Example Section
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
                                  color: const Color(0xFF2D7A4F).withOpacity(0.3),
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
                          const Text(
                            'Ví dụ',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF0D4D2D),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Vietnamese Example
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
                            const Text(
                              '🇻🇳',
                              style: TextStyle(fontSize: 24),
                            ),
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
                                          colors: [Color(0xFFD4AF37), Color(0xFFB8941E)],
                                        )
                                      : null,
                                  color: _isSpeaking ? null : Colors.white,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: _isSpeaking
                                        ? Colors.transparent
                                        : const Color(0xFFDA291C).withOpacity(0.3),
                                    width: 2,
                                  ),
                                  boxShadow: _isSpeaking
                                      ? [
                                          BoxShadow(
                                            color: const Color(0xFFD4AF37).withOpacity(0.4),
                                            blurRadius: 12,
                                          ),
                                        ]
                                      : null,
                                ),
                                child: Icon(
                                  _isSpeaking ? Icons.volume_up : Icons.volume_up_outlined,
                                  color: _isSpeaking ? Colors.white : const Color(0xFFDA291C),
                                  size: 22,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 16),

                      // English Translation
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
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                        'Dịch nghĩa',
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
                label: const Text(
                  'Trước',
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
                    _currentGrammarIndex < total - 1 ? 'Tiếp theo' : 'Hoàn thành',
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
          border: Border.all(
            color: const Color(0xFFD4AF37),
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 20,
            ),
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
            const Text(
              'Không có nội dung ngữ pháp',
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
          border: Border.all(
            color: const Color(0xFFDA291C),
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 20,
            ),
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
            const Text(
              'Đã có lỗi xảy ra',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0D4D2D),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF2D5016),
              ),
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
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                icon: const Icon(Icons.refresh, size: 20),
                label: const Text(
                  'Thử lại',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
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
            border: Border.all(
              color: const Color(0xFFD4AF37),
              width: 3,
            ),
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
              const Text(
                'Chúc mừng!',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0D4D2D),
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Bạn đã hoàn thành bài học ngữ pháp này.',
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
                  label: const Text(
                    'Quay về trang chủ',
                    style: TextStyle(
                      fontSize: 16,
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
  }
}

// Lotus Pattern Painter
class LotusPatternPainter extends CustomPainter {
  final double animationValue;

  LotusPatternPainter({required this.animationValue});

  @override
  void paint(Canvas canvas, Size size) {
    _drawLotusFlower(
      canvas,
      Offset(size.width - 70, 80 + math.sin(animationValue * math.pi * 2) * 8),
      90,
      0.18 + animationValue * 0.06,
    );

    _drawLotusFlower(
      canvas,
      Offset(70, size.height - 120 + math.cos(animationValue * math.pi * 2) * 10),
      110,
      0.15 + animationValue * 0.04,
    );

    _drawLotusFlower(
      canvas,
      Offset(80, 100 + math.sin(animationValue * math.pi * 2 + 1) * 6),
      70,
      0.12 + animationValue * 0.03,
    );

    _drawLotusLeaf(
      canvas,
      Offset(size.width - 90, size.height - 100 + math.sin(animationValue * math.pi * 2) * 7),
      75,
      0.12 + animationValue * 0.03,
    );

    _drawLotusLeaf(
      canvas,
      Offset(size.width - 120, 140 + math.cos(animationValue * math.pi * 2) * 5),
      55,
      0.1,
    );
  }

  void _drawLotusFlower(Canvas canvas, Offset center, double size, double opacity) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.pink.shade100.withOpacity(opacity);

    for (int i = 0; i < 8; i++) {
      final angle = (i * math.pi / 4) + (animationValue * 0.1);
      canvas.save();
      canvas.translate(center.dx, center.dy);
      canvas.rotate(angle);

      final path = Path();
      path.moveTo(0, 0);
      path.quadraticBezierTo(
        size * 0.3, -size * 0.5,
        0, -size * 0.8,
      );
      path.quadraticBezierTo(
        -size * 0.3, -size * 0.5,
        0, 0,
      );

      canvas.drawPath(path, paint);
      canvas.restore();
    }

    final centerPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.yellow.shade300.withOpacity(opacity * 1.5);

    canvas.drawCircle(center, size * 0.15, centerPaint);

    for (int i = 0; i < 12; i++) {
      final angle = i * math.pi / 6;
      final x = center.dx + math.cos(angle) * size * 0.1;
      final y = center.dy + math.sin(angle) * size * 0.1;
      canvas.drawCircle(
        Offset(x, y),
        size * 0.02,
        Paint()..color = Colors.orange.shade200.withOpacity(opacity * 1.2),
      );
    }
  }

  void _drawLotusLeaf(Canvas canvas, Offset center, double size, double opacity) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = const Color(0xFF2D7A4F).withOpacity(opacity);

    final path = Path();
    
    path.moveTo(center.dx, center.dy - size);
    path.quadraticBezierTo(
      center.dx + size * 0.9, center.dy - size * 0.7,
      center.dx + size, center.dy,
    );
    path.quadraticBezierTo(
      center.dx + size * 0.9, center.dy + size * 0.7,
      center.dx, center.dy + size,
    );
    path.lineTo(center.dx, center.dy);
    
    path.moveTo(center.dx, center.dy - size);
    path.quadraticBezierTo(
      center.dx - size * 0.9, center.dy - size * 0.7,
      center.dx - size, center.dy,
    );
    path.quadraticBezierTo(
      center.dx - size * 0.9, center.dy + size * 0.7,
      center.dx, center.dy + size,
    );
    path.lineTo(center.dx, center.dy);

    canvas.drawPath(path, paint);

    final veinPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..color = const Color(0xFF1B5A37).withOpacity(opacity * 0.8);

    canvas.drawLine(
      Offset(center.dx, center.dy - size),
      Offset(center.dx, center.dy + size),
      veinPaint,
    );

    for (int i = -3; i <= 3; i++) {
      if (i == 0) continue;
      final startY = center.dy + (i * size / 4);
      final endX = center.dx + (size * 0.7);
      canvas.drawLine(
        Offset(center.dx, startY),
        Offset(endX, startY + size * 0.1),
        veinPaint..strokeWidth = 1.0,
      );
      canvas.drawLine(
        Offset(center.dx, startY),
        Offset(center.dx - endX, startY + size * 0.1),
        veinPaint,
      );
    }
  }

  @override
  bool shouldRepaint(LotusPatternPainter oldDelegate) {
    return oldDelegate.animationValue != animationValue;
  }
}

// Ripple Effect Painter
class RipplePainter extends CustomPainter {
  final double animationValue;

  RipplePainter({required this.animationValue});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..color = Colors.white.withOpacity(0.1);

    for (int i = 0; i < 3; i++) {
      final progress = (animationValue + (i * 0.33)) % 1.0;
      final radius = progress * size.width * 0.6;
      final opacity = (1 - progress) * 0.15;

      canvas.drawCircle(
        Offset(size.width / 2, size.height * 0.3),
        radius,
        paint..color = Colors.white.withOpacity(opacity),
      );
    }
  }

  @override
  bool shouldRepaint(RipplePainter oldDelegate) {
    return oldDelegate.animationValue != animationValue;
  }
}