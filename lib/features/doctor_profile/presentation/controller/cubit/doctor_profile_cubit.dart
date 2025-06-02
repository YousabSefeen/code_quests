import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/core/constants/app_strings/app_strings.dart';
import 'package:flutter_task/core/enum/lazy_request_state.dart';
import 'package:flutter_task/features/shared/models/availability_model.dart';
import 'package:flutter_task/generated/assets.dart';

import '../../../data/models/doctor_model.dart';
import '../../../data/repository/doctor_profile_repository.dart';
import '../form_controllers/doctor_profile_controllers.dart';
import '../states/doctor_profile_state.dart';

class DoctorProfileCubit extends Cubit<DoctorProfileState> {
  final DoctorProfileRepository doctorRepository;

  DoctorProfileCubit({required this.doctorRepository})
      : super(DoctorProfileState.initial());

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

  // Work Hours methods
  void toggleWorkHoursExpanded() => emit(
        state.copyWith(isWorkHoursExpanded: !state.isWorkHoursExpanded),
      );

  final Map<String, String> _workHoursSelected = {};

  void updateWorkHoursSelected(
      bool isTimeRangeEmpty, String? from, String? to) {
    if (!isTimeRangeEmpty) {
      _workHoursSelected.clear();
    } else {
      _workHoursSelected.addAll({AppStrings.from: from!, AppStrings.to: to!});
    }

    emit(state.copyWith(workHoursSelected: Map.from(_workHoursSelected)));
  }


  DoctorProfileControllers? _cachedControllers;

  void validateInputsAndCache(DoctorProfileControllers controllers) {
    _markAsValidatedIfNeeded();

    if (_isFormValid(controllers)) {
      _cacheControllers(controllers);
      _uploadCachedDoctorProfile(imageUrl: Assets.images[0]);
    }
  }

  void _markAsValidatedIfNeeded() {
    if (!state.hasValidatedBefore) {
      emit(state.copyWith(hasValidatedBefore: true));
    }
  }

  bool _isFormValid(DoctorProfileControllers controllers) =>
      controllers.formKey.currentState?.validate() ?? false;

  void _cacheControllers(DoctorProfileControllers controllers) =>
      _cachedControllers = controllers;

  Future<void> _uploadCachedDoctorProfile({required String imageUrl}) async {
    final response = await doctorRepository.uploadDoctorProfile(
      DoctorModel(
        imageUrl: imageUrl,
        name: _cachedControllers!.nameController.text,
        specialization: _cachedControllers!.specializationController.text,
        bio:_cachedControllers!.bioController.text,
        location:_cachedControllers!.locationController.text,
        doctorAvailability: DoctorAvailabilityModel(
          workingDays: state.confirmedWorkingDays,
          availableFrom: state.workHoursSelected[AppStrings.from],
          availableTo: state.workHoursSelected[AppStrings.to],
        ),

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
