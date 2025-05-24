import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/themes/app_colors.dart';

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
          contentPadding: const EdgeInsets.only(left: 5, right: 10),
          title:  baseChild,
          trailing: CircleAvatar(
            radius: 13,
            backgroundColor: Colors.grey.shade100,
            child: AnimatedRotation(
              turns: isExpanded ? 1 : 0,
              duration: const Duration(milliseconds: 500),
              child: Icon(
                Icons.keyboard_arrow_down,
                size: 25.sp,
                color: AppColors.black,
              ),
            ),
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