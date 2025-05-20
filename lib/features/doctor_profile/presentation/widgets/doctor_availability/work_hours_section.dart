import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';import 'package:flutter_task/core/constants/themes/app_text_styles.dart';
import 'package:time_range/time_range.dart';

import '../custom_field_container.dart';

class WorkHoursSection extends StatefulWidget {
  const WorkHoursSection({super.key});

  @override
  State<WorkHoursSection> createState() => _WorkHoursSectionState();
}

class _WorkHoursSectionState extends State<WorkHoursSection> {
  static const orange = Color(0xFFFFFFFF);
  static const dark = Color(0xff66BB6A);

  final _defaultTimeRange = TimeRangeResult(
    const TimeOfDay(hour: 14, minute: 00),
    const TimeOfDay(hour: 15, minute: 00),
  );
  TimeRangeResult? _timeRange;

  @override
  void initState() {
    super.initState();
    _timeRange = _defaultTimeRange;
  }

  @override
  Widget build(BuildContext context) {
    final labelFieldStyle = Theme.of(context)
        .textTheme
        .labelFieldStyle
        .copyWith(
            fontSize: 15.sp,
            color: Color(0xff3A59D1),
            fontWeight: FontWeight.w800);
    return SafeArea(
      child: CustomFieldContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TimeRange(
              fromTitle: Text(
                'From',
                style: labelFieldStyle,
              ),
              toTitle: Text(
                'To',
                style: labelFieldStyle,
              ),
              textStyle: const TextStyle(
                fontWeight: FontWeight.normal,
                color: Colors.black,
              ),
              activeTextStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                color: orange,
              ),
              borderColor: Colors.black26,
              activeBorderColor: dark,
              backgroundColor: Colors.white,
              activeBackgroundColor: dark,
              firstTime: TimeOfDay(hour: 8, minute: 0),
              lastTime: TimeOfDay(hour: 22, minute: 0),
              initialRange: _timeRange,
              timeStep: 60,
              timeBlock: 60,
              onRangeCompleted: (range) => setState(() => _timeRange = range),
              onFirstTimeSelected: (startHour) {},
            ),
            // const SizedBox(height: 30),
            // if (_timeRange != null)
            //   Padding(
            //     padding: const EdgeInsets.only(top: 8.0, left: leftPadding),
            //     child: Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: <Widget>[
            //         Text(
            //           'Selected Range: ${_timeRange!.start.format(context)} - ${_timeRange!.end.format(context)}',
            //           style: const TextStyle(fontSize: 20, color: dark),
            //         ),
            //         const SizedBox(height: 20),
            //         MaterialButton(
            //           onPressed: () =>
            //               setState(() => _timeRange = _defaultTimeRange),
            //           color: orange,
            //           child: const Text('Default'),
            //         )
            //       ],
            //     ),
            //   ),
          ],
        ),
      ),
    );
  }
}
