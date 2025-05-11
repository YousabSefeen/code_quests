import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_task/core/constants/themes/app_colors.dart';
import 'package:flutter_task/features/appointments/presentation/controller/cubit/appointment_cubit.dart';
import 'package:flutter_task/features/appointments/presentation/widgets/available_doctor_time_slots_grid.dart';
import 'package:flutter_task/features/appointments/presentation/widgets/doctor_not_available_message.dart';

import '../../../../core/utils/date_time_formatter.dart';
import '../../../doctor_list/data/models/doctor_list_model.dart';
import '../controller/states/appointment_state.dart';

class CustomDateTimeLine extends StatefulWidget {
  final DoctorListModel doctor;

  const CustomDateTimeLine({super.key, required this.doctor});

  @override
  State<CustomDateTimeLine> createState() => _CustomDateTimeLineState();
}

class _CustomDateTimeLineState extends State<CustomDateTimeLine> {

  @override
  void initState() {

    super.initState();
    context.read<AppointmentCubit>().deleteUserTimeSelected();
    context.read<AppointmentCubit>().getAvailableDoctorTimeSlots(selectedDate: DateTime.now(), doctor: widget.doctor);
  }
  @override
  void dispose() {
   // context.read<AppointmentCubit>().deleteUserTimeSelected();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final activeTextStyle = textTheme.labelMedium;

    final inactiveDayStyle = activeTextStyle!.copyWith(color: Colors.black);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [


        Text(
          'Select Date',
          style: textTheme.headlineMedium ,
          textAlign: TextAlign.start,
        ),

        Container(
          margin: const EdgeInsets.only(top: 8, bottom: 17 ,right: 8),
          decoration: BoxDecoration(
              color: AppColors.customWhite,
              borderRadius: BorderRadius.circular(10)),
          child: EasyDateTimeLine(
            headerProps: EasyHeaderProps(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              selectedDateStyle: activeTextStyle.copyWith(fontSize: 14.sp,color: Colors.black),
              monthStyle: activeTextStyle.copyWith(fontSize: 14.sp,color: Colors.black),
              monthPickerType: MonthPickerType.switcher,
            ),
            initialDate: DateTime.now(),
            onDateChange: (selectedDate) {


              final selectedDayName =
              DateTimeFormatter.convertSelectedDateToString( selectedDate);
              print('CustomDateTimeLine.build $selectedDayName');


              context.read<AppointmentCubit>().getAvailableDoctorTimeSlots(
                      selectedDate: selectedDate,
                      doctor: widget.doctor,
                    );
            },
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
        ),

        Text(
          'Select Time',
          style: textTheme.headlineMedium ,
          textAlign: TextAlign.start,
        ),
        const SizedBox(height: 5),
        BlocSelector<AppointmentCubit, AppointmentState, bool>(
          selector: (state) => state.isDoctorAvailable,
          builder: (context, isDoctorAvailable) => isDoctorAvailable
              ? const AvailableDoctorTimeSlotsGrid()
              : const DoctorNotAvailableMessage(),
        ),




      ],
    );
  }
}
