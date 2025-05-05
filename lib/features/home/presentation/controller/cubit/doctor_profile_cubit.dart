import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../states/doctor_profile_state.dart';

class DoctorProfileCubit extends Cubit<DoctorProfileState> {
  DoctorProfileCubit():super(  DoctorProfileState.initial());
  // static const List<String> weekDays = [
  //   'Saturday',
  //   'Sunday',
  //   'Monday',
  //   'Tuesday',
  //   'Wednesday',
  //   'Thursday',
  //   'Friday',
  // ];
  //
  //
  //
  // void toggleDay(String day) {
  //   final updatedDays = Set<String>.from(state.selectedDays);
  //   if (updatedDays.contains(day)) {
  //     updatedDays.remove(day);
  //   } else {
  //     updatedDays.add(day);
  //   }
  //
  //   state.workingDaysController.text = updatedDays.join(', ');
  //
  //   emit(state.copyWith(selectedDays: updatedDays));
  // }

  void setTime(String formattedTime, {required bool isStart}) {
    if (isStart) {

      emit(state.copyWith(startTime: formattedTime));
    } else {

      emit(state.copyWith(endTime: formattedTime));
    }

  }

  String formatTime(DateTime time) {
    return DateFormat('hh:mm a').format(time).toString();
  }

  DateTime parseTime(String timeString) {
    return DateFormat('hh:mm a').parse(timeString);
  }

  // Map<String, dynamic> collectDoctorData() {
  //   return {
  //     'name': state.nameController.text.trim(),
  //     'specialization': state.specializationController.text.trim(),
  //     'bio': state.bioController.text.trim(),
  //     'location': state.locationController.text.trim(),
  //     'workingDays': state.selectedDays.toList(),
  //     'availableFrom': state.availableFromController.text.trim(),
  //     'availableTo': state.availableToController.text.trim(),
  //     'fees': state.feesController.text.trim(),
  //   };
  // }
}
