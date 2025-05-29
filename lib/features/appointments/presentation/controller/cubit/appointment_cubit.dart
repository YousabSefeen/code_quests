import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/app_settings/controller/cubit/app_settings_cubit.dart';
import '../../../../../core/enum/appointment_availability_status.dart';
import '../../../../../core/enum/internet_state.dart';
import '../../../../../core/enum/lazy_request_state.dart';
import '../../../../../core/enum/request_state.dart';
import '../../../../../core/utils/date_time_formatter.dart';
import '../../../../../core/utils/time_slot_helper.dart';
import '../../../../doctor_list/data/models/doctor_list_model.dart';
import '../../../data/repository/appointment_repository.dart';
import '../states/appointment_state.dart';

class AppointmentCubit extends Cubit<AppointmentState> {
  final AppSettingsCubit appSettingsCubit;
   AppointmentRepository appointmentRepository;

  AppointmentCubit({
    required this.appSettingsCubit,
    required this.appointmentRepository,
  }) : super(const AppointmentState());

  Future fetchDoctorAppointments({required String doctorId}) async {
    final response =
        await appointmentRepository.fetchDoctorAppointments(doctorId: doctorId);

    response.fold(
        (failure) => emit(
              state.copyWith(
                doctorAppointmentState: RequestState.error,
                doctorAppointmentError: failure.toString(),
              ),
            ),
        (success) => emit(
              state.copyWith(
                doctorAppointmentState: RequestState.loaded,
                doctorAppointmentModel: success,
              ),
            ));
  }

  Future _fetchReservedTimeSlotsForDoctorOnDate(
      {required String doctorId, required String date}) async {

    final response = await appointmentRepository
        .fetchReservedTimeSlotsForDoctorOnDate(doctorId: doctorId, date: date);

    response.fold(
      (failure) => state.copyWith(
        reservedTimeSlotsState: RequestState.error,
        reservedTimeSlotsError: failure.toString(),
      ),
      (success) => emit(
        state.copyWith(
            reservedTimeSlotsState: RequestState.loaded,
            reservedTimeSlots: success,
        ),
      ),
    );
  }

  Future<bool> _checkIfDoctorWorksOnDate({
    required DateTime selectedDate,
    required List<String> doctorWorkingDays,
  }) async {
    bool? availabilityStatus;

    bool isSelectedDateBeforeToday =
        TimeSlotHelper.isSelectedDateBeforeToday(selectedDate);
    if (isSelectedDateBeforeToday) {
      availabilityStatus = false;
      emit(state.copyWith(
          appointmentAvailabilityStatus:
              AppointmentAvailabilityStatus.pastDate));
    } else {
      final isAvailable = TimeSlotHelper.doesDoctorWorkOnDate(
        selectedDate: selectedDate,
        doctorWorkingDays: doctorWorkingDays,
      );
      if (isAvailable) {
        availabilityStatus = true;
        emit(state.copyWith(
            appointmentAvailabilityStatus:
                AppointmentAvailabilityStatus.available,
        ));
      } else {
        availabilityStatus = false;
        emit(state.copyWith(
            appointmentAvailabilityStatus:
                AppointmentAvailabilityStatus.doctorNotWorkingOnSelectedDate,
        ));
      }
    }
    return availabilityStatus;
  }

  String? _selectedDateFormatted;

  Future<void> getAvailableDoctorTimeSlots({
    required DateTime selectedDate,
    required DoctorListModel doctor,
  }) async {
    final isDoctorAvailable = await _checkIfDoctorWorksOnDate(
      selectedDate: selectedDate,
      doctorWorkingDays: doctor.doctorModel.workingDays,
    );

    if (!isDoctorAvailable) {
      return;
    } else {
      if (state.selectedTimeSlot != null) {
        _clearSelectedTimeSlot();
       }

      _selectedDateFormatted = DateTimeFormatter.convertSelectedDateToString(
         selectedDate,
       );

       final allTimeSlots = TimeSlotHelper.generateHourlyTimeSlots(
         startTime: doctor.doctorModel.availableFrom!,
         endTime: doctor.doctorModel.availableTo!,
       );

       await _fetchReservedTimeSlotsForDoctorOnDate(
         doctorId: doctor.doctorId,
         date: _selectedDateFormatted!,
       );

       final availableTimeSlots = TimeSlotHelper.filterAvailableTimeSlots(
         totalTimeSlots: allTimeSlots,
         reservedTimeSlots: state.reservedTimeSlots,
       );

       emit(state.copyWith(availableDoctorTimeSlots: availableTimeSlots));


     }


  }







  /// Updates the state with the time slot selected by the user for appointment
  /// [selectedTimeSlot] The time slot string in format 'HH:MM AM/PM'
  void updateSelectedTimeSlot(String selectedTimeSlot) => emit(state.copyWith(
    selectedTimeSlot: selectedTimeSlot,
  ));
  /// Clears the currently selected time slot from the state
  void _clearSelectedTimeSlot() => emit(state.copyWith(
    selectedTimeSlot: '',
  ));

    void printData(){
      print('AppointmentCubit.printData   ${state.selectedTimeSlot}');
  }
  void checkInternet() {
    if (appSettingsCubit.state.internetState==InternetState.none) {

         emit(state.copyWith(
           bookAppointmentState: LazyRequestState.error,

           bookAppointmentError: 'No Internet Connection',
         ));

       }
     }
  Future<void> createAppointmentForDoctor({required String doctorId}) async {

    if (appSettingsCubit.state.internetState==InternetState.none) {

      emit(state.copyWith(
        bookAppointmentState: LazyRequestState.error,

        bookAppointmentError: 'No Internet Connection',
      ));
      return;
    }
    emit(state.copyWith(bookAppointmentState: LazyRequestState.loading));
    final response = await appointmentRepository.createAppointmentForDoctor(
      doctorId: doctorId,
      date: _selectedDateFormatted!,
      time: state.selectedTimeSlot!,
    );

    response.fold(
        (failure) => state.copyWith(
              bookAppointmentState: LazyRequestState.error,
              bookAppointmentError: failure.toString(),
            ),
        (success) => emit(state.copyWith(
              bookAppointmentState: LazyRequestState.loaded,
            )));
  }

  fetchClientAppointmentsWithDoctorDetails() async {
    final response =
        await appointmentRepository.fetchClientAppointmentsWithDoctorDetails();

    response.fold(
      (failure) => emit(state.copyWith(
        getClientAppointmentsListState: RequestState.error,
        getClientAppointmentsListError: failure.toString(),
      )),
      (appointmentList) => emit(state.copyWith(
        getClientAppointmentsList: appointmentList,
        getClientAppointmentsListState: RequestState.loaded,
      )),
    );
  }

  void deleteData() {
    emit(state.copyWith(selectedTimeSlot: ''));

    emit(state.copyWith(
      bookAppointmentState: LazyRequestState.lazy,
    ));
  }
}
