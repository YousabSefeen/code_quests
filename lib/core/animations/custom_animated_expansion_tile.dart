import 'package:flutter/material.dart';
import 'package:flutter_task/core/constants/themes/app_text_styles.dart';


class CustomAnimatedExpansionTile extends StatelessWidget {
  final Widget baseChild;
  final Widget child;
  final bool isExpanded;
  final void Function() onTap;
  const CustomAnimatedExpansionTile({
    super.key,
    required this.baseChild,
    required this.child,
    required this.isExpanded,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 3),
          title:  baseChild,
          trailing: AnimatedRotation(
            turns: isExpanded ? 1 : 0,
            duration: const Duration(milliseconds: 500),
            child: const Icon(Icons.keyboard_arrow_down),
          ),
          onTap: onTap,
        ),
        AnimatedCrossFade(
          firstChild: const SizedBox.shrink(),
          secondChild: child,
          crossFadeState:
          isExpanded ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 800),

          firstCurve: Curves.easeInOut,
          secondCurve: Curves.easeInOut,
        ),
      ],
    );
  }
}