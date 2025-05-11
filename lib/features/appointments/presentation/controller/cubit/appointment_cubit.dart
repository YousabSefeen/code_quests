import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/features/appointments/data/models/appointment_model.dart';

import '../../../../../core/enum/lazy_request_state.dart';
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
    final response = await appointmentRepository
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

    await getReservedTimeSlotsForDoctorOnDate(
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

  void deleteUserTimeSelected() {
    emit(
        state.copyWith(selectedTimeByUser: ''),
      );

    emit(
      state.copyWith(bookAppointmentState: LazyRequestState.lazy),
    );
  }

  Future<void> createAppointmentForDoctor({required String doctorId}) async {


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


  Future<List<Map<String, dynamic>>> fetchClientAppointmentsWithDoctorNames( ) async {

    final clientId=FirebaseAuth.instance.currentUser!.uid;
    final appointmentsSnapshot = await FirebaseFirestore.instance
        .collection('appointments')
        .where('clientId', isEqualTo: clientId)
        .orderBy('date')
        .get();

    final appointments = appointmentsSnapshot.docs.map((doc) => doc.data()).toList();

    // تجميع doctorId بدون تكرار
    final doctorIds = appointments
        .map((appointment) => appointment['doctorId'] as String)
        .toSet()
        .toList();

    // جلب بيانات الأطباء دفعة واحدة
    final doctorsSnapshot = await FirebaseFirestore.instance
        .collection('doctors')
        .where(FieldPath.documentId, whereIn: doctorIds)
        .get();

    // إنشاء خريطة doctorId -> name
    final doctorIdToName = {
      for (var doc in doctorsSnapshot.docs)
        doc.id: doc.data()['name'] ?? 'Unknown'
    };

    // إضافة الاسم لكل حجز
    for (var appointment in appointments) {
      final doctorId = appointment['doctorId'] as String;
      appointment['name'] = doctorIdToName[doctorId]; // ✅ من مجموعة doctors
    }


    print('AppointmentCubit.fetchClientAppointmentsWithDoctorNames\n ${appointments[0]}');
    return appointments;
  }
}
