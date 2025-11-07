import 'package:flutter/material.dart';

class LeavesPainter extends CustomPainter {
  final double animationValue;

  LeavesPainter({required this.animationValue});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF6DB33F).withOpacity(0.3)
      ..style = PaintingStyle.fill;

    for (int i = 0; i < 15; i++) {
      final x = (i * 80.0 + animationValue * 100) % size.width;
      final y = (i * 60.0 + animationValue * 200) % size.height;
      final rotation = animationValue * 6.28 + i;
      
      canvas.save();
      canvas.translate(x, y);
      canvas.rotate(rotation);
      
      // Vẽ lá tre
      final path = Path();
      path.moveTo(0, -8);
      path.quadraticBezierTo(4, -4, 6, 0);
      path.quadraticBezierTo(4, 4, 0, 8);
      path.quadraticBezierTo(-4, 4, -6, 0);
      path.quadraticBezierTo(-4, -4, 0, -8);
      
      canvas.drawPath(path, paint);
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(LeavesPainter oldDelegate) => true;
}