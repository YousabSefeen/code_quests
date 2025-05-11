import 'package:equatable/equatable.dart';
import 'package:flutter_task/features/appointments/data/models/book_appointment_model.dart';

import '../../../../../core/enum/lazy_request_state.dart';
import '../../../../../core/enum/request_state.dart';
import '../../../data/models/doctor_appointment_model.dart';

class AppointmentState extends Equatable {
  final List<DoctorAppointmentModel> doctorAppointmentModel;
  final RequestState doctorAppointmentState;
  final String doctorAppointmentError;

//New

  final List<String> reservedTimeSlots;
  final RequestState reservedTimeSlotsState;
  final String reservedTimeSlotsError;

// new
  final List<String> availableDoctorTimeSlots;

  final bool isDoctorAvailable;
  final String? selectedTimeByUser;



  final BookAppointmentModel? bookAppointmentModel;
  final LazyRequestState bookAppointmentState;
  final String bookAppointmentError;

  const AppointmentState({
    this.doctorAppointmentModel = const [],
    this.doctorAppointmentState = RequestState.loading,
    this.doctorAppointmentError = '',
    this.reservedTimeSlots = const [],
    this.reservedTimeSlotsState = RequestState.loading,
    this.reservedTimeSlotsError = '',
    this.availableDoctorTimeSlots = const [],
    this.isDoctorAvailable=true,
    this.selectedTimeByUser,
    this.bookAppointmentModel,
    this.bookAppointmentState = LazyRequestState.lazy,
    this.bookAppointmentError = '',
  });

  AppointmentState copyWith({
    List<DoctorAppointmentModel>? doctorAppointmentModel,
    RequestState? doctorAppointmentState,
    String? doctorAppointmentError,
    List<String>? reservedTimeSlots,
    RequestState? reservedTimeSlotsState,
    String? reservedTimeSlotsError,
    List<String>? availableDoctorTimeSlots,
    bool? isDoctorAvailable,
    String? selectedTimeByUser,
    BookAppointmentModel? bookAppointmentModel,
    LazyRequestState? bookAppointmentState,
    String? bookAppointmentError,
  }) {
    return AppointmentState(
      doctorAppointmentModel:
          doctorAppointmentModel ?? this.doctorAppointmentModel,
      doctorAppointmentState:
          doctorAppointmentState ?? this.doctorAppointmentState,
      doctorAppointmentError:
          doctorAppointmentError ?? this.doctorAppointmentError,
      reservedTimeSlots: reservedTimeSlots ?? this.reservedTimeSlots,
      reservedTimeSlotsState:
          reservedTimeSlotsState ?? this.reservedTimeSlotsState,
      reservedTimeSlotsError:
          reservedTimeSlotsError ?? this.reservedTimeSlotsError,
      availableDoctorTimeSlots:
          availableDoctorTimeSlots ?? this.availableDoctorTimeSlots,
        isDoctorAvailable:isDoctorAvailable?? this.isDoctorAvailable,
      selectedTimeByUser: selectedTimeByUser ?? this.selectedTimeByUser,
      bookAppointmentModel: bookAppointmentModel ?? this.bookAppointmentModel,
      bookAppointmentState: bookAppointmentState ?? this.bookAppointmentState,
      bookAppointmentError: bookAppointmentError ?? this.bookAppointmentError,
    );
  }

  @override
  List<Object?> get props => [
        doctorAppointmentModel,
        doctorAppointmentState,
        doctorAppointmentError,
        reservedTimeSlots,
        reservedTimeSlotsState,
        reservedTimeSlotsError,
        availableDoctorTimeSlots,isDoctorAvailable,
        selectedTimeByUser,
        bookAppointmentModel,
        bookAppointmentState,
        bookAppointmentError,
      ];
}
