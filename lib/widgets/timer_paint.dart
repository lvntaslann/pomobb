import 'dart:math';

import 'package:flutter/material.dart';

class TimerPainter extends CustomPainter {
  final Color backgroundColor;
  final Color progressColor;
  final double progress;

  TimerPainter({
    required this.backgroundColor,
    required this.progressColor,
    required this.progress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final strokeWidth = 10.0;
    final center = size.center(Offset.zero);
    final radius = (size.width / 2) - (strokeWidth / 2);

    final bgPaint = Paint()
      ..color = backgroundColor
      ..strokeWidth = strokeWidth - 1
      ..style = PaintingStyle.stroke;

    final progressPaint = Paint()
      ..color = progressColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.butt;

    canvas.drawCircle(center, radius, bgPaint);

    final sweepAngle = 2 * pi * progress;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2 + 0.001,
      sweepAngle,
      false,
      progressPaint,
    );
  }
 @override
  bool shouldRepaint(TimerPainter oldDelegate) =>
      oldDelegate.progress != progress;
}