import 'package:equatable/equatable.dart';
import 'package:flutter_task/core/enum/lazy_request_state.dart';

class DoctorProfileState extends Equatable {
  final List<String> tempSelectedDays;
  final List<String> confirmedWorkingDays;

  final bool isWorkHoursExpanded;

  final Map<String, String> workHoursSelected;

  final String? doctorProfileError;
  final LazyRequestState doctorProfileState;

  const DoctorProfileState({
    required this.tempSelectedDays,
    required this.confirmedWorkingDays,
    required this.isWorkHoursExpanded,
    required this.workHoursSelected,
    required this.doctorProfileError,
    required this.doctorProfileState,
  });

  factory DoctorProfileState.initial() {
    return const DoctorProfileState(
      tempSelectedDays: [],
      confirmedWorkingDays: [],
      isWorkHoursExpanded: false,
      workHoursSelected: {},
      doctorProfileError: '',
      doctorProfileState: LazyRequestState.lazy,
    );
  }

  DoctorProfileState copyWith({
    List<String>? tempSelectedDays,
    List<String>? confirmedWorkingDays,
    bool? isWorkHoursExpanded,
    Map<String, String>? workHoursSelected,
    String? doctorProfileError,
    LazyRequestState? doctorProfileState,
  }) {
    return DoctorProfileState(
      tempSelectedDays: tempSelectedDays ?? this.tempSelectedDays,
      confirmedWorkingDays: confirmedWorkingDays ?? this.confirmedWorkingDays,
      isWorkHoursExpanded: isWorkHoursExpanded ?? this.isWorkHoursExpanded,
      workHoursSelected: workHoursSelected ?? this.workHoursSelected,
      doctorProfileError: doctorProfileError ?? this.doctorProfileError,
      doctorProfileState: doctorProfileState ?? this.doctorProfileState,
    );
  }

  @override
  List<Object?> get props => [
        tempSelectedDays,
        confirmedWorkingDays,
        isWorkHoursExpanded,
        workHoursSelected,
        doctorProfileError,
        doctorProfileState,
      ];
}
