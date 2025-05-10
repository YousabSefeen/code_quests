import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/core/error/failure.dart';
import 'package:intl/intl.dart';

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

  getAvailableDoctorTimeSlots({
    required DateTime selectedDate,
    required DoctorListModel doctor  ,

  }) async {

    final selectedDateByUser =
    DateTimeFormatter.convertSelectedDateToString(
        selectedDate);


    final allDoctorTimeSlots = TimeSlotHelper.generateHourlyTimeSlots(
      startTime: doctor.doctorModel.availableFrom!,
      endTime:  doctor.doctorModel.availableTo!,
    );

    await getReservedTimeSlotsForDoctorOnDate(doctorId: doctor.doctorId, date: selectedDateByUser);



    final availableDoctorTimeSlots = TimeSlotHelper.filterAvailableTimeSlots(
      totalTimeSlots: allDoctorTimeSlots,
      reservedTimeSlots: state.reservedTimeSlots,
    );
    //[01:00 PM, 02:00 PM, 03:00 PM, 04:00 PM, 06:00 PM, 08:00 PM]
     print('availableDoctorTimeSlots $availableDoctorTimeSlots');

     emit(state.copyWith(availableDoctorTimeSlots:availableDoctorTimeSlots));
    //return availableDoctorTimeSlots;
  }




}
