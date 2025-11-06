import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:go_router/go_router.dart';
import 'package:hihear_mo/l10n/app_localizations.dart';
import '../../../../core/constants/app_assets.dart';

class StudyTimePage extends StatefulWidget {
  const StudyTimePage({super.key});

  @override
  State<StudyTimePage> createState() => _StudyTimePageState();
}

class _StudyTimePageState extends State<StudyTimePage>
    with TickerProviderStateMixin {
  int? selectedTime;
  late AnimationController _headerController;
  late AnimationController _bambooController;
  late AnimationController _leafController;

  @override
  void initState() {
    super.initState();

    _headerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..forward();

    _bambooController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    )..repeat(reverse: true);

    _leafController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _headerController.dispose();
    _bambooController.dispose();
    _leafController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Gradient Background - màu tre xanh
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

          // Falling leaves
          AnimatedBuilder(
            animation: _leafController,
            builder: (context, child) {
              return CustomPaint(
                painter: LeavesPainter(
                  animationValue: _leafController.value,
                ),
                size: Size.infinite,
              );
            },
          ),

          // Content
          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),
                  _buildHeader(l10n),
                  const SizedBox(height: 40),
                  _buildQuestionBubble(l10n),
                  const SizedBox(height: 48),
                  _buildTimeOptions(l10n),
                  const SizedBox(height: 40),
                  _buildNextButton(l10n),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(AppLocalizations l10n) {
    return FadeTransition(
      opacity: _headerController,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFD4AF37), Color(0xFFB8941E)], // Vàng tre
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFD4AF37).withOpacity(0.4),
                      blurRadius: 16,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.timer_outlined,
                  color: Colors.white,
                  size: 28,
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
                          "Mục tiêu học tập",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 8),
                        _buildPremiumBadge(),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Đặt mục tiêu hàng ngày 🎋",
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.85),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPremiumBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFFD4AF37),
            Color(0xFFB8941E),
          ],
        ),
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFD4AF37).withOpacity(0.5),
            blurRadius: 8,
          ),
        ],
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.workspace_premium, color: Colors.white, size: 12),
          SizedBox(width: 4),
          Text(
            "PRO",
            style: TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionBubble(AppLocalizations l10n) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 800),
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Transform.scale(
          scale: 0.8 + (value * 0.2),
          child: Opacity(
            opacity: value,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Character
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFFD4AF37),
                        Color(0xFFB8941E),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFD4AF37).withOpacity(0.3),
                        blurRadius: 16,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Image.asset(
                    AppAssets.hearuHi,
                    height: 80,
                    width: 80,
                  ),
                ),
                
                const SizedBox(width: 12),
                
                // Speech bubble
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.white.withOpacity(0.2),
                          Colors.white.withOpacity(0.15),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: const Color(0xFFD4AF37).withOpacity(0.4),
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: DefaultTextStyle(
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        height: 1.4,
                      ),
                      child: AnimatedTextKit(
                        animatedTexts: [
                          TypewriterAnimatedText(
                            l10n.dailyGoalQuestion,
                            speed: const Duration(milliseconds: 70),
                          ),
                        ],
                        totalRepeatCount: 1,
                        pause: const Duration(milliseconds: 500),
                        displayFullTextOnTap: true,
                        stopPauseOnTap: true,
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

  Widget _buildTimeOptions(AppLocalizations l10n) {
    final options = [
      {'time': 3, 'level': l10n.difficultyEasy, 'icon': Icons.sentiment_satisfied},
      {'time': 10, 'level': l10n.difficultyMedium, 'icon': Icons.fitness_center},
      {'time': 15, 'level': l10n.difficultyHard, 'icon': Icons.trending_up},
      {'time': 30, 'level': l10n.difficultyVeryHard, 'icon': Icons.local_fire_department},
    ];

    return Column(
      children: options.asMap().entries.map((entry) {
        final index = entry.key;
        final item = entry.value;
        final time = item['time'] as int;
        final level = item['level'] as String;
        final icon = item['icon'] as IconData;
        final isSelected = selectedTime == time;

        return TweenAnimationBuilder<double>(
          duration: Duration(milliseconds: 400 + (index * 100)),
          tween: Tween(begin: 0.0, end: 1.0),
          builder: (context, value, child) {
            return Transform.translate(
              offset: Offset(50 * (1 - value), 0),
              child: Opacity(
                opacity: value,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: _buildTimeCard(
                    time: time,
                    level: level,
                    icon: icon,
                    isSelected: isSelected,
                    l10n: l10n,
                  ),
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }

  Widget _buildTimeCard({
    required int time,
    required String level,
    required IconData icon,
    required bool isSelected,
    required AppLocalizations l10n,
  }) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTime = time;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: isSelected
              ? const LinearGradient(
                  colors: [Color(0xFFD4AF37), Color(0xFFB8941E)],
                )
              : null,
          color: isSelected ? null : Colors.white.withOpacity(0.15),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? const Color(0xFFD4AF37)
                : Colors.white.withOpacity(0.3),
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: const Color(0xFFD4AF37).withOpacity(0.4),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ]
              : [],
        ),
        child: Row(
          children: [
            // Icon
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isSelected
                    ? Colors.white.withOpacity(0.2)
                    : Colors.white.withOpacity(0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: Colors.white,
                size: 28,
              ),
            ),
            
            const SizedBox(width: 16),
            
            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$time ${l10n.minuteLabel} / ${l10n.dayLabel}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    level,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.white.withOpacity(0.85),
                    ),
                  ),
                ],
              ),
            ),
            
            // Check indicator
            if (isSelected)
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_rounded,
                  color: Colors.white,
                  size: 20,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildNextButton(AppLocalizations l10n) {
    final isEnabled = selectedTime != null;

    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 800),
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Transform.scale(
          scale: 0.8 + (value * 0.2),
          child: Opacity(
            opacity: value,
            child: Container(
              width: double.infinity,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                boxShadow: isEnabled
                    ? [
                        BoxShadow(
                          color: const Color(0xFFD4AF37).withOpacity(0.4),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ]
                    : [],
              ),
              child: ElevatedButton(
                onPressed: isEnabled
                    ? () {
                        context.go('/languageCountry');
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD4AF37),
                  foregroundColor: Colors.white,
                  disabledBackgroundColor: Colors.white.withOpacity(0.1),
                  disabledForegroundColor: Colors.white.withOpacity(0.3),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      l10n.nextButton,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(Icons.arrow_forward_rounded, size: 24),
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

// Leaves Painter - lá tre rơi
class LeavesPainter extends CustomPainter {
  final double animationValue;

  LeavesPainter({required this.animationValue});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF6DB33F).withOpacity(0.3)
      ..style = PaintingStyle.fill;

    for (int i = 0; i < 15; i++) {
      final x = (i * 80.0 + animationValue * 100) % size.width;
      final y = (i * 60.0 + animationValue * 200) % size.height;
      final rotation = animationValue * 6.28 + i;
      
      canvas.save();
      canvas.translate(x, y);
      canvas.rotate(rotation);
      
      // Vẽ lá tre
      final path = Path();
      path.moveTo(0, -8);
      path.quadraticBezierTo(4, -4, 6, 0);
      path.quadraticBezierTo(4, 4, 0, 8);
      path.quadraticBezierTo(-4, 4, -6, 0);
      path.quadraticBezierTo(-4, -4, 0, -8);
      
      canvas.drawPath(path, paint);
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(LeavesPainter oldDelegate) => true;
}