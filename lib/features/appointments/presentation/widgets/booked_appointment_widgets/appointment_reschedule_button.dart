import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_task/core/constants/app_alerts/app_alerts.dart';
import 'package:flutter_task/core/constants/app_strings/app_strings.dart';
import 'package:flutter_task/core/constants/themes/app_colors.dart';
import 'package:flutter_task/features/appointments/presentation/controller/cubit/appointment_cubit.dart';
import 'package:flutter_task/features/shared/models/doctor_schedule_model.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/constants/app_alerts/no_internet_dialog.dart';
import '../../../../../core/constants/app_routes/app_router.dart';
import '../../../../../core/enum/lazy_request_state.dart';
import '../../../data/models/client_appointments_model.dart';
import '../../controller/states/appointment_action_state.dart';
import '../../controller/states/appointment_state.dart';
import '../custom_widgets/adaptive_action_button.dart';
import '../doctor_appointment_booking_section.dart';

class AppointmentRescheduleButton extends StatelessWidget {
  final ClientAppointmentsModel appointment;

  const AppointmentRescheduleButton({super.key, required this.appointment});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
            backgroundColor: WidgetStatePropertyAll(AppColors.softBlue),
            overlayColor: const WidgetStatePropertyAll(Colors.white),
          ),
      onPressed: () => _showRescheduleBottomSheet(context),
      child: const Text(AppStrings.reschedule),
    );
  }

  void _showRescheduleBottomSheet(BuildContext context) =>
      AppAlerts.showCustomBottomSheet(
        context: context,
        title: AppStrings.editBookingAppointment,
        body: _buildRescheduleContent(),
      );

  Widget _buildRescheduleContent() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
        child: Column(
          spacing: 30,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildRescheduleTitle(),
            _buildDoctorBookingSection(),
            _buildRescheduleConfirmationButton(),
          ],
        ),
      );

  Widget _buildRescheduleTitle() => Text(
        'When would you like to come?',
        style: GoogleFonts.roboto(
          color: Colors.black,
          fontSize: 18.sp,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.5,
        ),
        textAlign: TextAlign.start,
      );

  Widget _buildDoctorBookingSection() => DoctorAppointmentBookingSection(
        doctorSchedule: DoctorScheduleModel(
          doctorId: appointment.doctorId,
          doctorAvailability: appointment.doctorModel.doctorAvailability,
        ),
      );

  Widget _buildRescheduleConfirmationButton() => RescheduleConfirmationButton(
        doctorId: appointment.doctorId,
        appointmentId: appointment.appointmentId,
      );
}

class RescheduleConfirmationButton extends StatelessWidget {
  final String doctorId;
  final String appointmentId;

  const RescheduleConfirmationButton(
      {super.key, required this.doctorId, required this.appointmentId});

  @override
  Widget build(BuildContext context) {

    return BlocSelector<AppointmentCubit, AppointmentState,
        AppointmentActionState>(
      selector: (state) => AppointmentActionState(
        selectedTimeSlot: state.selectedTimeSlot,
        actionState: state.rescheduleAppointmentState,
        actionError: state.rescheduleAppointmentError,
      ),
      builder: (context, appointmentData) {
        _handleAppointmentResponse(context, appointmentData);
        return _buildConfirmRescheduleButton(context, appointmentData);
      },
    );



  }
  Widget _buildConfirmRescheduleButton(
      BuildContext context, AppointmentActionState appointmentData) {
    final isButtonDisabled = appointmentData.selectedTimeSlot == '';
    final isLoading =
        appointmentData.actionState == LazyRequestState.loading;

    return AdaptiveActionButton(
      title: AppStrings.confirmReschedule,
      isButtonDisabled: isButtonDisabled,
      isLoading: isLoading,
      onPressed: () => _confirmReschedule(context),
    );
  }
  /// Initiates the appointment booking process
  void _confirmReschedule(BuildContext context) =>
      context.read<AppointmentCubit>().rescheduleAppointment(doctorId: doctorId, appointmentId: appointmentId);


  /// Handles different states of appointment booking process
  /// Routes to appropriate handlers based on current state
  void _handleAppointmentResponse(
      BuildContext context, AppointmentActionState appointmentData) {
    switch (appointmentData.actionState) {
      case LazyRequestState.error:
        _handleBookingError(context, appointmentData.actionError);
        break;
      case LazyRequestState.loaded:
        _handleAppointmentRescheduleSuccess(context);
        break;
      case LazyRequestState.loading:
      case LazyRequestState.lazy:
        break;
    }
  }

  /// Handles error state after failed booking attempt
  /// Shows appropriate error dialog based on error type
  /// Resets booking state after showing error
  void _handleBookingError(BuildContext context, String errorMessage) {
    Future.microtask(() {
      if (!context.mounted) return;

      if (errorMessage == AppStrings.noInternetConnection) {
        NoInternetDialog.showErrorModal(context: context);
      } else {
        AppAlerts.showErrorDialog(
            context, AppStrings.kNoInternetBookingErrorMessage,
        );
      }

      _resetRescheduleAppointmentState(context);
    });
  }

  /// Handles successful booking completion
  /// Shows success dialog, navigates to doctor list after delay
  /// Clears current appointment data
  void _handleAppointmentRescheduleSuccess(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {



        if (!context.mounted) return;
        _navigateToDoctorList(context);
        Future.delayed(const Duration(milliseconds: 500),() {
          if(!context.mounted) return;
          _showSuccessDialog(context);
        } );



      _resetRescheduleAppointmentState(context);
    });
  }

  /// Displays success dialog after booking confirmation
  void _showSuccessDialog(BuildContext context) =>
      AppAlerts.showAppointmentSuccessDialog(
        context: context,
        message: AppStrings.rescheduleSuccessMessage,
      );

  /// Navigates back to doctor list screen and removes all previous routes
  // void _navigateToDoctorList(BuildContext context) =>
  //     AppRouter.pushNamedAndRemoveUntil(
  //       context,
  //       AppRouterNames.doctorListView,
  //     );
  void _navigateToDoctorList(BuildContext context) =>
      AppRouter.pop(context);
  /// Resets booking state to initial values in cubit
  void _resetRescheduleAppointmentState(BuildContext context) =>
      context.read<AppointmentCubit>().resetRescheduleAppointmentState();

}
