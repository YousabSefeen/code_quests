import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/core/constants/themes/app_text_styles.dart';
import 'package:flutter_task/features/appointments/presentation/widgets/time_slot_item.dart';

import '../../../../core/constants/themes/app_colors.dart';
import '../controller/cubit/appointment_cubit.dart';
import '../controller/states/appointment_state.dart';
import 'no_appointments_available_widget.dart';

class AvailableDoctorTimeSlotsGrid extends StatelessWidget {
  const AvailableDoctorTimeSlotsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AppointmentCubit, AppointmentState,
        Tuple2<String?, List<String>>>(
      selector: (state) => Tuple2(
        state.selectedTimeSlot,
        state.availableDoctorTimeSlots,
      ),
      builder: (context, timeSlotsData) =>
          _buildContent(context, timeSlotsData),
    );
  }

  Widget _buildContent(
      BuildContext context, Tuple2<String?, List<String>> timeSlotsData) {
    if (timeSlotsData.value2.isEmpty) {
      return const NoAppointmentsAvailableWidget();
    } else {
      return _buildTimeSlotsGrid(context, timeSlotsData);
    }
  }

  Widget _buildTimeSlotsGrid(
      BuildContext context, Tuple2<String?, List<String>> timeSlotsData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 5),
        GestureDetector(
            onTap: (){
         context.read<AppointmentCubit>().printData();
            },
            child: _buildTitle(context)),
        const SizedBox(height: 20),
        _buildTimeSlotsGridView(context, timeSlotsData),
      ],
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Text(
      'Select Time',
      style: Theme.of(context).textTheme.mediumBlackBold,
      textAlign: TextAlign.start,
    );
  }

  Widget _buildTimeSlotsGridView(
      BuildContext context, Tuple2<String?, List<String>> timeSlotsData) {
    final gridHeight = _calculateGridHeight(timeSlotsData.value2.length);

    return SizedBox(
      height: gridHeight,
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: _gridContainerDecoration(),
        child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.only(right: 10),
          gridDelegate: _gridDelegate(),
          itemCount: timeSlotsData.value2.length,
          itemBuilder: (context, index) {
            return _buildTimeSlotItem(
              context:context,
            time:   timeSlotsData.value2[index],
             isSelected:  timeSlotsData.value1 == timeSlotsData.value2[index],
            );
          },
        ),
      ),
    );
  }

  double _calculateGridHeight(int itemCount) {
    const crossAxisCount = 4;
    const itemHeight = 47;
    const spacing = 8;
    const edgesPadding = 10;

    final rows = (itemCount / crossAxisCount).ceil();
    return (rows * (itemHeight + spacing) + edgesPadding).toDouble();
  }

  BoxDecoration _gridContainerDecoration() => BoxDecoration(
        color: AppColors.customWhite,
        borderRadius: BorderRadius.circular(12),
      );

  SliverGridDelegate _gridDelegate() =>
      const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisExtent: 47,
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
      );

  Widget _buildTimeSlotItem(
          {required BuildContext context,required String time,required bool isSelected}) =>
      TimeSlotItem(
        time: time,
        isSelected: isSelected,
        onTap: () => context.read<AppointmentCubit>().updateSelectedTimeSlot(time),
      );
}