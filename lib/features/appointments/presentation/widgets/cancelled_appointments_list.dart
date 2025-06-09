import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/core/constants/common_widgets/content_unavailable_widget.dart';

import '../../../../core/constants/app_strings/app_strings.dart';
import '../controller/cubit/appointment_cubit.dart';
import 'appointment_card.dart';

class CancelledAppointmentsList extends StatelessWidget {
  const CancelledAppointmentsList({super.key});

  @override
  Widget build(BuildContext context) {
    final cancelledAppointments =
        context.read<AppointmentCubit>().cancelledAppointments;
    return cancelledAppointments!.isEmpty
        ? const ContentUnavailableWidget(
            description: AppStrings.emptyCancelledAppointmentsMessage,
          )
        : ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
            itemCount: cancelledAppointments.length,
            itemBuilder: (context, index) =>
                AppointmentCard(appointment: cancelledAppointments[index]),
          );
  }
}
