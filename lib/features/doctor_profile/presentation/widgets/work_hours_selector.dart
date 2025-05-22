import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/core/constants/app_strings/app_strings.dart';
import 'package:flutter_task/core/constants/themes/app_text_styles.dart';

import '../../../../../core/animations/custom_animated_expansion_tile.dart';
import '../../../../core/animations/animated_fade_transition.dart';
import '../controller/cubit/doctor_profile_cubit.dart';
import '../controller/states/doctor_profile_state.dart';
import 'custom_field_container.dart';
import 'custom_time_tange_widget.dart';
import 'doctor_availability/selected_work_hours_display.dart';

class WorkHoursSelector extends StatefulWidget {
  final DoctorProfileState stateValues;

  const WorkHoursSelector({super.key, required this.stateValues});

  @override
  State<WorkHoursSelector> createState() => _WorkHoursSelectorState();
}

class _WorkHoursSelectorState extends State<WorkHoursSelector> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomFieldContainer(
        child: CustomAnimatedExpansionTile(
          baseChild: buildBaseChild(),
          isExpanded: widget.stateValues.isWorkHoursExpanded,
          onTap: () =>
              context.read<DoctorProfileCubit>().toggleWorkHoursExpanded(),
          child: _buildTimeRangePicker(),
        ),
      ),
    );
  }

  Widget buildBaseChild() {
    if (widget.stateValues.availableFromTime == '') {
      return AnimatedFadeTransition(
        child: Text(AppStrings.workHoursHint,
            style: Theme.of(context)
                .textTheme
                .hintFieldStyle
                .copyWith(fontWeight: FontWeight.w400)),
      );
    } else {
      return const SelectedWorkHoursDisplay();
    }
  }

  Widget _buildTimeRangePicker() =>
      CustomFieldContainer(
        child: CustomTimeRangeWidget(stateValues: widget.stateValues),
    );


}
