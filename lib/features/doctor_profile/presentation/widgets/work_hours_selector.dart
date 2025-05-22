import 'package:dartz/dartz.dart' as dartz;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/core/constants/app_strings/app_strings.dart';
import 'package:flutter_task/core/constants/themes/app_colors.dart';
import 'package:flutter_task/core/constants/themes/app_text_styles.dart';
import 'package:time_range/time_range.dart';

import '../../../../../core/animations/custom_animated_expansion_tile.dart';
import '../controller/cubit/doctor_profile_cubit.dart';
import '../controller/states/doctor_profile_state.dart';
import 'custom_field_container.dart';
import 'doctor_availability/selected_work_hours_display.dart';

class WorkHoursSelector extends StatefulWidget {
  final bool isExpanded;
  final bool isStartTimeEmpty;

  const WorkHoursSelector({
    super.key,
    required this.isExpanded,
    required this.isStartTimeEmpty,
  });

  @override
  State<WorkHoursSelector> createState() => _WorkHoursSelectorState();
}

class _WorkHoursSelectorState extends State<WorkHoursSelector> {


  @override
  void initState() {

    super.initState();

    context.read<DoctorProfileCubit>().checkWorkHours(true);
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomFieldContainer(
        child: _buildExpansionTile(context),
      ),
    );
  }

  Widget _buildExpansionTile(BuildContext context) {
    return BlocSelector<DoctorProfileCubit, DoctorProfileState,
        dartz.Tuple2<TimeRangeResult?, bool>>(
      selector: (state) =>
          dartz.Tuple2(state.workHoursRange, state.isWorkHoursFieldEmpty),
      builder: (context, values) => CustomAnimatedExpansionTile(
        baseChild: buildBaseChild(context, values.value2),
        isExpanded: widget.isExpanded,
        onTap: () =>
            context.read<DoctorProfileCubit>().toggleWorkHoursExpanded(),
        child: _buildTimeRangePicker(context, values.value1),
      ),
    );
  }

  Widget buildBaseChild(BuildContext context, bool isWorkHoursFieldEmpty) {


    return isWorkHoursFieldEmpty
          ?    buildHint(context)
          : const SelectedWorkHoursDisplay();

    //Text('Inavalid Work Hours',style: TextStyle(fontSize: 18,color: Colors.red),);
  }

  Text buildHint(BuildContext context) {
    return Text(
      AppStrings.workHoursHint,
      style: Theme.of(context)
          .textTheme
          .hintFieldStyle
          .copyWith(fontWeight: FontWeight.w400),
    );
  }

  Widget _buildTimeRangePicker(
      BuildContext context, TimeRangeResult? workHoursRange) {
    return CustomFieldContainer(
      child: TimeRange(
        fromTitle: widget.isExpanded
            ? Text('From', style: _getLabelFieldStyle(context))
            : null,
        toTitle: widget.isExpanded
            ? Text('To', style: _getLabelFieldStyle(context))
            : null,
        textStyle: Theme.of(context).textTheme.numbersStyle,

        activeTextStyle: _getActiveTextStyle(context),
        activeBackgroundColor: AppColors.green,
        activeBorderColor: Colors.black12,
        borderColor: Colors.black26,
        backgroundColor: Colors.transparent,
        firstTime: const TimeOfDay(hour: 8, minute: 0),
        lastTime: const TimeOfDay(hour: 20, minute: 0),
        initialRange: workHoursRange,

        timeStep: 60,
        timeBlock: 60,
        onFirstTimeSelected: (_) {},
        onRangeCompleted: (range) {


          if (  range?.start==null && range?.end==null) {
            context.read<DoctorProfileCubit>().updateConfirmWorkHours(null);

            context.read<DoctorProfileCubit>().checkWorkHours(false);
            return;
          } else {


            context.read<DoctorProfileCubit>().updateConfirmWorkHours(range);
            context.read<DoctorProfileCubit>().checkWorkHours(true);



          }


        },

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
