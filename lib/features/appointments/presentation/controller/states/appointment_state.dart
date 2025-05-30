import '../../../../../core/enum/appointment_availability_status.dart';
import '../../../../../core/enum/lazy_request_state.dart';
import '../../../../../core/enum/request_state.dart';
import '../../../data/models/client_appointments_model.dart';
import '../../../data/models/doctor_appointment_model.dart';

class AppointmentState {
  final List<DoctorAppointmentModel> doctorAppointmentModel;
  final RequestState doctorAppointmentState;
  final String doctorAppointmentError;

//New
  final AppointmentAvailabilityStatus appointmentAvailabilityStatus;
  final List<String> reservedTimeSlots;
  final RequestState reservedTimeSlotsState;
  final String reservedTimeSlotsError;

// new
  final List<String> availableDoctorTimeSlots;

  final String? selectedTimeSlot;

  final LazyRequestState bookAppointmentState;
  final String bookAppointmentError;

  final List<ClientAppointmentsModel> getClientAppointmentsList;
  final RequestState getClientAppointmentsListState;
  final String getClientAppointmentsListError;

  const AppointmentState({
    this.doctorAppointmentModel = const [],
    this.doctorAppointmentState = RequestState.loading,
    this.doctorAppointmentError = '',
    this.appointmentAvailabilityStatus = AppointmentAvailabilityStatus.available,
    this.reservedTimeSlots = const [],
    this.reservedTimeSlotsState = RequestState.loading,
    this.reservedTimeSlotsError = '',
    this.availableDoctorTimeSlots = const [],
    this.selectedTimeSlot,
    this.bookAppointmentState = LazyRequestState.lazy,
    this.bookAppointmentError = '',
    this.getClientAppointmentsList = const [],
    this.getClientAppointmentsListState = RequestState.loading,
    this.getClientAppointmentsListError = '',
  });

  AppointmentState copyWith({
    List<DoctorAppointmentModel>? doctorAppointmentModel,
    RequestState? doctorAppointmentState,
    String? doctorAppointmentError,
    AppointmentAvailabilityStatus? appointmentAvailabilityStatus,
    List<String>? reservedTimeSlots,
    RequestState? reservedTimeSlotsState,
    String? reservedTimeSlotsError,
    List<String>? availableDoctorTimeSlots,
    String? selectedTimeSlot,
    LazyRequestState? bookAppointmentState,
    String? bookAppointmentError,
    List<ClientAppointmentsModel>? getClientAppointmentsList,
    RequestState? getClientAppointmentsListState,
    String? getClientAppointmentsListError,
  }) {
    return AppointmentState(
      doctorAppointmentModel:
          doctorAppointmentModel ?? this.doctorAppointmentModel,
      doctorAppointmentState:
          doctorAppointmentState ?? this.doctorAppointmentState,
      doctorAppointmentError:
          doctorAppointmentError ?? this.doctorAppointmentError,
      appointmentAvailabilityStatus:
          appointmentAvailabilityStatus ?? this.appointmentAvailabilityStatus,
      reservedTimeSlots: reservedTimeSlots ?? this.reservedTimeSlots,
      reservedTimeSlotsState:
          reservedTimeSlotsState ?? this.reservedTimeSlotsState,
      reservedTimeSlotsError:
          reservedTimeSlotsError ?? this.reservedTimeSlotsError,
      availableDoctorTimeSlots:
          availableDoctorTimeSlots ?? this.availableDoctorTimeSlots,
      selectedTimeSlot: selectedTimeSlot ?? this.selectedTimeSlot,
      bookAppointmentState: bookAppointmentState ?? this.bookAppointmentState,
      bookAppointmentError: bookAppointmentError ?? this.bookAppointmentError,
      getClientAppointmentsList:
          getClientAppointmentsList ?? this.getClientAppointmentsList,
      getClientAppointmentsListState:
          getClientAppointmentsListState ?? this.getClientAppointmentsListState,
      getClientAppointmentsListError:
          getClientAppointmentsListError ?? this.getClientAppointmentsListError,
    );
  }

  @override
  List<Object?> get props => [
        doctorAppointmentModel,
        doctorAppointmentState,
        doctorAppointmentError,
        appointmentAvailabilityStatus,
        reservedTimeSlots,
        reservedTimeSlotsState,
        reservedTimeSlotsError,
        availableDoctorTimeSlots,
        selectedTimeSlot,
        bookAppointmentState,
        bookAppointmentError,
        getClientAppointmentsList,
        getClientAppointmentsListState,
        getClientAppointmentsListError
      ];
}
