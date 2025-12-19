import 'dart:math' as math;

import 'package:flutter/material.dart';

class LotusPatternPainter extends CustomPainter {
  final double animationValue;

  LotusPatternPainter({required this.animationValue});

  @override
  void paint(Canvas canvas, Size size) {
    _drawLotusFlower(
      canvas,
      Offset(size.width - 80, 100 + math.sin(animationValue * math.pi * 2) * 5),
      80,
      0.15 + animationValue * 0.05,
    );

    _drawLotusFlower(
      canvas,
      Offset(80, size.height - 150 + math.cos(animationValue * math.pi * 2) * 8),
      100,
      0.12 + animationValue * 0.03,
    );

    _drawLotusLeaf(
      canvas,
      Offset(size.width - 100, size.height - 100 + math.sin(animationValue * math.pi * 2) * 6),
      70,
      0.1 + animationValue * 0.02,
    );

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

    final centerPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.yellow.shade300.withOpacity(opacity * 1.5);

    canvas.drawCircle(center, size * 0.15, centerPaint);

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