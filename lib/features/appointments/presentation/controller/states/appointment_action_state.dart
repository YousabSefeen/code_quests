

import '../../../../../core/enum/lazy_request_state.dart';

class AppointmentActionState {
  final String? selectedTimeSlot;

  final LazyRequestState actionState;
  final String actionError;

  AppointmentActionState({
    required this.selectedTimeSlot,
    required this.actionState,
    required this.actionError,
  });
}
