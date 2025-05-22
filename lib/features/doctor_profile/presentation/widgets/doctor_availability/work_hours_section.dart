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
    return BlocConsumer <DoctorProfileCubit, DoctorProfileState>(
      listener: (context ,state){},
      builder: (context, state) => _buildFormField(state),
    );
  }

  FormField<String> _buildFormField(DoctorProfileState  state) {
    return FormField(
      validator: (_) =>
          DoctorProfileValidator().validateWorkingHours(state.availableFromTime),
      builder: (field) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          WorkHoursSelector(
            stateValues: state,
          ),
          if (field.hasError) ValidationMessage(field.errorText!),
        ],
      ),
    );
  }
}
