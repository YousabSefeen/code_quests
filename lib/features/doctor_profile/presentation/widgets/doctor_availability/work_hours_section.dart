import 'package:flutter/material.dart';
import 'package:flutter_task/core/constants/app_strings/app_strings.dart';
import 'package:flutter_task/core/constants/themes/app_colors.dart';
import 'package:flutter_task/core/constants/themes/app_text_styles.dart';
import 'package:time_range/time_range.dart';

import '../custom_field_container.dart';

class WorkHoursSection extends StatefulWidget {
  const WorkHoursSection({super.key});

  @override
  State<WorkHoursSection> createState() => _WorkHoursSectionState();
}

class _WorkHoursSectionState extends State<WorkHoursSection> {
  final _defaultTimeRange = TimeRangeResult(
    const TimeOfDay(hour: 14, minute: 00),
    const TimeOfDay(hour: 15, minute: 00),
  );
  TimeRangeResult? _timeRange;
  bool _isOpen = false;
  @override
  void initState() {
    super.initState();
    _timeRange = _defaultTimeRange;
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final labelFieldStyle = Theme.of(context)
        .textTheme
        .styleField
        .copyWith(color: const Color(0xff3A59D1));
    return SafeArea(
        child: CustomFieldContainer(
      child: CustomAnimatedExpansionTile(
        title: AppStrings.workHoursHint,
        child: CustomFieldContainer(
          child: TimeRange(
            fromTitle: Text('From', style: labelFieldStyle),
            toTitle: Text('To', style: labelFieldStyle),
            textStyle: textTheme.numbersStyle,
            activeTextStyle: textTheme.numbersStyle.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
            borderColor: Colors.black26,
            activeBorderColor: AppColors.green,
            backgroundColor: Colors.white,
            activeBackgroundColor: AppColors.green,
            firstTime: const TimeOfDay(hour: 8, minute: 0),
            lastTime: const TimeOfDay(hour: 22, minute: 0),
            initialRange: _timeRange,
            timeStep: 60,
            timeBlock: 60,
            onRangeCompleted: (range) => setState(() => _timeRange = range),
            onFirstTimeSelected: (_) {},
          ),
        ),
      ),
    ));
  }
}

class CustomAnimatedExpansionTile extends StatefulWidget {
  final String title;
  final Widget child;

  const CustomAnimatedExpansionTile({
    super.key,
    required this.title,
    required this.child,
  });

  @override
  State<CustomAnimatedExpansionTile> createState() =>
      _CustomAnimatedExpansionTileState();
}

class _CustomAnimatedExpansionTileState
    extends State<CustomAnimatedExpansionTile> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 3),
          title: Text(widget.title,style: Theme.of(context).textTheme.hintFieldStyle.copyWith(
            fontWeight: FontWeight.w400
          ),),
          trailing: AnimatedRotation(
            turns: _isExpanded ? 1 : 0,
            duration: const Duration(milliseconds: 500),
            child: const Icon(Icons.keyboard_arrow_down),
          ),
          onTap: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
        ),

        // AnimatedSize(
        //   duration: const Duration(milliseconds: 800),
        //   curve: Curves.easeInOut,
        //   child: _isExpanded ? widget.child : const SizedBox.shrink(),
        // ),
        AnimatedCrossFade(
          firstChild: const SizedBox.shrink(),
          secondChild: widget.child,
          crossFadeState: _isExpanded
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 800),

          firstCurve: Curves.easeInOut,
          secondCurve: Curves.easeInOut,
        ),
      ],
    );
  }
}
