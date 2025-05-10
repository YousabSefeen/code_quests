import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_task/core/constants/themes/app_colors.dart';
import 'package:intl/intl.dart';

import '../../../../core/utils/date_time_formatter.dart';
import '../../../doctor_list/data/models/doctor_list_model.dart';

class CustomDateTimeLine extends StatelessWidget {
  final DoctorListModel doctor;

  const CustomDateTimeLine({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final activeTextStyle = textTheme.labelMedium;

    final inactiveDayStyle = activeTextStyle!.copyWith(color: Colors.black);

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
              onDateChange: (selectedDateTime) {
                final selectedDayName =
                DateTimeFormatter.convertDateToNameDay(date: selectedDateTime);

                final isDoctorAvailable =
                doctor.doctorModel.workingDays.contains(selectedDayName);

                print('📅 Doctor available on $selectedDayName: $isDoctorAvailable');
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

          ElevatedButton(onPressed: (){



                 final DateFormat format = DateFormat('hh:mm a');
                   DateTime from = DateFormat('hh:mm a').parse(doctor.doctorModel.availableFrom!);
                 final DateTime to = DateFormat('hh:mm a').parse(doctor.doctorModel.availableTo!);


                 List<String> slots = [];
                 while (from.isBefore(to)) {
                   slots.add(format.format(from));
                   from = from.add(const Duration(hours: 1));
                 }
                     print('slots  $slots');



                 //*********************************************
                 List<String> bookedTimes =   ['05:00 PM', '07:00 PM'];



                 final availableSlots = slots.where((slot) => !bookedTimes.contains(slot)).toList();



                      print('availableSlots $availableSlots');
          }, child: Text('Tester')),
          ElevatedButton(
              onPressed: () async{

            final  appointmentsSnapshot=   await FirebaseFirestore.instance
                    .collection('appointments')
                    .where('doctorId', isEqualTo: doctor.doctorId)
                    .where('date', isEqualTo: '01/01/2000')
                    .get();

                List<String> bookedTimes = appointmentsSnapshot.docs.map((doc) => doc['time'] as String).toList();
                print('bookedTimes  $bookedTimes');// TODO  [05:00 PM, 07:00 PM]


          //  final allSlots = generateSlots(from, to, Duration(minutes: 30));
              //  context.read<AppointmentCubit>().getDoctorAppointments(doctorId: doctor.doctorId);

                //  الدالة دي هتجيبي قائمة المواعيد ال بخصوص هذا الدكتور ومن خلالها المفروض اعمل فورلوب علي  هذه القائمة وبعد كدة هجيب اول جميع المواعيد التي تتطابق مع تلك التاريخ ومن ثم تقوم لي برجاع
              },
              child: Text('data'),
          ),



        ],
      ),
    );
  }
  List<String> generateSlots(DateTime from, DateTime to, Duration step) {


    final format = DateFormat.jm();
    List<String> slots = [];
    while (from.isBefore(to)) {
      slots.add(format.format(from));
      from = from.add(step);
    }
    return slots;
  }
}
