import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/core/constants/themes/app_text_styles.dart';
import 'package:flutter_task/features/doctor_profile/presentation/controller/cubit/doctor_profile_cubit.dart';
import 'package:time_range/time_range.dart';

import '../../../../core/constants/themes/app_colors.dart';
import '../controller/states/doctor_profile_state.dart';

class CustomTimeRangeWidget extends StatefulWidget {

 final DoctorProfileState stateValues;
  const CustomTimeRangeWidget({super.key, required this.stateValues, });

  @override
  State<CustomTimeRangeWidget> createState() => _CustomTimeRangeWidgetState();
}

class _CustomTimeRangeWidgetState extends State<CustomTimeRangeWidget> {


  final _defaultTimeRange = TimeRangeResult(
    const TimeOfDay(hour: 8, minute: 00),
    const TimeOfDay(hour: 22, minute: 00),
  );
  TimeRangeResult? _timeRange;

  @override
  void initState() {
    super.initState();
    _timeRange = _defaultTimeRange;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[


          TimeRange(
            fromTitle: Text('FROM', style: _getLabelFieldStyle(context)),
            toTitle: Text('TO', style: _getLabelFieldStyle(context)),
            textStyle: Theme.of(context).textTheme.numbersStyle,
            activeTextStyle: _getActiveTextStyle(context),
            activeBackgroundColor: AppColors.green,
            activeBorderColor: Colors.black12,
            borderColor: Colors.black26,
            // backgroundColor: Colors.transparent,
            firstTime: const TimeOfDay(hour: 8, minute: 00),
            lastTime: const TimeOfDay(hour: 20, minute: 00),
            initialRange: _timeRange,
            timeStep: 60,
            timeBlock: 60,
            onRangeCompleted: (range) {


              setState(() => _timeRange = range);

              if(_timeRange != null){
                context.read<DoctorProfileCubit>().updateWorkHoursValues(from: _timeRange?.start.format(context), to:  _timeRange?.end.format(context));


              }else{
                context.read<DoctorProfileCubit>().deleteWorkHours(  );
              }

            },
            onFirstTimeSelected: (startHour) {
            },
          ),

        ],
      ),
    );
  }
  TextStyle _getActiveTextStyle(BuildContext context) {
    return Theme.of(context)
        .textTheme
        .numbersStyle
        .copyWith(color: Colors.white, fontWeight: FontWeight.w600);
  }

  TextStyle _getLabelFieldStyle(BuildContext context) {
    return Theme.of(context)
        .textTheme
        .styleField
        .copyWith(color: const Color(0xff3A59D1));
  }
}
