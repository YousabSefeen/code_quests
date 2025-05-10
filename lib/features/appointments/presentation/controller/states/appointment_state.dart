import 'package:equatable/equatable.dart';

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
  const AppointmentState({
    this.doctorAppointmentModel = const [],
    this.doctorAppointmentState = RequestState.loading,
    this.doctorAppointmentError = '',
    this.reservedTimeSlots = const [],
    this.reservedTimeSlotsState = RequestState.loading,
    this.reservedTimeSlotsError = '',
    this.availableDoctorTimeSlots = const [],
  });

  AppointmentState copyWith({
    List<DoctorAppointmentModel>? doctorAppointmentModel,
    RequestState? doctorAppointmentState,
    String? doctorAppointmentError,
    List<String>? reservedTimeSlots,
    RequestState? reservedTimeSlotsState,
    String? reservedTimeSlotsError,
    List<String>? availableDoctorTimeSlots,
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
    );
  }

  @override
  List<Object> get props => [
        doctorAppointmentModel,
        doctorAppointmentState,
        doctorAppointmentError,
        reservedTimeSlots,
        reservedTimeSlotsState,
        reservedTimeSlotsError,
        availableDoctorTimeSlots,
      ];
}
