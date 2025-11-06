import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:go_router/go_router.dart';
import 'package:hihear_mo/core/constants/app_assets.dart';
import 'package:hihear_mo/l10n/app_localizations.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> with TickerProviderStateMixin {
  late AnimationController _bambooController;
  late AnimationController _fadeController;
  late AnimationController _slideController;

  @override
  void initState() {
    super.initState();
    
    _bambooController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    )..repeat(reverse: true);

    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..forward();

    _slideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..forward();
  }

  @override
  void dispose() {
    _bambooController.dispose();
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background gradient - màu tre xanh Việt Nam
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

          // Vân mây nhẹ
          Positioned.fill(
            child: CustomPaint(
              painter: CloudPainter(),
            ),
          ),

          // Content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32),
              child: Column(
                children: [
                  const Spacer(),

                  // Message box với họa tiết Việt Nam
                  SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0, 0.3),
                      end: Offset.zero,
                    ).animate(CurvedAnimation(
                      parent: _slideController,
                      curve: Curves.easeOutCubic,
                    )),
                    child: FadeTransition(
                      opacity: _fadeController,
                      child: Column(
                        children: [
                          // Tiêu đề với chữ Việt Nam
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [
                                  Color(0xFFDA291C), // Đỏ cờ Việt Nam
                                  Color(0xFFFD0000),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFFDA291C).withOpacity(0.4),
                                  blurRadius: 12,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  '🇻🇳',
                                  style: TextStyle(fontSize: 24),
                                ),
                                SizedBox(width: 8),
                                Text(
                                  'Tiếng Việt',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.2,
                                  ),
                                ),
                                SizedBox(width: 8),
                                Icon(
                                  Icons.star,
                                  color: Color(0xFFFFD700),
                                  size: 20,
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 20),

                          // Message box với viền vàng gold
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: const Color(0xFFD4AF37),
                                width: 3,
                              ),
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

                                DefaultTextStyle(
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: Color(0xFF2D5016),
                                    fontWeight: FontWeight.w600,
                                    height: 1.5,
                                  ),
                                  child: AnimatedTextKit(
                                    animatedTexts: [
                                      TypewriterAnimatedText(
                                        l10n.journeyStartMessage,
                                        speed: const Duration(milliseconds: 70),
                                      ),
                                    ],
                                    totalRepeatCount: 1,
                                    pause: const Duration(milliseconds: 500),
                                    displayFullTextOnTap: true,
                                    stopPauseOnTap: true,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 32),
                          
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.9),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: const Color(0xFFD4AF37).withOpacity(0.5),
                                width: 2,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 16,
                                  offset: const Offset(0, 6),
                                ),
                              ],
                            ),
                            child: Image.asset(
                              AppAssets.welcomeGif,
                              height: 150,
                              width: 200,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const Spacer(),

                  // Button bắt đầu
                  TweenAnimationBuilder<double>(
                    duration: const Duration(milliseconds: 600),
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
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFFD4AF37).withOpacity(0.5),
                                  blurRadius: 20,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                            ),
                            child: ElevatedButton(
                              onPressed: () {
                                context.go('/home');
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFD4AF37),
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    l10n.startButton,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1.2,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  const Icon(
                                    Icons.arrow_forward_rounded,
                                    size: 28,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
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

// Cloud Painter - vẽ mây nhẹ
class CloudPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.05)
      ..style = PaintingStyle.fill;

    // Vẽ vài đám mây nhẹ
    _drawCloud(canvas, size.width * 0.2, size.height * 0.15, 60, paint);
    _drawCloud(canvas, size.width * 0.7, size.height * 0.25, 50, paint);
    _drawCloud(canvas, size.width * 0.4, size.height * 0.8, 55, paint);
  }

  void _drawCloud(Canvas canvas, double x, double y, double radius, Paint paint) {
    canvas.drawCircle(Offset(x, y), radius, paint);
    canvas.drawCircle(Offset(x + radius * 0.6, y), radius * 0.8, paint);
    canvas.drawCircle(Offset(x - radius * 0.6, y), radius * 0.7, paint);
  }

  @override
  bool shouldRepaint(CloudPainter oldDelegate) => false;
}