import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/themes/app_colors.dart';
import '../../../doctor_list/data/models/doctor_list_model.dart';
import '../controller/cubit/appointment_cubit.dart';

class SelectDateWidget extends StatelessWidget {
  final DoctorListModel doctor;

  const SelectDateWidget({
    super.key,
    required this.doctor,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final activeTextStyle = textTheme.labelMedium;

    final inactiveDayStyle = activeTextStyle!.copyWith(color: Colors.black);
    return Container(
      margin: const EdgeInsets.only(top: 8, bottom: 17, right: 8),
      decoration: BoxDecoration(
          color: AppColors.customWhite,
          borderRadius: BorderRadius.circular(10)),
      child: EasyDateTimeLine(
        headerProps: EasyHeaderProps(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          selectedDateStyle:
              activeTextStyle.copyWith(fontSize: 14.sp, color: Colors.black),
          monthStyle:
              activeTextStyle.copyWith(fontSize: 14.sp, color: Colors.black),
          monthPickerType: MonthPickerType.switcher,
        ),
        initialDate: DateTime.now(),
        onDateChange: (selectedDate) =>
            context.read<AppointmentCubit>().getAvailableDoctorTimeSlots(
                  selectedDate: selectedDate,
                  doctor: doctor,
                ),
        activeColor: AppColors.softBlue,
        dayProps: EasyDayProps(
          height: 70,
          width: 40,
          activeDayStyle: DayStyle(
            borderRadius: 10.r,
            dayNumStyle: activeTextStyle,
            dayStrStyle: activeTextStyle,
            monthStrStyle: activeTextStyle,
          ),
          inactiveDayStyle: DayStyle(
            borderRadius: 10.r,
            dayNumStyle: inactiveDayStyle,
            dayStrStyle: inactiveDayStyle,
            monthStrStyle: inactiveDayStyle,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(10.r),
            ),
          ),
          todayHighlightStyle: TodayHighlightStyle.withBackground,
          todayStyle: DayStyle(
            borderRadius: 10.r,
            dayNumStyle: inactiveDayStyle,
            dayStrStyle: inactiveDayStyle,
            monthStrStyle: inactiveDayStyle,
          ),
        ),
        timeLineProps: const EasyTimeLineProps(
          backgroundColor: Colors.white,
          vPadding: 3,
        ),
      ),
    );
  }
}
