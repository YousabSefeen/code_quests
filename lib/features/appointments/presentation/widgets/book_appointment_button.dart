import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_task/core/constants/app_alerts/app_alerts.dart';
import 'package:flutter_task/core/constants/app_routes/app_router.dart';
import 'package:flutter_task/core/constants/app_routes/app_router_names.dart';
import 'package:flutter_task/core/constants/themes/app_colors.dart';
import 'package:flutter_task/features/appointments/presentation/controller/cubit/appointment_cubit.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/app_alerts/no_internet_dialog.dart';
import '../../../../core/constants/app_strings/app_strings.dart';
import '../../../../core/enum/lazy_request_state.dart';
import '../../data/models/book_appointment_model.dart';
import '../controller/states/appointment_state.dart';

class BookAppointmentButton extends StatelessWidget {
  final String doctorId;

  const BookAppointmentButton({super.key, required this.doctorId});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12.0),
      width: double.infinity,
      height: 50,
      child: BlocSelector<AppointmentCubit, AppointmentState,
          BookAppointmentModel>(
        selector: (state) => BookAppointmentModel(
          selectedTimeSlot: state.selectedTimeSlot,
          bookAppointmentState: state.bookAppointmentState,
          bookAppointmentError: state.bookAppointmentError,
        ),
        builder: (context, appointmentData) {
          _handleAppointmentResponse(context, appointmentData);
          return _buildBookingButton(context, appointmentData);
        },
      ),
    );
  }

  /// Builds the main booking button widget
  /// Handles disabled state when no time slot is selected
  /// Shows loading indicator when appointment is being booked
  Widget _buildBookingButton(
      BuildContext context, BookAppointmentModel appointmentData) {
    final isButtonDisabled = appointmentData.selectedTimeSlot == '';
    final isLoading =
        appointmentData.bookAppointmentState == LazyRequestState.loading;

    return ElevatedButton(
      onPressed: isButtonDisabled ? null : () => _bookAppointment(context),
      style: _getButtonStyle(isButtonDisabled),
      child: isLoading
          ? const CircularProgressIndicator(color: Colors.white)
          : _buildButtonText(),
    );
  }

  /// Initiates the appointment booking process
  void _bookAppointment(BuildContext context) {
    context.read<AppointmentCubit>().bookAppointment(doctorId: doctorId);
  }

  /// Returns the appropriate button style based on disabled state
  ButtonStyle _getButtonStyle(bool isDisabled) {
    return ButtonStyle(
      backgroundColor: WidgetStatePropertyAll(
          isDisabled ? Colors.grey.shade300 : AppColors.softBlue),
      foregroundColor:
          WidgetStatePropertyAll(isDisabled ? Colors.black : Colors.white),
    );
  }

  /// Builds the text widget for the button with consistent styling
  Widget _buildButtonText() {
    return Text(
      'Book Appointment',
      style: GoogleFonts.raleway(
        fontSize: 19.sp,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  /// Handles different states of appointment booking process
  /// Routes to appropriate handlers based on current state
  void _handleAppointmentResponse(
      BuildContext context, BookAppointmentModel appointmentData) {
    switch (appointmentData.bookAppointmentState) {
      case LazyRequestState.error:
        _handleBookingError(context, appointmentData.bookAppointmentError);
        break;
      case LazyRequestState.loaded:
        _handleBookingSuccess(context);
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
            context, AppStrings.kNoInternetBookingErrorMessage);
      }

      _resetBookingState(context);
    });
  }

  /// Handles successful booking completion
  /// Shows success dialog, navigates to doctor list after delay
  /// Clears current appointment data
  void _handleBookingSuccess(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showSuccessDialog(context);

      Future.delayed(const Duration(milliseconds: 700), () {
        if (!context.mounted) return;
        _navigateToDoctorList(context);
      });

      _resetBookingState(context);
    });
  }

  /// Displays success dialog after booking confirmation
  void _showSuccessDialog(BuildContext context) =>
      AppAlerts.showAppointmentSuccessDialog(
        context: context,
        message: AppStrings.successMessage,
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
  void _resetBookingState(BuildContext context) =>
      context.read<AppointmentCubit>().resetBookingState();
}