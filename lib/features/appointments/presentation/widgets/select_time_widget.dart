import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_task/core/constants/common_widgets/custom_error_widget.dart';
import 'package:flutter_task/core/constants/common_widgets/custom_shimmer.dart';
import 'package:flutter_task/core/enum/request_state.dart';
import 'package:flutter_task/features/appointments/presentation/widgets/time_slots_grid_view.dart';

import '../../../../core/enum/appointment_availability_status.dart';
import '../controller/cubit/appointment_cubit.dart';
import '../controller/states/appointment_state.dart';
import 'available_doctor_time_slots_grid.dart';
import 'doctor_not_available_message.dart';

class SelectTimeWidget extends StatelessWidget {
  const SelectTimeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AppointmentCubit, AppointmentState,
        AppointmentAvailabilityStatus>(
      selector: (state) =>   state.appointmentAvailabilityStatus,

      builder: (context, status) {
        switch (status ) {
          case AppointmentAvailabilityStatus.available:
            return const TimeSlotsGridView();
          case AppointmentAvailabilityStatus.pastDate:
            return const DoctorNotAvailableMessage(
              appointmentAvailabilityStatus:
                  AppointmentAvailabilityStatus.pastDate,
            );
          case AppointmentAvailabilityStatus.doctorNotWorkingOnSelectedDate:
            return const DoctorNotAvailableMessage(
              appointmentAvailabilityStatus:
                  AppointmentAvailabilityStatus.doctorNotWorkingOnSelectedDate,
            );
        }
      },
    );
  }


}

