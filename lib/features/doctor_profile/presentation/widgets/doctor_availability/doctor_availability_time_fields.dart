import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
    as picker;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_task/core/constants/app_strings/app_strings.dart';
import 'package:flutter_task/core/constants/themes/app_text_styles.dart';
import 'package:flutter_task/features/doctor_profile/presentation/widgets/doctor_availability/suffix_icon_button.dart';
import 'package:intl/intl.dart';

import '../../../../../core/constants/themes/app_colors.dart';
import '../../../../../core/utils/date_time_formatter.dart';
import '../../controller/cubit/doctor_profile_cubit.dart';
import '../../controller/states/doctor_profile_state.dart';
import '../doctor_info_field.dart';

class DoctorAvailabilityTimeFields extends StatelessWidget {
  const DoctorAvailabilityTimeFields({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 30,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: BlocSelector<DoctorProfileCubit, DoctorProfileState, String?>(
            selector: (state) => state.availableFromTime,
            builder: (context, startTime) => DoctorInfoField(
              label: AppStrings.availableFrom,
              readOnly: true,
              isTimeFieldNull: startTime==null,
              hintText: startTime ?? AppStrings.hintSelectTime,

              validator: (_) =>
              startTime==null ? AppStrings.requiredField : null,
              suffixIcon: SuffixIconButton(

                onPressed: () => _openTimePicker(
                  context: context,
                  isStartTime: true,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: BlocSelector<DoctorProfileCubit, DoctorProfileState, String?>(
            selector: (state) => state.availableToTime,
            builder: (context, endTime) => DoctorInfoField(
              label:  AppStrings.availableTo,
              readOnly: true,
               isTimeFieldNull: endTime==null,
              hintText: endTime ?? AppStrings.hintSelectTime,

              validator: (_) =>
              endTime==null ? AppStrings.requiredField : null,
              suffixIcon: SuffixIconButton(

                // onPressed: () =>
                //     _openTimePicker(context: context, isStartTime: false),

                onPressed: () => _showHourOnlyPicker(context, (selectedTime) {
                  context.read<DoctorProfileCubit>().updateAvailableTime(
                    selectedTime,
                    isStartTime: true,
                  );
                }),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _openTimePicker({
    required BuildContext context,
    required bool isStartTime,
  }) {
    String time = DateFormat('hh:mm a').format(DateTime.now()).toString();
    final mediumWhiteBold = Theme.of(context).textTheme.mediumWhiteBold;

    picker.DatePicker.showTime12hPicker(
      context,
      theme: picker.DatePickerTheme(

        containerHeight: MediaQuery.sizeOf(context).height * 0.27,
        headerColor: AppColors.softBlue,
        itemStyle: mediumWhiteBold.copyWith(color: Colors.black),
        doneStyle: mediumWhiteBold,
        cancelStyle: mediumWhiteBold,
      ),
      onConfirm: (newTime) {

        if (newTime.minute != 0) {
          // إظهار رسالة تنبيه
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Please select a full hour without minutes (example: 01:00 AM)'),
              duration: Duration(seconds: 2),
              backgroundColor: Colors.redAccent,
            ),
          );
          return;
        }else{

          context.read<DoctorProfileCubit>().updateAvailableTime(
            DateTimeFormatter.timeString(newTime),
            isStartTime: isStartTime,
          );

        }



      },
      currentTime: DateFormat('hh').parse(time),
    );
  }
  void _showHourOnlyPicker(BuildContext context, Function(String) onSelected) {
    final hours = List.generate(12, (index) {
      final hour = index + 1;
      return '${hour.toString().padLeft(2, '0')}:00 AM';
    }) +
        List.generate(12, (index) {
          final hour = index + 1;
          return '${hour.toString().padLeft(2, '0')}:00 PM';
        });

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return ListView.builder(
          itemCount: hours.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(hours[index]),
              onTap: () {
                Navigator.pop(context);
                onSelected(hours[index]);
              },
            );
          },
        );
      },
    );
  }
}
