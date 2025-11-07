import 'package:flutter/material.dart';
import 'dart:math';

class LanternPainter extends CustomPainter {
  final double animationValue;
  LanternPainter({required this.animationValue});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();

    // Vẽ 2 lồng đèn
    _drawLantern(canvas, size.width * 0.25, 50 + animationValue * 5, paint);
    _drawLantern(canvas, size.width * 0.75, 60 - animationValue * 5, paint);
  }

  void _drawLantern(Canvas canvas, double x, double y, Paint paint) {
    // ===== Tạo hiệu ứng lắc trái-phải =====
    double swing = sin(animationValue * 2 * pi) * 10; // ±10px swing
    double lanternX = x + swing;

    // ===== Dây treo =====
    paint
      ..color = Colors.grey.shade700
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    canvas.drawLine(Offset(lanternX, y - 40), Offset(lanternX, y - 10), paint);

    // ===== Gradient thân lồng đèn =====
    Rect lanternRect = Rect.fromCenter(center: Offset(lanternX, y), width: 40, height: 60);
    paint
      ..shader = LinearGradient(
        colors: [Color(0xFFFFE082), Color(0xFFFF6F00)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(lanternRect)
      ..style = PaintingStyle.fill;
    canvas.drawOval(lanternRect, paint);

    // ===== Viền thân =====
    paint
      ..shader = null
      ..color = Colors.redAccent.withOpacity(0.6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawOval(lanternRect, paint);

    // ===== Tua đèn =====
    paint
      ..style = PaintingStyle.fill
      ..color = Colors.yellow.shade600.withOpacity(0.8);
    for (int i = 0; i < 5; i++) {
      canvas.drawCircle(Offset(lanternX - 12 + i * 6, y + 35), 3, paint);
    }

    // ===== Họa tiết sọc ngang =====
    paint
      ..color = Colors.red.withOpacity(0.5)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;
    for (int i = -2; i <= 2; i++) {
      double stripeY = y + i * 8;
      canvas.drawLine(Offset(lanternX - 15, stripeY), Offset(lanternX + 15, stripeY), paint);
    }
  }

  @override
  bool shouldRepaint(covariant LanternPainter oldDelegate) => true;
}
