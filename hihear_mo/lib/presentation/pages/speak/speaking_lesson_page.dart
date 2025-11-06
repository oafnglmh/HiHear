import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hihear_mo/presentation/painter/wave_painter.dart';
import '../../blocs/speaking/speaking_bloc.dart';
import '../../blocs/speaking/speaking_event.dart';
import '../../blocs/speaking/speaking_state.dart';

class SpeakingLessonPage extends StatefulWidget {
  const SpeakingLessonPage({super.key});

  @override
  State<SpeakingLessonPage> createState() => _SpeakingLessonPageState();
}

class _SpeakingLessonPageState extends State<SpeakingLessonPage>
    with TickerProviderStateMixin {
  late final AnimationController _waveController;
  late final AnimationController _pulseController;
  late final AnimationController _headerController;
  late final AnimationController _bambooController;
  late final AnimationController _fadeController;

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

    _headerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..forward();

    _bambooController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    )..repeat(reverse: true);

    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..forward();
  }

  @override
  void dispose() {
    _waveController.dispose();
    _pulseController.dispose();
    _headerController.dispose();
    _bambooController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SpeakingBloc(),
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            // Background gradient - màu tre xanh
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF4A7C2C), // Xanh lá tre đậm
                    Color(0xFF5E9A3A), // Xanh lá tre
                    Color(0xFF3D6624), // Xanh lá tre sẫm
                  ],
                ),
              ),
            ),

            // Bamboo decoration
            AnimatedBuilder(
              animation: _bambooController,
              builder: (context, child) {
                return CustomPaint(
                  painter: BambooPainter(
                    animationValue: _bambooController.value,
                  ),
                  size: Size.infinite,
                );
              },
            ),

            // Content
            SafeArea(
              child: BlocBuilder<SpeakingBloc, SpeakingState>(
                builder: (context, state) {
                  final bloc = context.read<SpeakingBloc>();
                  final lesson = bloc.lessons[state.currentLesson];

                  return Stack(
                    children: [
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
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context, SpeakingState state) {
    return FadeTransition(
      opacity: _fadeController,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: const Color(0xFFD4AF37).withOpacity(0.3),
                ),
              ),
              child: IconButton(
                onPressed: () => context.go('/home'),
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Bài Luyện Nói",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Bài ${state.currentLesson + 1}/${state.currentLesson + 5}",
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.star,
                    color: Colors.white,
                    size: 16,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    "${state.score.toInt()}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
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
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFFD4AF37),
                      Color(0xFFB8941E),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFD4AF37).withOpacity(0.4),
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
              const Text(
                "Tiến độ",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                "${((state.currentLesson + 1) / 5 * 100).toInt()}%",
                style: const TextStyle(
                  color: Color(0xFFD4AF37),
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
              backgroundColor: Colors.white.withOpacity(0.2),
              valueColor: const AlwaysStoppedAnimation<Color>(
                Color(0xFFD4AF37),
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
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.white.withOpacity(0.3),
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: const Color(0xFFD4AF37),
            size: 20,
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                label,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
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
                // Ripple effect when recording
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
                            color: Colors.redAccent.withOpacity(0.2 - (i * 0.05)),
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                ],

                // Wave animation
                CustomPaint(
                  painter: WavePainter(
                    animationValue: _waveController.value,
                    active: state.isRecording,
                    color: const Color(0xFFD4AF37).withOpacity(0.3),
                  ),
                  size: const Size(180, 180),
                ),

                // Main button
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
                        : const LinearGradient(
                            colors: [Color(0xFFD4AF37), Color(0xFFB8941E)],
                          ),
                    boxShadow: [
                      BoxShadow(
                        color: (state.isRecording
                                ? Colors.redAccent
                                : const Color(0xFFD4AF37))
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

                // Recording indicator
                if (state.isRecording)
                  Positioned(
                    bottom: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Colors.red, Colors.redAccent],
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.red.withOpacity(0.4),
                            blurRadius: 8,
                          ),
                        ],
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
                            "Đang ghi âm...",
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
        // Backdrop
        GestureDetector(
          onTap: () => context.read<SpeakingBloc>().add(HideFeedbackPopup()),
          child: Container(
            color: Colors.black.withOpacity(0.7),
          ),
        ),

        // Popup content
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
                  color: Colors.white,
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
                        gradient: const LinearGradient(
                          colors: [Color(0xFFD4AF37), Color(0xFFB8941E)],
                        ),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFD4AF37).withOpacity(0.4),
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
                              backgroundColor: const Color(0xFFD4AF37),
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

// Bamboo Painter - vẽ cây tre
class BambooPainter extends CustomPainter {
  final double animationValue;

  BambooPainter({required this.animationValue});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF2D5016).withOpacity(0.15)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    // Vẽ cây tre bên trái
    _drawBamboo(canvas, size, 30, paint, animationValue);
    // Vẽ cây tre bên phải
    _drawBamboo(canvas, size, size.width - 30, paint, -animationValue);
  }

  void _drawBamboo(Canvas canvas, Size size, double x, Paint paint, double sway) {
    final path = Path();
    final segments = 6;
    final segmentHeight = size.height / segments;
    
    for (int i = 0; i < segments; i++) {
      final y = i * segmentHeight;
      final swayOffset = sway * 10 * (i / segments);
      
      // Thân tre
      path.moveTo(x + swayOffset, y);
      path.lineTo(x + swayOffset, y + segmentHeight - 10);
      
      // Đốt tre
      canvas.drawCircle(
        Offset(x + swayOffset, y + segmentHeight - 10),
        5,
        paint,
      );
      
      // Lá tre
      if (i > 2) {
        final leafPaint = Paint()
          ..color = const Color(0xFF6DB33F).withOpacity(0.2)
          ..style = PaintingStyle.fill;
        
        canvas.drawOval(
          Rect.fromCenter(
            center: Offset(x + swayOffset + 15, y + segmentHeight / 2),
            width: 30,
            height: 10,
          ),
          leafPaint,
        );
        
        canvas.drawOval(
          Rect.fromCenter(
            center: Offset(x + swayOffset - 15, y + segmentHeight / 2 + 5),
            width: 30,
            height: 10,
          ),
          leafPaint,
        );
      }
    }
    
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(BambooPainter oldDelegate) => true;
}