import 'dart:math';
import 'package:base_structure/core/singletons/app_colors.dart';
import 'package:flutter/material.dart';

class ProgressArcPainter extends CustomPainter {
  final double progress;

  ProgressArcPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint backgroundPaint = Paint()
      ..color = Colors.grey[300]!
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;

    final Paint progressPaint = Paint()
      ..color = AppColors.secondary
      ..strokeWidth = 8
      ..style = PaintingStyle.stroke
      ..maskFilter = const MaskFilter.blur(
          BlurStyle.normal, 5); // Adding shadow blur to the progress

    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width / 2) - 8;

    // Draw background circle
    canvas.drawCircle(center, radius, backgroundPaint);

    // Calculate the progress angle
    final double sweepAngle = 2 * pi * progress;

    // Draw progress arc with shadow
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
