import 'package:flutter_bloc/flutter_bloc.dart';

import '../states/doctor_profile_state.dart';

class DoctorProfileCubit extends Cubit<DoctorProfileState> {
  DoctorProfileCubit() : super(DoctorProfileState.initial());

  void updateAvailableTime(String formattedTime, {required bool isStartTime}) {
    if (isStartTime) {
      emit(state.copyWith(availableFromTime: formattedTime));
    } else {
      emit(state.copyWith(availableToTime: formattedTime));
    }
  }

  void toggleWorkingDay(String day) {
    final updatedDays = List<String>.from(state.tempSelectedDays);

    if (updatedDays.contains(day)) {
      updatedDays.remove(day);
    } else {
      updatedDays.add(day);
    }

    emit(state.copyWith(tempSelectedDays: updatedDays));
  }

  void confirmWorkingDaysSelection() {
    emit(state.copyWith(confirmedWorkingDays: state.tempSelectedDays));
  }
}
