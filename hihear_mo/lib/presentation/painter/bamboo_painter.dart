import 'package:flutter/material.dart';

class BambooPainter extends CustomPainter {
  final double animationValue;
  BambooPainter({required this.animationValue});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF2D5016).withOpacity(0.15)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    _drawBamboo(canvas, size, 30, paint, animationValue);
    _drawBamboo(canvas, size, size.width - 30, paint, -animationValue);
  }

  void _drawBamboo(Canvas canvas, Size size, double x, Paint paint, double sway) {
    final path = Path();
    const segments = 6;
    final segmentHeight = size.height / segments;

    for (int i = 0; i < segments; i++) {
      final y = i * segmentHeight;
      final swayOffset = sway * 10 * (i / segments);
      path.moveTo(x + swayOffset, y);
      path.lineTo(x + swayOffset, y + segmentHeight - 10);

      canvas.drawCircle(Offset(x + swayOffset, y + segmentHeight - 10), 5, paint);

      if (i > 2) {
        final leafPaint = Paint()
          ..color = const Color(0xFF4A7C2C).withOpacity(0.2)
          ..style = PaintingStyle.fill;
        canvas.drawOval(Rect.fromCenter(center: Offset(x + swayOffset + 15, y + segmentHeight / 2), width: 30, height: 10), leafPaint);
        canvas.drawOval(Rect.fromCenter(center: Offset(x + swayOffset - 15, y + segmentHeight / 2 + 5), width: 30, height: 10), leafPaint);
      }
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant BambooPainter oldDelegate) => true;
}
