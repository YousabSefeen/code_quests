import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
    as picker;
import 'package:intl/intl.dart';

import '../../../../core/constants/themes/app_colors.dart';
import '../../../../core/utils/date_time_formatter.dart';
import '../controller/cubit/doctor_profile_cubit.dart';
import '../controller/states/doctor_profile_state.dart';
import 'doctor_info_field.dart';

class DoctorAvailabilityTimeFields extends StatelessWidget {
  const DoctorAvailabilityTimeFields({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 7,
      children: [
        Expanded(
          child: BlocSelector<DoctorProfileCubit, DoctorProfileState, String?>(
            selector: (state) => state.availableFromTime,
            builder: (context, startTime) => DoctorInfoField(
              label: 'Available From',
              hintText: startTime ?? 'Select Time',
              suffixIcon: IconButton(
                icon: const Icon(Icons.access_alarm_outlined),
                onPressed: () =>
                    _openTimePicker(context: context, isStartTime: true),
              ),
            ),
          ),
        ),
        Expanded(
          child: BlocSelector<DoctorProfileCubit, DoctorProfileState, String?>(
            selector: (state) => state.availableToTime,
            builder: (context, endTime) => DoctorInfoField(
              label: 'Available To',
              hintText: endTime ?? 'Select Time',
              suffixIcon: IconButton(
                icon: const Icon(Icons.access_alarm_outlined),
                onPressed: () =>
                    _openTimePicker(context: context, isStartTime: false),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _openTimePicker(
      {required BuildContext context, required bool isStartTime}) {
    String time = DateFormat('hh:mm a').format(DateTime.now()).toString();
    final headlineSmall = Theme.of(context).textTheme.headlineSmall;

    picker.DatePicker.showTime12hPicker(
      context,
      theme: picker.DatePickerTheme(
        containerHeight: MediaQuery.sizeOf(context).height * 0.24,
        headerColor: AppColors.darkBlue,
        backgroundColor: AppColors.white,
        itemStyle: headlineSmall!.copyWith(color: Colors.black),
        doneStyle: headlineSmall,
        cancelStyle: headlineSmall,
      ),
      showTitleActions: true,
      onConfirm: (newTime) {
        context.read<DoctorProfileCubit>().updateAvailableTime(
              DateTimeFormatter.timeString(newTime), isStartTime: isStartTime,

            );
      },
      currentTime: DateFormat('hh:mm a').parse(time),
    );
  }
}
