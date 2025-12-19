import 'dart:math' as math;

import 'package:flutter/material.dart';

class SimpleLotusPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.pink.shade100.withOpacity(0.3);

    final center = Offset(size.width / 2, size.height / 2);
    final petalSize = size.width / 3;

    // Draw 8 petals
    for (int i = 0; i < 8; i++) {
      final angle = (i * math.pi / 4);
      canvas.save();
      canvas.translate(center.dx, center.dy);
      canvas.rotate(angle);

      final path = Path();
      path.moveTo(0, 0);
      path.quadraticBezierTo(
        petalSize * 0.3, -petalSize * 0.6,
        0, -petalSize,
      );
      path.quadraticBezierTo(
        -petalSize * 0.3, -petalSize * 0.6,
        0, 0,
      );

      canvas.drawPath(path, paint);
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(SimpleLotusPainter oldDelegate) => false;
}
