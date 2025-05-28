import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/core/constants/themes/app_text_styles.dart';
import 'package:flutter_task/features/appointments/presentation/controller/cubit/appointment_cubit.dart';
import 'package:flutter_task/features/appointments/presentation/widgets/select_date_widget.dart';
import 'package:flutter_task/features/appointments/presentation/widgets/select_time_widget.dart';

import '../../../doctor_list/data/models/doctor_list_model.dart';

class SelectDateAndTime extends StatefulWidget {
  final DoctorListModel doctor;

  const SelectDateAndTime({super.key, required this.doctor});

  @override
  State<SelectDateAndTime> createState() => _SelectDateAndTimeState();
}

class _SelectDateAndTimeState extends State<SelectDateAndTime> {
  @override
  void initState() {
    super.initState();
    context.read<AppointmentCubit>().deleteData();
    context.read<AppointmentCubit>().getAvailableDoctorTimeSlots(
        selectedDate: DateTime.now(), doctor: widget.doctor);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 5,
      children: [
        Text(
          'Select Date',
          style: textTheme.mediumBlackBold,
          textAlign: TextAlign.start,
        ),

        SelectDateWidget(doctor: widget.doctor),

        const SelectTimeWidget(),
      ],
    );
  }
}
