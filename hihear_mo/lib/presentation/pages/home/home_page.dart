import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hihear_mo/core/constants/app_constants.dart';
import 'package:lottie/lottie.dart';

import 'package:hihear_mo/core/constants/app_assets.dart';
import 'package:hihear_mo/core/constants/app_colors.dart';
import 'package:hihear_mo/presentation/blocs/lesson/lesson_bloc.dart';
import 'package:hihear_mo/presentation/pages/home/widgets/floating_nav_bar.dart';
import 'package:hihear_mo/presentation/pages/home/widgets/streak_popup.dart';
import 'package:hihear_mo/presentation/pages/home/widgets/home_content.dart';
import 'package:hihear_mo/presentation/pages/speak/speak_page.dart';
import 'package:hihear_mo/presentation/pages/HearuAi/ai_chat_page.dart';
import 'package:hihear_mo/presentation/pages/saveVocab/saved_vocab_page.dart';
import 'package:hihear_mo/presentation/pages/profile/profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final PageController _pageController = PageController();
  late final AnimationController _navBarController;
  late final AnimationController _bambooController;
  late final AnimationController _lotusController;
  late final AnimationController _rippleController;
  int _selectedIndex = 0;
  bool _hasShownStreakPopup = false;

  @override
  void initState() {
    super.initState();
    context.read<LessonBloc>().add(const LessonEvent.loadLesson());
    _navBarController = AnimationController(vsync: this, duration: AppDuration.short);
    _bambooController = AnimationController(vsync: this, duration: AppDuration.bamboo)
      ..repeat(reverse: true);
    
    _lotusController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 4000),
    )..repeat(reverse: true);

    _rippleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    )..repeat();


    Future.delayed(const Duration(milliseconds: 600), () {
      if (mounted && !_hasShownStreakPopup) {
        _showStreakPopup();
        _hasShownStreakPopup = true;
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _navBarController.dispose();
    _bambooController.dispose();
    _lotusController.dispose();
    _rippleController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    if (_selectedIndex == index) return;
    setState(() => _selectedIndex = index);
    _navBarController.forward(from: 0);
    _pageController.animateToPage(
      index,
      duration: AppDuration.medium,
      curve: Curves.easeInOutCubic,
    );
  }

  void _showStreakPopup() {
    showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black54,
      builder: (_) => const StreakPopup(streakDays: 1),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      const HomeContent(),
      const SpeakPage(),
      const AiChatPage(),
      const SavedVocabPage(),
      const ProfilePage(),
    ];

    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          // Gradient background - giống StartPage
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF0A5C36), // Xanh lá sen đậm
                    Color(0xFF1B7F4E), // Xanh lá sen
                    Color(0xFF0D6B3D), // Xanh trung bình
                    Color(0xFF0D4D2D), // Xanh đậm
                  ],
                ),
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
            child: PageView(
              controller: _pageController,
              physics: const BouncingScrollPhysics(),
              onPageChanged: (i) => setState(() => _selectedIndex = i),
              children: pages,
            ),
          ),

          // Navigation bar
          Positioned(
            left: 0,
            right: 0,
            bottom: AppPadding.medium,
            child: FloatingNavBar(
              selectedIndex: _selectedIndex,
              onItemTapped: _onItemTapped,
            ),
          ),
        ],
      ),
    );
  }
}

// Lotus Pattern Painter - giống StartPage
class LotusPatternPainter extends CustomPainter {
  final double animationValue;

  LotusPatternPainter({required this.animationValue});

  @override
  void paint(Canvas canvas, Size size) {
    // Vẽ hoa sen góc trên phải
    _drawLotusFlower(
      canvas,
      Offset(size.width - 70, 80 + math.sin(animationValue * math.pi * 2) * 8),
      90,
      0.18 + animationValue * 0.06,
    );

    // Vẽ hoa sen góc dưới trái
    _drawLotusFlower(
      canvas,
      Offset(70, size.height - 120 + math.cos(animationValue * math.pi * 2) * 10),
      110,
      0.15 + animationValue * 0.04,
    );

    // Vẽ hoa sen nhỏ góc trên trái
    _drawLotusFlower(
      canvas,
      Offset(80, 100 + math.sin(animationValue * math.pi * 2 + 1) * 6),
      70,
      0.12 + animationValue * 0.03,
    );

    // Vẽ lá sen góc dưới phải
    _drawLotusLeaf(
      canvas,
      Offset(size.width - 90, size.height - 100 + math.sin(animationValue * math.pi * 2) * 7),
      75,
      0.12 + animationValue * 0.03,
    );

    // Vẽ lá sen nhỏ góc trên phải
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

    // Vẽ 8 cánh hoa
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

    // Nhụy hoa
    final centerPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.yellow.shade300.withOpacity(opacity * 1.5);

    canvas.drawCircle(center, size * 0.15, centerPaint);

    // Chi tiết nhụy
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

    // Gân lá
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

// Ripple Effect Painter - giống StartPage
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