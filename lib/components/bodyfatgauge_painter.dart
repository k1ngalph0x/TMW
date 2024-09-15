import 'package:flutter/material.dart';
import 'dart:math' as math;

class BodyFatGaugePainter extends CustomPainter {
  final double percentage;
  final Color color;
  final double animation;
  final Color backgroundColor;

  BodyFatGaugePainter(
      {required this.percentage,
      required this.color,
      required this.animation,
      required this.backgroundColor});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final rect = Rect.fromCircle(center: center, radius: radius);
    const startAngle = -math.pi / 2;
    final sweepAngle = 2 * math.pi * (percentage / 100) * animation;
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 20.0
      ..strokeCap = StrokeCap.round;

    // Draw background arc
    paint.color = Colors.grey.withOpacity(0.2);
    canvas.drawArc(rect, startAngle, 2 * math.pi, false, paint);

    // Draw percentage arc
    paint.color = color;
    canvas.drawArc(rect, startAngle, sweepAngle, false, paint);

    // Draw percentage text
    final textPainter = TextPainter(
      text: TextSpan(
        text: '${(percentage * animation).toStringAsFixed(1)}%',
        style:
            TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: color),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(
        canvas, center - Offset(textPainter.width / 2, textPainter.height / 2));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
