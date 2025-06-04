import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/core/constants/app_strings/app_strings.dart';

import '../../../../../core/app_settings/controller/cubit/app_settings_cubit.dart';
import '../../../../../core/enum/appointment_availability_status.dart';
import '../../../../../core/enum/internet_state.dart';
import '../../../../../core/enum/lazy_request_state.dart';
import '../../../../../core/enum/request_state.dart';
import '../../../../../core/utils/date_time_formatter.dart';
import '../../../../../core/utils/time_slot_helper.dart';
import '../../../../shared/models/doctor_schedule_model.dart';
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

  void printData() {

    print('AppointmentCubit.printData  ${state.selectedTimeSlot}');
    print('AppointmentCubit.printData  ${state.selectedDateFormatted}');
  }

  Future<void> bookAppointment(
      {required String doctorId, bool? isReschedule}) async {
    if (_isInternetDisconnected()) {
      _emitNoInternetForBooking();
      return;
    }

    emit(state.copyWith(bookAppointmentState: LazyRequestState.loading));

    final response = await appointmentRepository.bookAppointment(
      doctorId: doctorId,
      date: state.selectedDateFormatted!,
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

  ///
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



  void resetBookingState() => emit(state.copyWith(
        bookAppointmentState: LazyRequestState.lazy,
        bookAppointmentError: '',
      ));
  void resetRescheduleAppointmentState() => emit(state.copyWith(
    rescheduleAppointmentState: LazyRequestState.lazy,
    rescheduleAppointmentError: '',
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
