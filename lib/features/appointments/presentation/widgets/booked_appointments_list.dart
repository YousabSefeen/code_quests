import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/features/appointments/presentation/controller/cubit/appointment_cubit.dart';

import '../../data/models/client_appointments_model.dart';
import 'appointment_card.dart';

class BookedAppointmentsList extends StatelessWidget {
  final List<ClientAppointmentsModel> appointmentsList;

  const BookedAppointmentsList({super.key, required this.appointmentsList});

  @override
  Widget build(BuildContext context) {

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      itemCount: appointmentsList.length,
      itemBuilder: (context, index) {
        return AppointmentCard(appointment: appointmentsList[index]);
      },
    );
  }
}
