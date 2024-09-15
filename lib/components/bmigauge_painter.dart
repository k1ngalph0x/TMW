import 'package:flutter/material.dart';
import 'dart:math' as math;

class BmiGaugePainter extends CustomPainter {
  final double bmi;
  final double animation;
  final Color backgroundColor;

  BmiGaugePainter(
      {required this.bmi,
      required this.animation,
      required this.backgroundColor});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final rect = Rect.fromCircle(center: center, radius: radius);
    const startAngle = math.pi * 0.75;
    const sweepAngle = math.pi * 1.5;
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 15.0
      ..strokeCap = StrokeCap.round;

    // Draw background arc
    paint.color = Colors.grey.withOpacity(0.2);
    canvas.drawArc(rect, startAngle, sweepAngle, false, paint);

    // Draw BMI arc
    final gradient = SweepGradient(
      startAngle: startAngle,
      endAngle: startAngle + sweepAngle,
      colors: [Colors.blue, Colors.green, Colors.orange, Colors.red],
      stops: [0.0, 0.3125, 0.625, 1.0],
    );
    paint.shader = gradient.createShader(rect);

    final bmiAngle = (sweepAngle * (bmi / 40).clamp(0.0, 1.0) * animation)
        .clamp(0.0, sweepAngle);
    canvas.drawArc(rect, startAngle, bmiAngle, false, paint);

    // Draw pointer
    final pointerAngle = startAngle + bmiAngle;
    final pointerLength = radius - 20;
    final pointerEnd = Offset(
      center.dx + pointerLength * math.cos(pointerAngle),
      center.dy + pointerLength * math.sin(pointerAngle),
    );
    canvas.drawLine(
        center,
        pointerEnd,
        Paint()
          ..color = Colors.white
          ..strokeWidth = 2
          ..strokeCap = StrokeCap.round);

    canvas.drawCircle(center, 5, Paint()..color = Colors.white);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
