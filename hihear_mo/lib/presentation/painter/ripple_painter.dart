import 'package:flutter/material.dart';

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