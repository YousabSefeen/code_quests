import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../controller/cubit/appointment_cubit.dart';
import '../controller/states/appointment_state.dart';
import 'available_doctor_time_slots_grid.dart';
import 'doctor_not_available_message.dart';

class SelectTimeWidget extends StatelessWidget {
  const SelectTimeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AppointmentCubit, AppointmentState, bool>(
      selector: (state) => state.isDoctorAvailable,
      builder: (context, isDoctorAvailable) => isDoctorAvailable
          ? const AvailableDoctorTimeSlotsGrid()
          : const DoctorNotAvailableMessage(),
    );
  }
}
