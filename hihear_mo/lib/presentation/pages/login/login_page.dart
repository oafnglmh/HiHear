import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hihear_mo/core/constants/app_assets.dart';
import 'package:hihear_mo/l10n/app_localizations.dart';
import 'package:hihear_mo/presentation/blocs/Auth/auth_bloc.dart';
import 'package:hihear_mo/presentation/pages/login/widget/login_buttons_widget.dart';
import 'package:hihear_mo/presentation/pages/login/widget/logo_section_widget.dart';
import 'dart:math' as math;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  late final AnimationController _logoCtrl;
  late final AnimationController _buttonsCtrl;
  late final AnimationController _lotusCtrl;

  late final Animation<double> _logoScale;
  late final Animation<double> _logoOpacity;
  late final Animation<Offset> _buttonsSlide;
  late final Animation<double> _buttonsOpacity;

  @override
  void initState() {
    super.initState();

    _logoCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 1500));
    _buttonsCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 1200));
    _lotusCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 4000))..repeat(reverse: true);

    _logoScale = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _logoCtrl, curve: Curves.elasticOut));
    _logoOpacity = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _logoCtrl, curve: const Interval(0.0, 0.5)));
    _buttonsSlide = Tween(begin: const Offset(0, 0.3), end: Offset.zero)
        .animate(CurvedAnimation(parent: _buttonsCtrl, curve: Curves.easeOutCubic));
    _buttonsOpacity = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _buttonsCtrl, curve: Curves.easeIn));

    _logoCtrl.forward();
    Future.delayed(const Duration(milliseconds: 500), _buttonsCtrl.forward);
  }

  @override
  void dispose() {
    _logoCtrl.dispose();
    _buttonsCtrl.dispose();
    _lotusCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        state.whenOrNull(
          authenticated: (user) {
            context.go(user.national == null ? '/goalSelector' : '/goalSelector');
          },
          error: (msg) => ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(msg),
              backgroundColor: const Color(0xFFDA251C),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
        );
      },
      builder: (context, state) {
        final isLoading = state.maybeWhen(loading: () => true, orElse: () => false);

        return Scaffold(
          body: Stack(
            fit: StackFit.expand,
            children: [
              const _LoginBackground(),
              AnimatedBuilder(
                animation: _lotusCtrl,
                builder: (_, __) => CustomPaint(
                  painter: LotusPatternPainter(animationValue: _lotusCtrl.value),
                ),
              ),
              SafeArea(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Column(
                    children: [
                      const SizedBox(height: 60),
                      LogoSection(logoScale: _logoScale, logoOpacity: _logoOpacity, l10n: l10n),
                      const SizedBox(height: 60),
                      LoginButtons(
                        slide: _buttonsSlide,
                        opacity: _buttonsOpacity,
                        l10n: l10n,
                        isLoading: isLoading,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _LoginBackground extends StatelessWidget {
  const _LoginBackground();

  @override
  Widget build(BuildContext context) {
    return const DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF0A5C36), // Xanh lá sen đậm
            Color(0xFF1B7F4E), // Xanh lá sen
            Color(0xFF0D4D2D), // Xanh đậm
          ],
        ),
      ),
    );
  }
}

class LotusPatternPainter extends CustomPainter {
  final double animationValue;

  LotusPatternPainter({required this.animationValue});

  @override
  void paint(Canvas canvas, Size size) {
    // Vẽ hoa sen góc trên phải
    _drawLotusFlower(
      canvas,
      Offset(size.width - 80, 100 + math.sin(animationValue * math.pi * 2) * 5),
      80,
      0.15 + animationValue * 0.05,
    );

    // Vẽ hoa sen góc dưới trái
    _drawLotusFlower(
      canvas,
      Offset(80, size.height - 150 + math.cos(animationValue * math.pi * 2) * 8),
      100,
      0.12 + animationValue * 0.03,
    );

    // Vẽ lá sen góc dưới phải
    _drawLotusLeaf(
      canvas,
      Offset(size.width - 100, size.height - 100 + math.sin(animationValue * math.pi * 2) * 6),
      70,
      0.1 + animationValue * 0.02,
    );

    // Vẽ lá sen nhỏ góc trên trái
    _drawLotusLeaf(
      canvas,
      Offset(60, 80 + math.cos(animationValue * math.pi * 2) * 4),
      50,
      0.08,
    );
  }

  void _drawLotusFlower(Canvas canvas, Offset center, double size, double opacity) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.pink.shade100.withOpacity(opacity);

    // Vẽ cánh hoa sen (8 cánh)
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

    // Vẽ nhụy hoa
    final centerPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.yellow.shade300.withOpacity(opacity * 1.5);

    canvas.drawCircle(center, size * 0.15, centerPaint);

    // Vẽ chi tiết nhụy
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
    
    // Vẽ hình lá sen tròn với rãnh ở giữa
    path.moveTo(center.dx, center.dy - size);
    
    // Nửa bên phải
    path.quadraticBezierTo(
      center.dx + size * 0.9, center.dy - size * 0.7,
      center.dx + size, center.dy,
    );
    path.quadraticBezierTo(
      center.dx + size * 0.9, center.dy + size * 0.7,
      center.dx, center.dy + size,
    );
    
    // Rãnh ở giữa
    path.lineTo(center.dx, center.dy);
    
    // Nửa bên trái
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

    // Vẽ gân lá
    final veinPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..color = const Color(0xFF1B5A37).withOpacity(opacity * 0.8);

    // Gân chính
    canvas.drawLine(
      Offset(center.dx, center.dy - size),
      Offset(center.dx, center.dy + size),
      veinPaint,
    );

    // Gân phụ
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