import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/core/enum/lazy_request_state.dart';
import 'package:time_range/time_range.dart';

import '../../../data/models/doctor_model.dart';
import '../../../data/repository/doctor_profile_repository.dart';
import '../form_controllers/doctor_profile_controllers.dart';
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

  void toggleWorkHoursExpanded() => emit(
        state.copyWith(isWorkHoursExpanded: !state.isWorkHoursExpanded),
      );

  String? _from;
  String? _to;
  void updateWorkHours(TimeRangeResult? workHoursRange,BuildContext context) {

    // هنا يمكن أن تضيف تحويل الوقت مباشرة
    if (workHoursRange != null) {
      print('DoctorProfileCubit.updateWorkHour  00000000000000000000000000000000000000');
      final from = workHoursRange.start.format(context);
      final to = workHoursRange.end.format(context);
      updateWorkHoursValues(from: from, to: to);
    }else{
      print('DoctorProfileCubit.updateWorkHour  111111111111111111111111111111');

      updateWorkHoursValues(from: null, to: null);
    }
  }


  void deleteWorkHours(){
    print('DoctorProfileCubit.deleteWorkHours');
    emit(state.copyWith(
      availableFromTime: '',
      availableToTime: '',
    ));
  }


  void updateWorkHoursValues({required String? from, required String? to}) {
    print('DoctorProfileCubit.updateWorkHoursValues');
    emit(state.copyWith(
      availableFromTime: from,
      availableToTime: to,
    ));


  }

void pp(){


  final from=state.availableFromTime;
  final to=state.availableToTime;
  print('DoctorProfileCubit.From $from');
  print('DoctorProfileCubit.TO $to');
  }


  void checkWorkHours(TimeRangeResult? range) {

    if(range==null){
      emit(state.copyWith(
        isWorkHoursFieldEmpty:true,
      ));
    }else{
      emit(state.copyWith(
        isWorkHoursFieldEmpty:false,
      ));
    }

  }




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
// extension TimeOfDayExtensions on TimeOfDay {
//   String formatTime() {
//     final hour = this.hour.toString().padLeft(2, '0');
//     final minute = this.minute.toString().padLeft(2, '0');
//     return '$hour:$minute';
//   }
// }