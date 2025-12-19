import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:go_router/go_router.dart';
import 'package:hihear_mo/data/models/phoneme.dart';
import 'package:hihear_mo/data/repositories/phoneme_repository.dart';
import 'package:hihear_mo/presentation/painter/ripple_painter.dart';
import 'dart:math' as math;

import '../../painter/lotus_pattern_painter.dart';

class SpeakPage extends StatefulWidget {
  const SpeakPage({super.key});

  @override
  State<SpeakPage> createState() => _SpeakPageState();
}

class _SpeakPageState extends State<SpeakPage> with TickerProviderStateMixin {
  final FlutterTts flutterTts = FlutterTts();
  
  late AnimationController _lotusController;
  late AnimationController _rippleController;
  late AnimationController _floatingController;
  late AnimationController _fadeController;

  String? _currentPlayingSymbol;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();

    _lotusController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 4000),
    )..repeat(reverse: true);

    _rippleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    )..repeat();

    _floatingController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    )..repeat(reverse: true);

    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..forward();
  }

  @override
  void dispose() {
    flutterTts.stop();
    _lotusController.dispose();
    _rippleController.dispose();
    _floatingController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  Future<void> _speak(Phoneme phoneme) async {
    setState(() {
      _currentPlayingSymbol = phoneme.symbol;
      _isPlaying = true;
    });

    await flutterTts.setLanguage("vi-VN");
    await flutterTts.setVoice({"name": "vi-VN-Standard-A", "locale": "vi-VN"});
    await flutterTts.setPitch(1.0);
    await flutterTts.awaitSpeakCompletion(true);
    String textToSpeak = "${phoneme.tts}, ví dụ: ${phoneme.example}";
    await flutterTts.speak(textToSpeak);

    setState(() {
      _currentPlayingSymbol = null;
      _isPlaying = false;
    });
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
                painter: RipplePainter(
                  animationValue: _rippleController.value,
                ),
                size: Size.infinite,
              );
            },
          ),

          SafeArea(
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                _buildSliverHeader(),
                SliverToBoxAdapter(
                  child: FadeTransition(
                    opacity: _fadeController,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildSectionHeader(
                            "Dấu Thanh",
                            PhonemeRepository.tones.length,
                          ),
                          const SizedBox(height: 16),
                          _buildPhonemeGrid(PhonemeRepository.tones),
                          const SizedBox(height: 32),
                          _buildSectionHeader(
                            "Nguyên âm",
                            PhonemeRepository.vowels.length,
                          ),
                          const SizedBox(height: 16),
                          _buildPhonemeGrid(PhonemeRepository.vowels),
                          const SizedBox(height: 32),
                          _buildSectionHeader(
                            "Phụ âm",
                            PhonemeRepository.consonants.length,
                          ),
                          const SizedBox(height: 16),
                          _buildPhonemeGrid(PhonemeRepository.consonants),
                          const SizedBox(height: 32),
                          _buildSectionHeader(
                            "Nguyên âm đôi",
                            PhonemeRepository.diphthongs.length,
                          ),
                          const SizedBox(height: 16),
                          _buildPhonemeGrid(PhonemeRepository.diphthongs),
                          const SizedBox(height: 40),
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

  Widget _buildSliverHeader() {
    return SliverToBoxAdapter(
      child: FadeTransition(
        opacity: _fadeController,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AnimatedBuilder(
                animation: _floatingController,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(0, math.sin(_floatingController.value * math.pi * 2) * 4),
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
                            color: const Color(0xFFD4AF37).withOpacity(0.4),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(14),
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [Color(0xFFD4AF37), Color(0xFFB8941E)],
                                  ),
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0xFFD4AF37).withOpacity(0.5),
                                      blurRadius: 12,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: const Icon(
                                  Icons.campaign_rounded,
                                  color: Colors.white,
                                  size: 32,
                                ),
                              ),
                              const SizedBox(width: 18),
                              const Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Phát âm",
                                      style: TextStyle(
                                        color: Color(0xFF2D5016),
                                        fontSize: 26,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                    SizedBox(height: 6),
                                    Text(
                                      "Học phát âm chuẩn",
                                      style: TextStyle(
                                        color: Color(0xFF2D5016),
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: const Color(0xFFD4AF37).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: const Color(0xFFD4AF37).withOpacity(0.3),
                                width: 1,
                              ),
                            ),
                            child: Column(
                              children: [
                                const Text(
                                  "Cùng học phát âm tiếng Việt!",
                                  style: TextStyle(
                                    color: Color(0xFF2D5016),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    letterSpacing: 0.3,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  "Tập nghe và học phát âm các âm trong tiếng Việt",
                                  style: TextStyle(
                                    color: const Color(0xFF2D5016).withOpacity(0.8),
                                    fontSize: 14,
                                    height: 1.5,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 24),
              _buildStartButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStartButton() {
    return AnimatedBuilder(
      animation: _floatingController,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, math.sin(_floatingController.value * math.pi * 2 + 1) * 3),
          child: TweenAnimationBuilder<double>(
            duration: const Duration(milliseconds: 800),
            tween: Tween(begin: 0.0, end: 1.0),
            builder: (context, value, child) {
              return Transform.scale(
                scale: 0.9 + (value * 0.1),
                child: Opacity(
                  opacity: value,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFD4AF37).withOpacity(0.5),
                          blurRadius: 20,
                          spreadRadius: 2,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        context.go('/speaking');
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                        backgroundColor: const Color(0xFFD4AF37),
                        foregroundColor: Colors.white,
                        elevation: 0,
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.play_circle_filled_rounded,
                            color: Colors.white,
                            size: 26,
                          ),
                          SizedBox(width: 12),
                          Text(
                            "BẮT ĐẦU BÀI HỌC",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildSectionHeader(String title, int count) {
    return AnimatedBuilder(
      animation: _floatingController,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, math.sin(_floatingController.value * math.pi * 2) * 2),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color(0xFFD4AF37),
                  Color(0xFFB8941E),
                ],
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFD4AF37).withOpacity(0.4),
                  blurRadius: 15,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.25),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    "$count âm",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
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

  Widget _buildPhonemeGrid(List<Phoneme> phonemes) {
    return GridView.builder(
      itemCount: phonemes.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.0,
      ),
      itemBuilder: (context, index) {
        final phoneme = phonemes[index];
        final isPlaying = _currentPlayingSymbol == phoneme.symbol;

        return TweenAnimationBuilder<double>(
          duration: Duration(milliseconds: 300 + (index * 30)),
          tween: Tween(begin: 0.0, end: 1.0),
          builder: (context, value, child) {
            return Transform.scale(
              scale: 0.8 + (value * 0.2),
              child: Opacity(
                opacity: value,
                child: _buildPhonemeCard(phoneme, isPlaying),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildPhonemeCard(Phoneme phoneme, bool isPlaying) {
    return GestureDetector(
      onTap: () => _speak(phoneme),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          gradient: isPlaying
              ? const LinearGradient(
                  colors: [Color(0xFFD4AF37), Color(0xFFB8941E)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : LinearGradient(
                  colors: [
                    Colors.white.withOpacity(0.2),
                    Colors.white.withOpacity(0.15),
                  ],
                ),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: isPlaying
                ? const Color(0xFFD4AF37)
                : Colors.white.withOpacity(0.3),
            width: isPlaying ? 3 : 2,
          ),
          boxShadow: isPlaying
              ? [
                  BoxShadow(
                    color: const Color(0xFFD4AF37).withOpacity(0.5),
                    blurRadius: 20,
                    spreadRadius: 2,
                    offset: const Offset(0, 6),
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
        ),
        child: Stack(
          children: [
            if (isPlaying)
              Positioned(
                top: -20,
                right: -20,
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        Colors.white.withOpacity(0.2),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
            
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (isPlaying)
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.volume_up_rounded,
                        color: Colors.white,
                        size: 24,
                      ),
                    )
                  else
                    Icon(
                      Icons.play_circle_outline_rounded,
                      color: Colors.white.withOpacity(0.9),
                      size: 24,
                    ),
                  const SizedBox(height: 5),
                  Text(
                    phoneme.symbol,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 26,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 1),
                  Text(
                    phoneme.example,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.95),
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
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
}