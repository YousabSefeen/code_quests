import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/core/enum/lazy_request_state.dart';

import '../../../data/models/doctor_model.dart';
import '../../../data/repository/doctor_profile_repository.dart';
import '../form_controllers/doctor_profile_controllers.dart';
import '../form_controllers/doctor_profile_validator.dart';
import '../states/doctor_profile_state.dart';

class DoctorProfileCubit extends Cubit<DoctorProfileState> {
  final DoctorProfileRepository doctorRepository;

  DoctorProfileCubit({required this.doctorRepository})
      : super(DoctorProfileState.initial());

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

  void confirmWorkingDaysSelection() => emit(state.copyWith(
        confirmedWorkingDays: state.tempSelectedDays,
      ));


  DoctorProfileControllers? _cachedControllers;

    validateAndCacheInputs(DoctorProfileControllers controllers) {
    if (!controllers.formKey.currentState!.validate()) {
      print('No Validate');


    }else {
      _cachedControllers = controllers;
    }


  }



  Future<void> uploadDoctorProfile({
    required String imageUrl,

  }) async {
    final response = await doctorRepository.uploadDoctorProfile(
      DoctorModel(
        imageUrl: imageUrl,
        name: _cachedControllers!.nameController.text,
        specialization: _cachedControllers!.specializationController.text,
        bio:_cachedControllers!.bioController.text,
        location:_cachedControllers!.locationController.text,
        workingDays: state.confirmedWorkingDays,
        availableFrom: state.availableFromTime,
        availableTo: state.availableToTime,
        fees: int.parse(_cachedControllers!.feesController.text) ,
      ),
    );
    response.fold(
      (failure) => emit(state.copyWith(
        doctorProfileState: LazyRequestState.error,
        doctorProfileError: failure.toString(),
      )),
      (success) =>
          emit(state.copyWith(doctorProfileState: LazyRequestState.loaded)),
    );
  }

  void resetStates() => emit(DoctorProfileState.initial());
}
