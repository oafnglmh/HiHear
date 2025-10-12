import 'package:flutter/material.dart';

class WavePainter extends CustomPainter {
  final double animationValue;
  final bool active;
  final Color color;

  WavePainter({
    required this.animationValue,
    required this.active,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (!active) return;

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = 40 + 20 * animationValue;

    canvas.drawCircle(center, radius, paint);
    canvas.drawCircle(center, radius * 0.7, paint..strokeWidth = 2);
  }

  @override
  bool shouldRepaint(covariant WavePainter oldDelegate) =>
      animationValue != oldDelegate.animationValue ||
      active != oldDelegate.active;
}
