import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/core/error/failure.dart';

import '../../../../../core/enum/request_state.dart';
import '../../../../../core/utils/date_time_formatter.dart';
import '../../../../../core/utils/time_slot_helper.dart';
import '../../../../doctor_list/data/models/doctor_list_model.dart';
import '../../../data/repository/appointment_repository.dart';
import '../states/appointment_state.dart';

class AppointmentCubit extends Cubit<AppointmentState> {
  AppointmentRepository appointmentRepository;

  AppointmentCubit({
    required this.appointmentRepository,
  }) : super(const AppointmentState());

  Future getDoctorAppointments({required String doctorId}) async {
    final response =
        await appointmentRepository.getDoctorAppointments(doctorId: doctorId);

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

  Future getReservedTimeSlotsForDoctorOnDate(
      {required String doctorId, required String date}) async {
    print('AppointmentCubit.getReservedTimeSlotsForDoctorOnDate');
    final Either<Failure, List<String>> response = await appointmentRepository
        .getReservedTimeSlotsForDoctorOnDate(doctorId: doctorId, date: date);

    response.fold(
      (failure) => state.copyWith(
        doctorAppointmentState: RequestState.error,
        doctorAppointmentError: failure.toString(),
      ),
      (success) => emit(
        state.copyWith(
            reservedTimeSlotsState: RequestState.loaded,
            reservedTimeSlots: success),
      ),
    );
  }

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

    final selectedDateFormatted = DateTimeFormatter.convertSelectedDateToString(
      selectedDate,
    );

    final allTimeSlots = TimeSlotHelper.generateHourlyTimeSlots(
      startTime: doctor.doctorModel.availableFrom!,
      endTime: doctor.doctorModel.availableTo!,
    );

    await getReservedTimeSlotsForDoctorOnDate(
      doctorId: doctor.doctorId,
      date: selectedDateFormatted,
    );

    final availableTimeSlots = TimeSlotHelper.filterAvailableTimeSlots(
      totalTimeSlots: allTimeSlots,
      reservedTimeSlots: state.reservedTimeSlots,
    );

    print('Available Time Slots: $availableTimeSlots');

    emit(state.copyWith(availableDoctorTimeSlots: availableTimeSlots));
  }
}
