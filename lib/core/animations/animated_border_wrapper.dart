import 'dart:math' as math;


import 'package:flutter/material.dart';
import 'package:flutter_task/core/animations/rotating_border_painter.dart';

import '../constants/app_duration/app_duration.dart';

class AnimatedBorderWrapper extends StatefulWidget {
  final Widget child;

  const AnimatedBorderWrapper({super.key, required this.child});

  @override
  State<AnimatedBorderWrapper> createState() => _AnimatedBorderWrapperState();
}

class _AnimatedBorderWrapperState extends State<AnimatedBorderWrapper>
    with TickerProviderStateMixin {
  // Border
  late AnimationController _rotatingBorderController;

  late AnimationController _borderAnimationController;

  _rotatingBorderPainter() {
    _rotatingBorderController = AnimationController(
      vsync: this,
      duration: AppDurations.seconds_3,
    )..repeat();
  }

  void _borderAnimation() {
    _borderAnimationController = AnimationController(
      duration: AppDurations.seconds_3,
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void initState() {
    super.initState();

    _borderAnimation();
    _rotatingBorderPainter();
  }

  @override
  void dispose() {
    _rotatingBorderController.dispose();
    _borderAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _borderAnimationController,
      builder: (context, child) => CustomPaint(
        painter: RotatingBorderPainter(
          angle: _rotatingBorderController.value * 2 * math.pi,
          borderWidth: 30,
        ),
        child: child,
      ),
      child: widget.child,
    );
  }
}
