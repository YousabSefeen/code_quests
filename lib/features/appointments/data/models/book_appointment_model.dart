

import '../../../../core/enum/lazy_request_state.dart';

class BookAppointmentModel {
  final String? selectedTimeSlot;

  final LazyRequestState bookAppointmentState;
  final String bookAppointmentError;

  BookAppointmentModel({
    required this.selectedTimeSlot,
    required this.bookAppointmentState,
    required this.bookAppointmentError,
  });
}
