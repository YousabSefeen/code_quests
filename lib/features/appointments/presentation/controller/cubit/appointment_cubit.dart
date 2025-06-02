import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/core/constants/app_strings/app_strings.dart';

import '../../../../../core/app_settings/controller/cubit/app_settings_cubit.dart';
import '../../../../../core/enum/appointment_availability_status.dart';
import '../../../../../core/enum/internet_state.dart';
import '../../../../../core/enum/lazy_request_state.dart';
import '../../../../../core/enum/request_state.dart';
import '../../../../../core/utils/date_time_formatter.dart';
import '../../../../../core/utils/time_slot_helper.dart';
import '../../../../doctor_list/data/models/doctor_list_model.dart';
import '../../../../shared/models/availability_model.dart';
import '../../../data/repository/appointment_repository.dart';
import '../states/appointment_state.dart';

class AppointmentCubit extends Cubit<AppointmentState> {
  final AppSettingsCubit appSettingsCubit;
  final AppointmentRepository appointmentRepository;
  String? _selectedDateFormatted;

  AppointmentCubit({
    required this.appSettingsCubit,
    required this.appointmentRepository,
  }) : super(const AppointmentState());

  // Public APIs
  Future<void> fetchDoctorAppointments(String doctorId) async {
    final response =
        await appointmentRepository.fetchDoctorAppointments(doctorId: doctorId);
    response.fold(
      (failure) => _emitDoctorAppointmentsError(failure),
      (appointments) => emit(state.copyWith(
        doctorAppointmentState: RequestState.loaded,
        doctorAppointmentModel: appointments,
      )),
    );
  }

  Future<void> getAvailableDoctorTimeSlots({
    required DateTime selectedDate,
    required String doctorId,
    required DoctorAvailabilityModel doctorAvailability,
  }) async {
    _clearSelectedTimeSlot();
    final isAvailable = await _checkDoctorAvailability(
      selectedDate: selectedDate,
      workingDays: doctorAvailability.workingDays,
    );

    if (!isAvailable) return;



    _selectedDateFormatted =
        DateTimeFormatter.convertSelectedDateToString(selectedDate);

    final allTimeSlots = TimeSlotHelper.generateHourlyTimeSlots(
      startTime: doctorAvailability.availableFrom!,
      endTime:doctorAvailability.availableTo!,
    );

    await _loadReservedSlots( doctorId, _selectedDateFormatted!);

    final availableSlots = TimeSlotHelper.filterAvailableTimeSlots(
      totalTimeSlots: allTimeSlots,
      reservedTimeSlots: state.reservedTimeSlots,
    );

    emit(state.copyWith(availableDoctorTimeSlots: availableSlots));
  }

  void updateSelectedTimeSlot(String selectedSlot) {
    emit(state.copyWith(selectedTimeSlot: selectedSlot));
  }

  Future<void> bookAppointment({required String doctorId}) async {
    if (_isInternetDisconnected()) {
      _emitNoInternetForBooking();
      return;
    }

    emit(state.copyWith(bookAppointmentState: LazyRequestState.loading));

    final response = await appointmentRepository.bookAppointment(
      doctorId: doctorId,
      date: _selectedDateFormatted!,
      time: state.selectedTimeSlot!,
    );

    response.fold(
      (failure) => emit(state.copyWith(
        bookAppointmentState: LazyRequestState.error,
        bookAppointmentError: failure.toString(),
      )),
      (_) =>
          emit(state.copyWith(bookAppointmentState: LazyRequestState.loaded)),
    );
  }

  Future<void> fetchClientAppointmentsWithDoctorDetails() async {
    final response =
        await appointmentRepository.fetchClientAppointmentsWithDoctorDetails();
    response.fold(
      (failure) => emit(state.copyWith(
        getClientAppointmentsListState: RequestState.error,
        getClientAppointmentsListError: failure.toString(),
      )),
      (appointments) {
        print('AppointmentCubit.fetchClientAppointmentsWithDoctorDetails  ${appointments}');
        emit(state.copyWith(
        getClientAppointmentsList: appointments,
        getClientAppointmentsListState: RequestState.loaded,
      ));
      },
    );
  }



  void resetBookingState() => emit(state.copyWith(
        bookAppointmentState: LazyRequestState.lazy,
        bookAppointmentError: '',
      ));
  // --- Private Helpers ---

  bool _isInternetDisconnected() =>
      appSettingsCubit.state.internetState == InternetState.disconnected;

  void _emitNoInternetForBooking() {
    emit(state.copyWith(
      bookAppointmentState: LazyRequestState.error,
      bookAppointmentError: AppStrings.noInternetConnection,
    ));
  }

  void _emitDoctorAppointmentsError(dynamic failure) {
    emit(state.copyWith(
      doctorAppointmentState: RequestState.error,
      doctorAppointmentError: failure.toString(),
    ));
  }

  void _clearSelectedTimeSlot() => emit(state.copyWith(selectedTimeSlot: ''));

  Future<void> _loadReservedSlots(String doctorId, String date) async {
    final response =
        await appointmentRepository.fetchReservedTimeSlotsForDoctorOnDate(
      doctorId: doctorId,
      date: date,
    );

    response.fold(
      (failure) => emit(state.copyWith(
        reservedTimeSlotsState: RequestState.error,
        reservedTimeSlotsError: failure.toString(),
      )),
      (slots) => emit(state.copyWith(
        reservedTimeSlotsState: RequestState.loaded,
        reservedTimeSlots: slots,
      )),
    );
  }

  Future<bool> _checkDoctorAvailability({
    required DateTime selectedDate,
    required List<String> workingDays,
  }) async {
    if (TimeSlotHelper.isSelectedDateBeforeToday(selectedDate)) {
      emit(state.copyWith(
          appointmentAvailabilityStatus:
              AppointmentAvailabilityStatus.pastDate));
      return false;
    }

    final isWorking = TimeSlotHelper.doesDoctorWorkOnDate(
      selectedDate: selectedDate,
      doctorWorkingDays: workingDays,
    );

    final status = isWorking
        ? AppointmentAvailabilityStatus.available
        : AppointmentAvailabilityStatus.doctorNotWorkingOnSelectedDate;

    emit(state.copyWith(appointmentAvailabilityStatus: status));
    return isWorking;
  }

  Future<void> deleteAppointment(
      {required String appointmentId, required String doctorId}) async {
    final response = await appointmentRepository.deleteAppointment(
      appointmentId: appointmentId,
      doctorId: doctorId,
    );
    response.fold((failure) {
      emit(state.copyWith(
        deleteAppointment: LazyRequestState.error,
        deleteAppointmentError: failure.toString(),
      ));
    }, (success) {
      emit(state.copyWith(
        deleteAppointment: LazyRequestState.loaded,
      ));
    });
  }
}
