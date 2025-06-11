import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/core/constants/app_strings/app_strings.dart';
import 'package:flutter_task/features/appointments/presentation/controller/cubit/appointment_cubit.dart';

import '../../../../core/constants/common_widgets/content_unavailable_widget.dart';
import '../../../../core/enum/appointment_status.dart';
import 'appointment_card.dart';

class UpcomingAppointmentsList extends StatelessWidget {
  const UpcomingAppointmentsList({super.key});

  @override
  Widget build(BuildContext context) {
    final upcomingAppointments =
        context.read<AppointmentCubit>().upcomingAppointments;

    return upcomingAppointments!.isEmpty
        ? const ContentUnavailableWidget(
            description: AppStrings.emptyUpcomingAppointmentsMessage,
          )
        : ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
            itemCount: upcomingAppointments.length,
            itemBuilder: (context, index) => AppointmentCard(
              appointmentStatus: AppointmentStatus.confirmed,
              appointment: upcomingAppointments[index],
            ),
          );
  }
}
