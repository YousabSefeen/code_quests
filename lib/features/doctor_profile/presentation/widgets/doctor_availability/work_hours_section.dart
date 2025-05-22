import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/features/doctor_profile/presentation/controller/form_controllers/doctor_profile_validator.dart';

import '../../../../../core/constants/common_widgets/validation_message.dart';
import '../../controller/cubit/doctor_profile_cubit.dart';
import '../../controller/states/doctor_profile_state.dart';
import '../work_hours_selector.dart';

class WorkHoursSection extends StatelessWidget {
  const WorkHoursSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<DoctorProfileCubit, DoctorProfileState,
        Tuple2<String?, bool>>(
      selector: (state) =>
          Tuple2(state.availableFromTime, state.isWorkHoursExpanded),
      builder: (context, values) => _buildFormField(values),
    );
  }

  FormField<String> _buildFormField(Tuple2<String?, bool> values) {
    return FormField(
      validator: (_) =>
          DoctorProfileValidator().validateWorkingHours(values.value1),
      builder: (field) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          WorkHoursSelector(
            isExpanded: values.value2,
            isStartTimeEmpty: values.value1 == null,
          ),
          if (field.hasError) ValidationMessage(field.errorText!),
        ],
      ),
    );
  }
}
