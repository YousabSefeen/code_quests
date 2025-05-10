import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_task/core/constants/themes/app_colors.dart';
import 'package:flutter_task/core/utils/time_slot_helper.dart';
import 'package:flutter_task/features/appointments/presentation/controller/cubit/appointment_cubit.dart';
import 'package:flutter_task/features/appointments/presentation/widgets/available_doctor_time_slots_grid.dart';
import 'package:intl/intl.dart';

import '../../../doctor_list/data/models/doctor_list_model.dart';

class CustomDateTimeLine extends StatelessWidget {
  final DoctorListModel doctor;

  const CustomDateTimeLine({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.sizeOf(context).height;
    final textTheme = Theme.of(context).textTheme;

    final activeTextStyle = textTheme.labelMedium;

    final inactiveDayStyle = activeTextStyle!.copyWith(color: Colors.black);
    List<String> availableDoctorTimeSlots = [];
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10,
        children: [
          Text(
            'Working Days: ${doctor.doctorModel.workingDays}',
            style: textTheme.headlineMedium,
            textAlign: TextAlign.start,
          ),
          const SizedBox(height: 20),
          Text(
            'Available Time',
            style: textTheme.headlineMedium,
            textAlign: TextAlign.start,
          ),
          Container(
            decoration: BoxDecoration(
              color: AppColors.softBlue,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
            ),
            child: EasyDateTimeLine(
              headerProps: EasyHeaderProps(
                selectedDateStyle: activeTextStyle.copyWith(fontSize: 15.sp),
                monthStyle: activeTextStyle.copyWith(fontSize: 15.sp),
                monthPickerType: MonthPickerType.switcher,
              ),
              initialDate: DateTime.now(),
              onDateChange: (selectedDate) {
                final isDoctorAvailable = TimeSlotHelper.doesDoctorWorkOnDate(
                  selectedDate: selectedDate,
                  doctorWorkingDays: doctor.doctorModel.workingDays,
                );

                if (isDoctorAvailable) {
                  context.read<AppointmentCubit>().getAvailableDoctorTimeSlots(
                        selectedDate: selectedDate,
                        doctor: doctor,
                      );
                }
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
          const AvailableDoctorTimeSlotsGrid(),

          /*  BlocSelector<AppointmentCubit, AppointmentState, List<String>>(
            selector: (state) => state.reservedTimeSlots,
            builder: (context, reservedTimeSlots) => ElevatedButton(
              onPressed: () async {
                final allDoctorTimeSlots = generateHourlyTimeSlots(
                  startTime: doctor.doctorModel.availableFrom!,
                  endTime: doctor.doctorModel.availableTo!,
                );
                await context
                    .read<AppointmentCubit>()
                    .getReservedTimeSlotsForDoctorOnDate(
                    doctorId: doctor.doctorId, date: '01/01/2000');

                availableDoctorTimeSlots = filterAvailableTimeSlots(
                  totalTimeSlots: allDoctorTimeSlots,
                  reservedTimeSlots: reservedTimeSlots,
                );
                //[01:00 PM, 02:00 PM, 03:00 PM, 04:00 PM, 06:00 PM, 08:00 PM]
                print('availableDoctorTimeSlots $availableDoctorTimeSlots');
              },
              child: Text('reservedTimeSlots $availableDoctorTimeSlots'),
            ),



          ),*/
        ],
      ),
    );
  }

  List<String> generateHourlyTimeSlots({
    required String startTime,
    required String endTime,
  }) {
    final DateFormat timeFormatter = DateFormat('hh:mm a');
    DateTime currentTime = timeFormatter.parse(startTime);
    final DateTime endTimeParsed = timeFormatter.parse(endTime);

    List<String> hourlySlots = [];
    while (currentTime.isBefore(endTimeParsed)) {
      hourlySlots.add(timeFormatter.format(currentTime));
      currentTime = currentTime.add(const Duration(hours: 1));
    }

    return hourlySlots;
  }

  List<String> filterAvailableTimeSlots({
    required List<String> totalTimeSlots,
    required List<String> reservedTimeSlots,
  }) {
    return totalTimeSlots
        .where((slot) => !reservedTimeSlots.contains(slot))
        .toList();
  }
}
/*
  ElevatedButton(onPressed: (){
                 context.read<AppointmentCubit>().getDoctorAppointments(doctorId: doctor.doctorId);
               }, child: Text('getDoctorAppointments')),
               ElevatedButton(onPressed: ()async{

                 final allDoctorTimeSlots = generateHourlyTimeSlots(
                   startTime: doctor.doctorModel.availableFrom!,
                   endTime: doctor.doctorModel.availableTo!,
                 );

                 final appointmentsSnapshot = await FirebaseFirestore.instance
                     .collection('appointments')
                     .where('doctorId', isEqualTo: doctor.doctorId)
                     .where('date', isEqualTo: '01/01/2000')
                     .get();

                 final reservedTimeSlots = appointmentsSnapshot.docs
                     .map((doc) => doc['time'] as String)
                     .toList();



                 final availableDoctorTimeSlots = filterAvailableTimeSlots(
                   totalTimeSlots: allDoctorTimeSlots,
                   reservedTimeSlots: reservedTimeSlots,
                 );
                 print('availableDoctorTimeSlots  $availableDoctorTimeSlots');
              }, child: Text('fffffffffffffffffffffffffffffffff')),

          ElevatedButton(onPressed: (){
          //[05:00 PM, 07:00 PM]
            final allDoctorTimeSlots = generateHourlyTimeSlots(
              startTime: doctor.doctorModel.availableFrom!,
              endTime: doctor.doctorModel.availableTo!,
            );

        final cc=    context.read<AppointmentCubit>().getReservedTimeSlotsForDoctorOnDate(doctorId:doctor.doctorId ,date: '01/01/2000');

          }, child: Text('getReservedTimeSlotsForDoctorOnDate'))
 */