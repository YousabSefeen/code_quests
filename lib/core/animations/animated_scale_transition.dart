import 'package:flutter/material.dart';

import '../constants/app_duration/app_duration.dart';






class AnimatedScaleTransition extends StatefulWidget {

  final Widget child;
  const AnimatedScaleTransition({super.key, required this.child});

  @override
  State<AnimatedScaleTransition> createState() => _AnimatedScaleTransitionState();
}

class _AnimatedScaleTransitionState extends State<AnimatedScaleTransition>  with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  _initializeAnimation() {
    _controller = AnimationController(
      vsync: this,
      duration: AppDurations.milliseconds_1200,
    )..forward();

    _scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutBack,
    );
  }

  @override
  void initState() {
    _initializeAnimation();
    super.initState();
  }
  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: widget.child,
    );
  }
}
