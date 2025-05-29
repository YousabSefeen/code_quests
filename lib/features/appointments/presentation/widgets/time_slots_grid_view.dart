import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_task/core/enum/request_state.dart';
import 'package:flutter_task/features/appointments/presentation/controller/cubit/appointment_cubit.dart';
import 'package:flutter_task/features/appointments/presentation/controller/states/appointment_state.dart';

import '../../../../core/constants/common_widgets/custom_error_widget.dart';
import '../../../../core/constants/common_widgets/custom_shimmer.dart';
import 'available_doctor_time_slots_grid.dart';

class TimeSlotsGridView extends StatelessWidget {
  const TimeSlotsGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AppointmentCubit, AppointmentState,
            Tuple2<RequestState, String>>(
        selector: (state) =>
            Tuple2(state.reservedTimeSlotsState, state.reservedTimeSlotsError),
        builder: (context, values) {
          switch (values.value1) {
            case RequestState.loading:
              return CustomShimmer(
                height: 100.h,
                width: double.infinity,
              );
            case RequestState.loaded:
              return const AvailableDoctorTimeSlotsGrid();
            case RequestState.error:
              return CustomErrorWidget(
                errorMessage: values.value2,
              );
          }
        });
  }
}
