import 'package:flutter/material.dart';

class CloudPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.05)
      ..style = PaintingStyle.fill;
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