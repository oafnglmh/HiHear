import 'package:flutter/material.dart';

class LanternPainter extends CustomPainter {
  final double animationValue;
  LanternPainter({required this.animationValue});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    _drawLantern(canvas, size.width * 0.25, 50 + animationValue * 5, paint);
    _drawLantern(canvas, size.width * 0.75, 60 - animationValue * 5, paint);
  }

  void _drawLantern(Canvas canvas, double x, double y, Paint paint) {
    paint.color = const Color(0xFFFFCD00).withOpacity(0.3);
    canvas.drawOval(Rect.fromCenter(center: Offset(x, y), width: 30, height: 40), paint);

    paint
      ..color = const Color(0xFFDA251C).withOpacity(0.4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawOval(Rect.fromCenter(center: Offset(x, y), width: 30, height: 40), paint);

    paint
      ..style = PaintingStyle.fill
      ..color = const Color(0xFFFFCD00).withOpacity(0.4);
    for (int i = 0; i < 5; i++) {
      canvas.drawCircle(Offset(x - 10 + i * 5, y + 25), 2, paint);
    }
  }

  @override
  bool shouldRepaint(covariant LanternPainter oldDelegate) => true;
}