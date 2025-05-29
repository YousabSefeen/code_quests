import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_task/core/constants/common_widgets/custom_error_widget.dart';
import 'package:flutter_task/core/constants/common_widgets/custom_shimmer.dart';
import 'package:flutter_task/core/enum/request_state.dart';

import '../controller/cubit/appointment_cubit.dart';
import '../controller/states/appointment_state.dart';
import 'available_doctor_time_slots_grid.dart';
import 'doctor_not_available_message.dart';

class SelectTimeWidget extends StatelessWidget {
  const SelectTimeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AppointmentCubit, AppointmentState,
        DoctorAvailabilityStatus>(
      selector: (state) => DoctorAvailabilityStatus(
        isSelectedDateBeforeToday: state.isSelectedDateBeforeToday,
        requestState: state.reservedTimeSlotsState,
        reservedTimeSlotsError: state.reservedTimeSlotsError,
        isAvailable: state.isDoctorAvailable,
      ),
      builder: (context, status) {
        if (status.isSelectedDateBeforeToday) {
          return const DoctorNotAvailableMessage(
            isSelectedDateBeforeToday: true,
          );
        } else if (status.isAvailable) {
          return _buildTimeSlotsContent(
            status.requestState,
            status.reservedTimeSlotsError,
          );
        } else {
          return const DoctorNotAvailableMessage(
            isSelectedDateBeforeToday: false,
          );
        }
      },
    );
  }

  Widget _buildTimeSlotsContent(
      RequestState requestState, String reservedTimeSlotsError) {
    switch (requestState) {
      case RequestState.loading:
        return _buildLoadingShimmer();
      case RequestState.loaded:
        return const AvailableDoctorTimeSlotsGrid();
      case RequestState.error:
        return _buildErrorWidget(reservedTimeSlotsError);
    }
  }

  Widget _buildLoadingShimmer() => CustomShimmer(
        height: 100.h,
        width: double.infinity,
      );

  Widget _buildErrorWidget(String reservedTimeSlotsError) => CustomErrorWidget(
        errorMessage: reservedTimeSlotsError,
      );
}

class DoctorAvailabilityStatus {
  final bool isSelectedDateBeforeToday;
  final bool isAvailable;
  final RequestState requestState;
  final String reservedTimeSlotsError;

  DoctorAvailabilityStatus({
    required this.isSelectedDateBeforeToday,
    required this.requestState,
    required this.reservedTimeSlotsError,
    required this.isAvailable,
  });
}