import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_task/core/constants/themes/app_colors.dart';
import 'package:flutter_task/features/appointments/presentation/controller/cubit/appointment_cubit.dart';
import 'package:flutter_task/features/appointments/presentation/widgets/available_doctor_time_slots_grid.dart';

import '../../../doctor_list/data/models/doctor_list_model.dart';
import '../controller/states/appointment_state.dart';

class CustomDateTimeLine extends StatelessWidget {
  final DoctorListModel doctor;

  const CustomDateTimeLine({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final activeTextStyle = textTheme.labelMedium;

    final inactiveDayStyle = activeTextStyle!.copyWith(color: Colors.black);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10,
      children: [


        Text(
          'Available Time',
          style: textTheme.headlineMedium,
          textAlign: TextAlign.start,
        ),
        Container(
          margin: EdgeInsets.only(right: 8),
          decoration: BoxDecoration(
            color: AppColors.softBlue,
            borderRadius: BorderRadius.circular(10)
          ),
          child: EasyDateTimeLine(
            headerProps: EasyHeaderProps(
              selectedDateStyle: activeTextStyle.copyWith(fontSize: 15.sp),
              monthStyle: activeTextStyle.copyWith(fontSize: 15.sp),
              monthPickerType: MonthPickerType.switcher,
            ),
            initialDate: DateTime.now(),
            onDateChange: (selectedDate) {

                context.read<AppointmentCubit>().getAvailableDoctorTimeSlots(
                      selectedDate: selectedDate,
                      doctor: doctor,
                    );
            },
            activeColor: AppColors.softBlue,
            dayProps: EasyDayProps(
              height: 70,
              width: 50,
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
        ),
        BlocSelector<AppointmentCubit, AppointmentState, bool>(
          selector: (state) => state.isDoctorAvailable,
          builder: (context, isDoctorAvailable) =>
          isDoctorAvailable?     const AvailableDoctorTimeSlotsGrid() : Text('Doctor Not available for this day',style: TextStyle(
            fontSize: 20,
            color: Colors.red,
          ),),
        ),
      ],
    );
  }
}
