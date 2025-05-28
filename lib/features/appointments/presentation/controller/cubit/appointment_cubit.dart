import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/app_settings/controller/cubit/app_settings_cubit.dart';
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

  Future fetchReservedTimeSlotsForDoctorOnDate(
      {required String doctorId, required String date}) async {

    final response = await appointmentRepository
        .fetchReservedTimeSlotsForDoctorOnDate(doctorId: doctorId, date: date);

    response.fold(
      (failure) => state.copyWith(
        doctorAppointmentState: RequestState.error,
        doctorAppointmentError: failure.toString(),
      ),
      (success) => emit(
        state.copyWith(
            reservedTimeSlotsState: RequestState.loaded,
            reservedTimeSlots: success,
        ),
      ),
    );
  }

  String? selectedDateFormatted;

  Future<String> getSelectedDate(DateTime selectedDate) async =>
      DateTimeFormatter.convertSelectedDateToString(selectedDate);

  Future<bool> checkIfDoctorWorksOnDate({
    required DateTime selectedDate,
    required List<String> doctorWorkingDays,
  }) async {
    final isAvailable = TimeSlotHelper.doesDoctorWorkOnDate(
      selectedDate: selectedDate,
      doctorWorkingDays: doctorWorkingDays,
    );

    emit(state.copyWith(isDoctorAvailable: isAvailable));
    return isAvailable;
  }

  Future<void> getAvailableDoctorTimeSlots({
    required DateTime selectedDate,
    required DoctorListModel doctor,
  }) async {
    final isDoctorAvailable = await checkIfDoctorWorksOnDate(
      selectedDate: selectedDate,
      doctorWorkingDays: doctor.doctorModel.workingDays,
    );

    if (!isDoctorAvailable) return;

    selectedDateFormatted = DateTimeFormatter.convertSelectedDateToString(
      selectedDate,
    );

    final allTimeSlots = TimeSlotHelper.generateHourlyTimeSlots(
      startTime: doctor.doctorModel.availableFrom!,
      endTime: doctor.doctorModel.availableTo!,
    );

    await fetchReservedTimeSlotsForDoctorOnDate(
      doctorId: doctor.doctorId,
      date: selectedDateFormatted!,
    );

    final availableTimeSlots = TimeSlotHelper.filterAvailableTimeSlots(
      totalTimeSlots: allTimeSlots,
      reservedTimeSlots: state.reservedTimeSlots,
    );

    emit(state.copyWith(availableDoctorTimeSlots: availableTimeSlots));
  }

  void setUserTime(String selectedTime) => emit(
        state.copyWith(selectedTimeByUser: selectedTime),
      );

  void deleteData() {
    emit(
      state.copyWith(selectedTimeByUser: ''),
    );

    emit(
      state.copyWith(bookAppointmentState: LazyRequestState.lazy),
    );
  }
     void checkInternet(){

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
      date: selectedDateFormatted!,
      time: state.selectedTimeByUser!,
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

  getClientAppointmentsWithDoctorDetails() async {
    final response =
        await appointmentRepository.getClientAppointmentsWithDoctorDetails();

    response.fold(
      (failure) {
        print(
            'AppointmentCubit.getClientAppointmentsWithDoctorDetails   ${failure.toString()}');
        emit(state.copyWith(
          getClientAppointmentsListState: RequestState.error,
          getClientAppointmentsListError: failure.toString(),
        ));
      },
      (appointmentList) => emit(state.copyWith(
        getClientAppointmentsList: appointmentList,
        getClientAppointmentsListState: RequestState.loaded,
      )),
    );
  }
}
