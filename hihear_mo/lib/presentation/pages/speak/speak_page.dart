import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:go_router/go_router.dart';
import 'package:hihear_mo/core/constants/app_colors.dart';
import 'package:hihear_mo/data/models/phoneme.dart';
import 'package:hihear_mo/data/repositories/phoneme_repository.dart';

class SpeakPage extends StatefulWidget {
  final bool isPremium;
  
  const SpeakPage({
    super.key,
    this.isPremium = true,
  });

  @override
  State<SpeakPage> createState() => _SpeakPageState();
}

class _SpeakPageState extends State<SpeakPage> with TickerProviderStateMixin {
  final FlutterTts flutterTts = FlutterTts();
  late AnimationController _headerController;
  late AnimationController _shimmerController;
  late AnimationController _pulseController;
  
  String? _currentPlayingSymbol;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    
    _headerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..forward();

    _shimmerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    )..repeat();

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    flutterTts.stop();
    _headerController.dispose();
    _shimmerController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  Future<void> _speak(Phoneme phoneme) async {
    setState(() {
      _currentPlayingSymbol = phoneme.symbol;
      _isPlaying = true;
    });

    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1.0);
    await flutterTts.awaitSpeakCompletion(true);
    await flutterTts.speak(phoneme.tts);
    await flutterTts.awaitSpeakCompletion(true);
    await flutterTts.speak(phoneme.example);

    setState(() {
      _currentPlayingSymbol = null;
      _isPlaying = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: widget.isPremium
              ? const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF1a1a2e),
                    Color(0xFF16213e),
                    Color(0xFF0f3460),
                  ],
                )
              : null,
          color: widget.isPremium ? null : const Color(0xFF16141d),
        ),
        child: SafeArea(
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              _buildSliverHeader(),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildStatsCards(),
                      const SizedBox(height: 32),
                      _buildSectionHeader(
                        "Nguyên âm",
                        Icons.record_voice_over,
                        PhonemeRepository.vowels.length,
                      ),
                      const SizedBox(height: 16),
                      _buildPhonemeGrid(PhonemeRepository.vowels),
                      const SizedBox(height: 32),
                      _buildSectionHeader(
                        "Phụ âm",
                        Icons.mic,
                        PhonemeRepository.consonants.length,
                      ),
                      const SizedBox(height: 16),
                      _buildPhonemeGrid(PhonemeRepository.consonants),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSliverHeader() {
    return SliverToBoxAdapter(
      child: FadeTransition(
        opacity: _headerController,
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, -0.3),
            end: Offset.zero,
          ).animate(CurvedAnimation(
            parent: _headerController,
            curve: Curves.easeOut,
          )),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: widget.isPremium
                  ? LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        const Color(0xFFFFD700).withOpacity(0.2),
                        const Color(0xFFFFA500).withOpacity(0.1),
                      ],
                    )
                  : null,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(32),
                bottomRight: Radius.circular(32),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        gradient: widget.isPremium
                            ? const LinearGradient(
                                colors: [Color(0xFFFFD700), Color(0xFFFFA500)],
                              )
                            : null,
                        color: widget.isPremium ? null : const Color(0xFFF8B271),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: widget.isPremium
                            ? [
                                BoxShadow(
                                  color: const Color(0xFFFFD700).withOpacity(0.4),
                                  blurRadius: 16,
                                  spreadRadius: 2,
                                )
                              ]
                            : null,
                      ),
                      child: const Icon(
                        Icons.campaign,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Text(
                                "Phát âm",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              if (widget.isPremium) ...[
                                const SizedBox(width: 8),
                                _buildPremiumBadge(),
                              ],
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "Học phát âm chuẩn",
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.7),
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  "Cùng học phát âm tiếng Anh!",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Tập nghe và học phát âm các âm trong tiếng Anh",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 15,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 24),
                _buildStartButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPremiumBadge() {
    return AnimatedBuilder(
      animation: _shimmerController,
      builder: (context, child) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: const [
                Color(0xFFFFD700),
                Color(0xFFFFA500),
                Color(0xFFFFD700),
              ],
              stops: [
                _shimmerController.value - 0.3,
                _shimmerController.value,
                _shimmerController.value + 0.3,
              ],
            ),
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFFFD700).withOpacity(0.5),
                blurRadius: 8,
              ),
            ],
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.workspace_premium, color: Colors.white, size: 14),
              SizedBox(width: 4),
              Text(
                "PRO",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStartButton() {
    return AnimatedBuilder(
      animation: _pulseController,
      builder: (context, child) {
        return Transform.scale(
          scale: widget.isPremium ? 1.0 + (_pulseController.value * 0.05) : 1.0,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              boxShadow: widget.isPremium
                  ? [
                      BoxShadow(
                        color: const Color(0xFFFFD700).withOpacity(0.3),
                        blurRadius: 20 + (_pulseController.value * 10),
                        spreadRadius: 2,
                      )
                    ]
                  : null,
            ),
            child: ElevatedButton(
              onPressed: () {
                context.go('/speaking');
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 48,
                  vertical: 18,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                backgroundColor: widget.isPremium
                    ? const Color(0xFFFFD700)
                    : const Color(0xFFF8B271),
                elevation: 0,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.play_circle_filled, color: Colors.white),
                  const SizedBox(width: 12),
                  const Text(
                    "BẮT ĐẦU BÀI HỌC",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildStatsCards() {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            icon: Icons.music_note,
            title: "Nguyên âm",
            value: "${PhonemeRepository.vowels.length}",
            color: const Color(0xFF667eea),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildStatCard(
            icon: Icons.speaker_notes,
            title: "Phụ âm",
            value: "${PhonemeRepository.consonants.length}",
            color: const Color(0xFFf093fb),
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: widget.isPremium
            ? LinearGradient(
                colors: [
                  color.withOpacity(0.3),
                  color.withOpacity(0.1),
                ],
              )
            : null,
        color: widget.isPremium ? null : Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: widget.isPremium
              ? color.withOpacity(0.3)
              : Colors.white.withOpacity(0.1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              color: Colors.white.withOpacity(0.6),
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon, int count) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            gradient: widget.isPremium
                ? const LinearGradient(
                    colors: [Color(0xFFFFD700), Color(0xFFFFA500)],
                  )
                : null,
            color: widget.isPremium ? null : const Color(0xFFF8B271),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: Colors.white, size: 20),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.white.withOpacity(0.2),
            ),
          ),
          child: Text(
            "$count âm",
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
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
        childAspectRatio: 1.1,
      ),
      itemBuilder: (context, index) {
        final phoneme = phonemes[index];
        final isPlaying = _currentPlayingSymbol == phoneme.symbol;
        
        return TweenAnimationBuilder<double>(
          duration: Duration(milliseconds: 300 + (index * 30)),
          tween: Tween(begin: 0.0, end: 1.0),
          builder: (context, value, child) {
            return Transform.scale(
              scale: value,
              child: Opacity(
                opacity: value,
                child: _buildPhonemeCard(phoneme, isPlaying, index),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildPhonemeCard(Phoneme phoneme, bool isPlaying, int index) {
    final colors = _getCardColors(index);
    
    return GestureDetector(
      onTap: () => _speak(phoneme),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          gradient: widget.isPremium
              ? LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: isPlaying
                      ? [
                          const Color(0xFFFFD700),
                          const Color(0xFFFFA500),
                        ]
                      : [
                          colors[0].withOpacity(0.8),
                          colors[1].withOpacity(0.8),
                        ],
                )
              : null,
          color: widget.isPremium
              ? null
              : (isPlaying ? const Color(0xFFFFD700) : Colors.white.withOpacity(0.95)),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isPlaying
                ? Colors.white.withOpacity(0.5)
                : (widget.isPremium
                    ? colors[0].withOpacity(0.3)
                    : const Color(0xFFF8B271).withOpacity(0.5)),
            width: isPlaying ? 2 : 1,
          ),
          boxShadow: widget.isPremium
              ? [
                  BoxShadow(
                    color: isPlaying
                        ? const Color(0xFFFFD700).withOpacity(0.5)
                        : colors[0].withOpacity(0.3),
                    blurRadius: isPlaying ? 20 : 12,
                    spreadRadius: isPlaying ? 2 : 0,
                  ),
                ]
              : [
                  BoxShadow(
                    color: isPlaying
                        ? const Color(0xFFFFD700).withOpacity(0.4)
                        : Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
        ),
        child: Stack(
          children: [
            // Ripple effect when playing
            if (isPlaying && widget.isPremium)
              AnimatedBuilder(
                animation: _pulseController,
                builder: (context, child) {
                  return Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.3 * (1 - _pulseController.value)),
                          width: 2 + (_pulseController.value * 4),
                        ),
                      ),
                    ),
                  );
                },
              ),
            
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (isPlaying)
                    AnimatedBuilder(
                      animation: _pulseController,
                      builder: (context, child) {
                        return Icon(
                          Icons.volume_up,
                          color: Colors.white,
                          size: 20 + (_pulseController.value * 4),
                        );
                      },
                    )
                  else
                    Icon(
                      Icons.play_circle_outline,
                      color: widget.isPremium ? Colors.white.withOpacity(0.8) : Colors.black54,
                      size: 20,
                    ),
                  
                  const SizedBox(height: 8),
                  
                  Text(
                    phoneme.symbol,
                    style: TextStyle(
                      color: widget.isPremium ? Colors.white : Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  
                  const SizedBox(height: 6),
                  
                  Text(
                    phoneme.example,
                    style: TextStyle(
                      color: widget.isPremium
                          ? Colors.white.withOpacity(0.9)
                          : Colors.black54,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
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

  List<Color> _getCardColors(int index) {
    final colorSets = [
      [const Color(0xFF667eea), const Color(0xFF764ba2)],
      [const Color(0xFFf093fb), const Color(0xFFf5576c)],
      [const Color(0xFF4facfe), const Color(0xFF00f2fe)],
      [const Color(0xFF43e97b), const Color(0xFF38f9d7)],
      [const Color(0xFFfa709a), const Color(0xFFfee140)],
      [const Color(0xFFa8edea), const Color(0xFFfed6e3)],
    ];
    return colorSets[index % colorSets.length];
  }
}