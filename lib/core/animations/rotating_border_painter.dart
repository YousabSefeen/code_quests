import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../constants/themes/app_colors.dart';



class RotatingBorderPainter extends CustomPainter {
  final double angle;
  final double borderWidth;

  RotatingBorderPainter({
    required this.angle,
    required this.borderWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final center = rect.center;

    final radius = size.width / 2;

    // نجهز الـ Shader بتدرج دائري
    final gradient = SweepGradient(
      startAngle: 0.0,
      endAngle: 2 * math.pi,
      colors: AppColors.borderGradientAnimationColor,
      transform: GradientRotation(angle),
    );

    final paint = Paint()
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;

    final rRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Radius.circular(35),
    );

    canvas.drawRRect(rRect, paint);
  }

  @override
  bool shouldRepaint(covariant RotatingBorderPainter oldDelegate) {
    return oldDelegate.angle != angle;
  }
}
