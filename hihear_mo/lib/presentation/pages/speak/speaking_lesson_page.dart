import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hihear_mo/core/constants/app_colors.dart';
import 'package:hihear_mo/presentation/widgets/wave_painter.dart';
import '../../blocs/speaking/speaking_bloc.dart';
import '../../blocs/speaking/speaking_event.dart';
import '../../blocs/speaking/speaking_state.dart';

class SpeakingLessonPage extends StatefulWidget {
  final bool isPremium;
  
  const SpeakingLessonPage({
    super.key,
    this.isPremium = true,
  });

  @override
  State<SpeakingLessonPage> createState() => _SpeakingLessonPageState();
}

class _SpeakingLessonPageState extends State<SpeakingLessonPage>
    with TickerProviderStateMixin {
  late final AnimationController _waveController;
  late final AnimationController _pulseController;
  late final AnimationController _shimmerController;
  late final AnimationController _headerController;
  late final AnimationController _particleController;

  @override
  void initState() {
    super.initState();
    
    _waveController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);

    _shimmerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    )..repeat();

    _headerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..forward();

    _particleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    )..repeat();
  }

  @override
  void dispose() {
    _waveController.dispose();
    _pulseController.dispose();
    _shimmerController.dispose();
    _headerController.dispose();
    _particleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SpeakingBloc(),
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: widget.isPremium
                ? const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF1a1a2e),
                      Color(0xFF16213e),
                      Color(0xFF0f3460),
                      Color(0xFF1a1a2e),
                    ],
                  )
                : null,
            color: widget.isPremium ? null : Colors.white,
          ),
          child: SafeArea(
            child: BlocBuilder<SpeakingBloc, SpeakingState>(
              builder: (context, state) {
                final bloc = context.read<SpeakingBloc>();
                final lesson = bloc.lessons[state.currentLesson];

                return Stack(
                  children: [
                    // Animated particles background (Premium only)
                    if (widget.isPremium) _buildParticlesBackground(),

                    Column(
                      children: [
                        _buildAppBar(context, state),
                        const SizedBox(height: 24),
                        _buildLessonCard(lesson, state),
                        const SizedBox(height: 32),
                        _buildProgressSection(state),
                        const Spacer(),
                        if (!state.showPopup)
                          _buildMicrophoneButton(context, state),
                        const SizedBox(height: 60),
                      ],
                    ),

                    if (state.showPopup)
                      _buildFeedbackPopup(context, state),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildParticlesBackground() {
    return AnimatedBuilder(
      animation: _particleController,
      builder: (context, child) {
        return CustomPaint(
          painter: ParticlesPainter(
            animationValue: _particleController.value,
          ),
          size: Size.infinite,
        );
      },
    );
  }

  Widget _buildAppBar(BuildContext context, SpeakingState state) {
    return FadeTransition(
      opacity: _headerController,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, -0.5),
          end: Offset.zero,
        ).animate(CurvedAnimation(
          parent: _headerController,
          curve: Curves.easeOut,
        )),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: widget.isPremium
                      ? Colors.white.withOpacity(0.1)
                      : AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: widget.isPremium
                      ? Border.all(
                          color: const Color(0xFFFFD700).withOpacity(0.3),
                        )
                      : null,
                ),
                child: IconButton(
                  onPressed: () => context.go('/home'),
                  icon: Icon(
                    Icons.arrow_back_ios_new,
                    color: widget.isPremium ? Colors.white : AppColors.primary,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Speaking Lesson",
                          style: TextStyle(
                            color: widget.isPremium ? Colors.white : Colors.black87,
                            fontSize: 20,
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
                      "Bài ${state.currentLesson + 1}/${state.currentLesson + 5}",
                      style: TextStyle(
                        color: widget.isPremium
                            ? Colors.white.withOpacity(0.7)
                            : Colors.black54,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  gradient: widget.isPremium
                      ? const LinearGradient(
                          colors: [Color(0xFFFFD700), Color(0xFFFFA500)],
                        )
                      : null,
                  color: widget.isPremium ? null : AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.star,
                      color: widget.isPremium ? Colors.white : AppColors.primary,
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      "${state.score.toInt()}",
                      style: TextStyle(
                        color: widget.isPremium ? Colors.white : AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
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

  Widget _buildPremiumBadge() {
    return AnimatedBuilder(
      animation: _shimmerController,
      builder: (context, child) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
            borderRadius: BorderRadius.circular(6),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFFFD700).withOpacity(0.5),
                blurRadius: 8,
              ),
            ],
          ),
          child: const Text(
            "PRO",
            style: TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
        );
      },
    );
  }

  Widget _buildLessonCard(String lesson, SpeakingState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TweenAnimationBuilder<double>(
        duration: const Duration(milliseconds: 800),
        tween: Tween(begin: 0.0, end: 1.0),
        builder: (context, value, child) {
          return Transform.scale(
            scale: 0.8 + (value * 0.2),
            child: Opacity(
              opacity: value,
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: widget.isPremium
                      ? LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            const Color(0xFFFFD700).withOpacity(0.9),
                            const Color(0xFFFFA500).withOpacity(0.8),
                          ],
                        )
                      : null,
                  color: widget.isPremium ? null : AppColors.primary,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: widget.isPremium
                          ? const Color(0xFFFFD700).withOpacity(0.4)
                          : AppColors.primary.withOpacity(0.4),
                      blurRadius: 24,
                      spreadRadius: 4,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.record_voice_over,
                        color: Colors.white,
                        size: 48,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Hãy đọc câu sau:",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      lesson,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildProgressSection(SpeakingState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Tiến độ",
                style: TextStyle(
                  color: widget.isPremium ? Colors.white : Colors.black87,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                "${((state.currentLesson + 1) / 5 * 100).toInt()}%",
                style: TextStyle(
                  color: widget.isPremium
                      ? const Color(0xFFFFD700)
                      : AppColors.primary,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: LinearProgressIndicator(
              value: (state.currentLesson + 1) / 5,
              minHeight: 12,
              backgroundColor: widget.isPremium
                  ? Colors.white.withOpacity(0.1)
                  : Colors.grey.shade200,
              valueColor: AlwaysStoppedAnimation<Color>(
                widget.isPremium
                    ? const Color(0xFFFFD700)
                    : AppColors.primary,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem(
                Icons.celebration,
                "Hoàn thành",
                "${state.currentLesson + 1}",
              ),
              _buildStatItem(
                Icons.pending,
                "Còn lại",
                "${4 - state.currentLesson}",
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(IconData icon, String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: widget.isPremium
            ? Colors.white.withOpacity(0.1)
            : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
        border: widget.isPremium
            ? Border.all(
                color: const Color(0xFFFFD700).withOpacity(0.2),
              )
            : null,
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: widget.isPremium ? const Color(0xFFFFD700) : AppColors.primary,
            size: 20,
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: TextStyle(
                  color: widget.isPremium ? Colors.white : Colors.black87,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                label,
                style: TextStyle(
                  color: widget.isPremium
                      ? Colors.white.withOpacity(0.7)
                      : Colors.black54,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMicrophoneButton(BuildContext context, SpeakingState state) {
    return GestureDetector(
      onTap: () => context.read<SpeakingBloc>().add(ToggleRecording()),
      child: AnimatedBuilder(
        animation: Listenable.merge([_waveController, _pulseController]),
        builder: (context, child) {
          return SizedBox(
            height: 200,
            width: 200,
            child: Stack(
              alignment: Alignment.center,
              children: [
                if (state.isRecording) ...[
                  for (int i = 0; i < 3; i++)
                    Transform.scale(
                      scale: 1.0 + (i * 0.3) + (_pulseController.value * 0.2),
                      child: Container(
                        width: 140 + (i * 20),
                        height: 140 + (i * 20),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: (widget.isPremium
                                    ? const Color(0xFFFFD700)
                                    : Colors.redAccent)
                                .withOpacity(0.2 - (i * 0.05)),
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                ],

                CustomPaint(
                  painter: WavePainter(
                    animationValue: _waveController.value,
                    active: state.isRecording,
                    color: (widget.isPremium
                            ? const Color(0xFFFFD700)
                            : AppColors.primary)
                        .withOpacity(0.3),
                  ),
                  size: const Size(180, 180),
                ),

                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  height: 110,
                  width: 110,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: state.isRecording
                        ? const LinearGradient(
                            colors: [Colors.red, Colors.redAccent],
                          )
                        : (widget.isPremium
                            ? const LinearGradient(
                                colors: [Color(0xFFFFD700), Color(0xFFFFA500)],
                              )
                            : null),
                    color: state.isRecording || widget.isPremium
                        ? null
                        : AppColors.primary,
                    boxShadow: [
                      BoxShadow(
                        color: (state.isRecording
                                ? Colors.redAccent
                                : (widget.isPremium
                                    ? const Color(0xFFFFD700)
                                    : AppColors.primary))
                            .withOpacity(0.6),
                        blurRadius: 30 + (_pulseController.value * 10),
                        spreadRadius: state.isRecording ? 15 : 8,
                      ),
                    ],
                  ),
                  child: Icon(
                    state.isRecording ? Icons.stop_rounded : Icons.mic,
                    color: Colors.white,
                    size: 52,
                  ),
                ),

                if (state.isRecording)
                  Positioned(
                    bottom: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            "Recording...",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildFeedbackPopup(BuildContext context, SpeakingState state) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () => context.read<SpeakingBloc>().add(HideFeedbackPopup()),
          child: Container(
            color: Colors.black.withOpacity(0.7),
            child: BackdropFilter(
              filter: widget.isPremium
                  ? ColorFilter.mode(
                      Colors.black.withOpacity(0.3),
                      BlendMode.darken,
                    )
                  : ColorFilter.mode(Colors.transparent, BlendMode.src),
              child: Container(),
            ),
          ),
        ),
        Center(
          child: AnimatedSlide(
            offset: state.showPopup ? Offset.zero : const Offset(0, 0.3),
            duration: const Duration(milliseconds: 600),
            curve: Curves.elasticOut,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 400),
              opacity: state.showPopup ? 1 : 0,
              child: Container(
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  gradient: widget.isPremium
                      ? const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xFFFFFFFF),
                            Color(0xFFF5F5F5),
                          ],
                        )
                      : null,
                  color: widget.isPremium ? null : Colors.white,
                  borderRadius: BorderRadius.circular(32),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 30,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Score badge
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        gradient: widget.isPremium
                            ? const LinearGradient(
                                colors: [Color(0xFFFFD700), Color(0xFFFFA500)],
                              )
                            : null,
                        color: widget.isPremium ? null : AppColors.primary,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: (widget.isPremium
                                    ? const Color(0xFFFFD700)
                                    : AppColors.primary)
                                .withOpacity(0.4),
                            blurRadius: 20,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.white,
                            size: 48,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "${state.score.toStringAsFixed(1)}",
                            style: const TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    Text(
                      _getScoreEmoji(state.score),
                      style: const TextStyle(fontSize: 48),
                    ),

                    const SizedBox(height: 16),

                    Text(
                      state.feedback,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 32),

                    // Action buttons
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {
                              context.read<SpeakingBloc>().add(
                                    HideFeedbackPopup(),
                                  );
                            },
                            icon: const Icon(Icons.replay),
                            label: const Text(
                              "Thử lại",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.redAccent,
                              side: const BorderSide(
                                color: Colors.redAccent,
                                width: 2,
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              context.read<SpeakingBloc>().add(
                                    NextLesson(context),
                                  );
                            },
                            icon: const Icon(Icons.arrow_forward_rounded),
                            label: const Text(
                              "Tiếp tục",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: widget.isPremium
                                  ? const Color(0xFFFFD700)
                                  : AppColors.primary,
                              foregroundColor: Colors.white,
                              elevation: 0,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  String _getScoreEmoji(double score) {
    if (score >= 90) return "🎉";
    if (score >= 75) return "😊";
    if (score >= 60) return "👍";
    return "💪";
  }
}

// Custom painter for animated particles
class ParticlesPainter extends CustomPainter {
  final double animationValue;

  ParticlesPainter({required this.animationValue});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFFFD700).withOpacity(0.1)
      ..style = PaintingStyle.fill;

    for (int i = 0; i < 20; i++) {
      final x = (i * 50.0 + animationValue * 100) % size.width;
      final y = (i * 30.0 + animationValue * 80) % size.height;
      canvas.drawCircle(Offset(x, y), 2 + (i % 3), paint);
    }
  }

  @override
  bool shouldRepaint(ParticlesPainter oldDelegate) => true;
}