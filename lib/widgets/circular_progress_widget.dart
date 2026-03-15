import 'dart:math';
import 'package:flutter/material.dart';
import '../utils/app_theme.dart';

class CircularProgressWidget extends StatelessWidget {
  final double percentage; // 0.0 to 1.0
  final String centerText;
  final String labelText;

  const CircularProgressWidget({
    super.key,
    required this.percentage,
    required this.centerText,
    required this.labelText,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160,
      height: 160,
      child: CustomPaint(
        painter: _CircularProgressPainter(
          percentage: percentage,
          progressColor: AppTheme.primaryColor,
          backgroundColor: Theme.of(context).brightness == Brightness.dark 
              ? const Color(0xFF334155) // slate-700
              : const Color(0xFFF1F5F9), // slate-100
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              centerText,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              labelText.toUpperCase(),
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: AppTheme.textMutedDark,
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CircularProgressPainter extends CustomPainter {
  final double percentage;
  final Color progressColor;
  final Color backgroundColor;

  _CircularProgressPainter({
    required this.percentage,
    required this.progressColor,
    required this.backgroundColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    const strokeWidth = 12.0;

    final bgPaint = Paint()
      ..color = backgroundColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final progressPaint = Paint()
      ..color = progressColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    // Draw background circle
    canvas.drawCircle(center, radius - (strokeWidth / 2), bgPaint);

    // Draw progress arc
    final sweepAngle = 2 * pi * percentage;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - (strokeWidth / 2)),
      -pi / 2, // Start at top
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _CircularProgressPainter oldDelegate) {
    return oldDelegate.percentage != percentage ||
           oldDelegate.progressColor != progressColor ||
           oldDelegate.backgroundColor != backgroundColor;
  }
}
