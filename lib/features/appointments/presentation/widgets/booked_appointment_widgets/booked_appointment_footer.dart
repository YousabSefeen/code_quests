import 'package:flutter/material.dart';
import 'package:flutter_task/core/constants/themes/app_text_styles.dart';
import 'package:flutter_task/features/appointments/presentation/widgets/booked_appointment_widgets/reschedule_button.dart';
import 'package:flutter_task/features/shared/models/doctor_schedule_model.dart';

import '../../../data/models/client_appointments_model.dart';
import '../icon_with_text.dart';
import 'cancel_button.dart';

class BookedAppointmentFooter extends StatelessWidget {
  final ClientAppointmentsModel appointment;

  const BookedAppointmentFooter({super.key, required this.appointment});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Column(
        spacing: 5,
        children: [
          _buildDoctorInfoSection(context),
          _buildActionButtonsSection(appointment),
        ],
      ),
    );
  }

  Row _buildDoctorInfoSection(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildDateInfo(context),
          _buildTimeInfo(context),
          _buildStatusInfo(context),
        ],
      );

  Widget _buildDateInfo(BuildContext context) => IconWithText(
      icon: Icons.calendar_month,
      text: appointment.appointmentDate,
      textStyle: Theme.of(context).textTheme.smallWhiteRegular,
    );

  Widget _buildTimeInfo(BuildContext context) => IconWithText(
      icon: Icons.alarm,
      text: appointment.appointmentTime,
      textStyle: Theme.of(context).textTheme.smallWhiteRegular,
    );

  Widget _buildStatusInfo(BuildContext context) => IconWithText(
      icon: Icons.circle_rounded,
      text: appointment.appointmentStatus,
      textStyle: Theme.of(context).textTheme.smallWhiteRegular,
    );

  Widget _buildActionButtonsSection(ClientAppointmentsModel appointment) =>
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 3),
        child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
            const CancelButton(),
            RescheduleButton(
              doctorSchedule: DoctorScheduleModel(
                doctorId: appointment.doctorId,
                doctorAvailability: appointment.doctorModel.doctorAvailability,
              ),
            ),
          ],
      ),
    );
}
