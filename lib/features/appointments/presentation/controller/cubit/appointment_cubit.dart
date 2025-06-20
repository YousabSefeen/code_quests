import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/core/constants/app_strings/app_strings.dart';
import 'package:flutter_task/features/appointments/data/models/book_appointment_model.dart';
import 'package:flutter_task/features/appointments/presentation/controller/form_contollers/patient_fields_controllers.dart';

import '../../../../../core/app_settings/controller/cubit/app_settings_cubit.dart';
import '../../../../../core/enum/appointment_availability_status.dart';
import '../../../../../core/enum/appointment_status.dart';
import '../../../../../core/enum/internet_state.dart';
import '../../../../../core/enum/lazy_request_state.dart';
import '../../../../../core/enum/request_state.dart';
import '../../../../../core/utils/date_time_formatter.dart';
import '../../../../../core/utils/time_slot_helper.dart';
import '../../../../shared/models/doctor_schedule_model.dart';
import '../../../data/models/client_appointments_model.dart';
import '../../../data/repository/appointment_repository.dart';
import '../states/appointment_state.dart';

class AppointmentCubit extends Cubit<AppointmentState> {
  final AppSettingsCubit appSettingsCubit;
  final AppointmentRepository appointmentRepository;


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

    required DoctorScheduleModel doctorSchedule,
  }) async {

    _clearSelectedTimeSlot();
    final isAvailable = await _checkDoctorAvailability(
      selectedDate: selectedDate,
      workingDays:doctorSchedule.doctorAvailability.workingDays,
    );

    if (!isAvailable) return;



    final formattedDate = DateTimeFormatter.convertSelectedDateToString(selectedDate);
    emit(state.copyWith(selectedDateFormatted: formattedDate));


    final allTimeSlots = TimeSlotHelper.generateHourlyTimeSlots(
      startTime: doctorSchedule.doctorAvailability.availableFrom!,
      endTime: doctorSchedule.doctorAvailability.availableTo!,
    );

    await _loadReservedSlots( doctorSchedule.doctorId, formattedDate);

    final availableSlots = TimeSlotHelper.filterAvailableTimeSlots(
      totalTimeSlots: allTimeSlots,
      reservedTimeSlots: state.reservedTimeSlots,
    );

    emit(state.copyWith(availableDoctorTimeSlots: availableSlots));
  }

  void updateSelectedTimeSlot(String selectedSlot) {
    emit(state.copyWith(selectedTimeSlot: selectedSlot));
  }



  Future<void> bookAppointment({required String doctorId }) async {
    if (_isInternetDisconnected()) {
      _emitNoInternetForBooking();
      return;
    }

    emit(state.copyWith(bookAppointmentState: LazyRequestState.loading));

    final response = await appointmentRepository.bookAppointment(
      bookAppointmentModel: BookAppointmentModel(
        doctorId: doctorId,
        patientName: _cachedControllers!.nameController.text.trim(),
        patientGender: state.selectedGenderIndex==0? AppStrings.male: AppStrings.female,
        patientAge:_cachedControllers!.ageController.text.trim(),
        patientProblem:_cachedControllers!.problemController.text.trim(),
        appointmentDate: state.selectedDateFormatted!,
        appointmentTime: state.selectedTimeSlot!,
      ),

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

  /// Reschedule Appointment Process
  Future<void> rescheduleAppointment({
    required String doctorId,
    required String appointmentId,
  }) async {
    if (_isInternetDisconnected()) {
      _emitNoInternetForBooking();
      return;
    }

    emit(state.copyWith(rescheduleAppointmentState: LazyRequestState.loading));
    final response = await appointmentRepository.rescheduleAppointment(
      doctorId: doctorId,
      appointmentId: appointmentId,
      appointmentDate:state.selectedDateFormatted!,
      appointmentTime: state.selectedTimeSlot!,
    );

    response.fold(
      (failure) => emit(state.copyWith(
        rescheduleAppointmentState: LazyRequestState.error,
        rescheduleAppointmentError: failure.toString(),
      )),
      (_) async{
        await  fetchClientAppointmentsWithDoctorDetails();


        emit(state.copyWith(
          rescheduleAppointmentState: LazyRequestState.loaded,
        ));
      },
    );
  }

  /// Cancel Appointment Process
  Future<void> cancelAppointment(
      {required String doctorId, required String appointmentId}) async {
    if (_isInternetDisconnected()) {
      _emitNoInternetForBooking();
      return;
    }

    emit(state.copyWith(cancelAppointmentState: LazyRequestState.loading));

    final response = await appointmentRepository.cancelAppointment(
        doctorId: doctorId, appointmentId: appointmentId);

    response.fold(
        (failure) => emit(state.copyWith(
              cancelAppointmentState: LazyRequestState.error,
              cancelAppointmentError: failure.toString(),
            )), (_) async {
      await fetchClientAppointmentsWithDoctorDetails();

      emit(state.copyWith(
        cancelAppointmentState: LazyRequestState.loaded,
      ));
    });
  }

  String get selectedTimeSlot {
    return state.selectedTimeSlot ?? 'selectedTimeSlot Null';
  }

  String get selectedDateFormatted {
    return state.selectedDateFormatted ?? 'selectedTimeSlot Null';
  }

  ///
  List<ClientAppointmentsModel>? get upcomingAppointments {
    final now = DateTime.now();
    return state.getClientAppointmentsList
        .where(
          (appointment) =>
              appointment.appointmentStatus ==
                  AppointmentStatus.confirmed.name &&
              appointDateFormatted(appointment.appointmentDate).isAfter(now),
        )
        .toList();
  }

  DateTime appointDateFormatted(String appointDate) {
    return DateTimeFormatter.convertDateToString(appointDate);
  }

  List<ClientAppointmentsModel>? get completedAppointments {
    final now = DateTime.now();
    return state.getClientAppointmentsList
        .where(
          (appointment) =>
              appointment.appointmentStatus ==
                  AppointmentStatus.completed.name ||
              (appointment.appointmentStatus ==
                  AppointmentStatus.confirmed.name &&
                  appointDateFormatted(appointment.appointmentDate)
                      .isBefore(now)),
        )
        .toList();
  }

  List<ClientAppointmentsModel>? get cancelledAppointments {
    return state.getClientAppointmentsList
        .where(
          (appointment) =>
              appointment.appointmentStatus ==
                  AppointmentStatus.cancelled.name,
        )
        .toList();
  }

  ///
  Future<void> fetchClientAppointmentsWithDoctorDetails() async {
    final response =
        await appointmentRepository.fetchClientAppointmentsWithDoctorDetails();
    response.fold(
      (failure) => emit(state.copyWith(
        getClientAppointmentsListState: RequestState.error,
        getClientAppointmentsListError: failure.toString(),
      )),
      (appointments) {

        emit(state.copyWith(
        getClientAppointmentsList: appointments,
        getClientAppointmentsListState: RequestState.loaded,
      ));
      },
    );
  }



  void resetBookAppointmentState() => emit(state.copyWith(
        bookAppointmentState: LazyRequestState.lazy,
        bookAppointmentError: '',
      ));
  void resetRescheduleAppointmentState() => emit(state.copyWith(
    rescheduleAppointmentState: LazyRequestState.lazy,
    rescheduleAppointmentError: '',
  ));
  void resetCancelAppointmentState() => emit(state.copyWith(
    cancelAppointmentState: LazyRequestState.lazy,
    cancelAppointmentError: '',
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

//***************************************************************
  void onChangeSelectedGenderIndex(int index) {
    emit(state.copyWith(selectedGenderIndex: index));
  }

  void printData() {
    print('nameController  ${_cachedControllers?.nameController.text}');
    print('selectedGenderIndex  ${state.selectedGenderIndex}');

    print('ageController  ${_cachedControllers?.ageController.text}');
    print('problemController  ${_cachedControllers?.problemController.text}');
  }

  PatientFieldsControllers? _cachedControllers;

  void validateInputsAndCache(
      {required String doctorId,
      required PatientFieldsControllers controllers}) {
    _markAsValidatedIfNeeded();

    if (_isFormValid(controllers)) {
      _cacheControllers(controllers);
      bookAppointmentProcess(doctorId);
    }
  }

  void bookAppointmentProcess(String doctorId) {
    bookAppointment(doctorId: doctorId);
  }

  void _markAsValidatedIfNeeded() {
    if (!state.hasValidatedBefore) {
      emit(state.copyWith(hasValidatedBefore: true));
    }
  }

  bool _isFormValid(PatientFieldsControllers controllers) {
    final isFormValid = controllers.formKey.currentState?.validate() ?? false;
    final isGenderValid = controllers.genderController.validate();

    final isAllFormValid = isFormValid && isGenderValid;

    return isAllFormValid;
  }

  void _cacheControllers(PatientFieldsControllers controllers) =>
      _cachedControllers = controllers;
}
