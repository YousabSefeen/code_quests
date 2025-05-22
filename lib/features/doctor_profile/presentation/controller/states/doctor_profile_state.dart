import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_task/core/enum/lazy_request_state.dart';
import 'package:time_range/time_range.dart';

class DoctorProfileState extends Equatable {
  final List<String> tempSelectedDays;
  final List<String> confirmedWorkingDays;

  final bool isWorkHoursExpanded;
  final bool isWorkHoursFieldEmpty;
  final TimeRangeResult? workHoursRange;
  final TimeRangeResult? confirmWorkHoursRange;

  final String? availableFromTime;
  final String? availableToTime;
  final String? doctorProfileError;
  final LazyRequestState doctorProfileState;

  const DoctorProfileState({
    required this.tempSelectedDays,
    required this.confirmedWorkingDays,
    required this.isWorkHoursExpanded,
    required this.isWorkHoursFieldEmpty,
    required this.workHoursRange,
    required this.confirmWorkHoursRange,
    required this.availableFromTime,
    required this.availableToTime,
    required this.doctorProfileError,
    required this.doctorProfileState,
  });

  factory DoctorProfileState.initial() {
    return DoctorProfileState(
      tempSelectedDays: const [],
      confirmedWorkingDays: const [],
      isWorkHoursExpanded: false,
      isWorkHoursFieldEmpty: true,
      workHoursRange: TimeRangeResult(
          TimeOfDay(hour: 8, minute: 00),
          TimeOfDay(hour: 22, minute: 00),
      ),

      confirmWorkHoursRange: null,
      availableFromTime: '',
      availableToTime: '',
      doctorProfileError: '',
      doctorProfileState: LazyRequestState.lazy,
    );
  }

  DoctorProfileState copyWith({
    List<String>? tempSelectedDays,
    List<String>? confirmedWorkingDays,
    TimeRangeResult? defaultWorkingHours,
    bool? isWorkHoursExpanded,
    bool? isWorkHoursFieldEmpty,
    TimeRangeResult? workHoursRange,
    TimeRangeResult? confirmWorkHoursRange,
    String? availableFromTime,
    String? availableToTime,
    String? doctorProfileError,
    LazyRequestState? doctorProfileState,
  }) {
    return DoctorProfileState(
      tempSelectedDays: tempSelectedDays ?? this.tempSelectedDays,
      confirmedWorkingDays: confirmedWorkingDays ?? this.confirmedWorkingDays,
      isWorkHoursExpanded: isWorkHoursExpanded ?? this.isWorkHoursExpanded,
      workHoursRange: workHoursRange ?? this.workHoursRange,
      confirmWorkHoursRange: confirmWorkHoursRange ?? this.confirmWorkHoursRange,
      availableFromTime: availableFromTime ?? this.availableFromTime,
      availableToTime: availableToTime ?? this.availableToTime,
      doctorProfileError: doctorProfileError ?? this.doctorProfileError,
      doctorProfileState: doctorProfileState ?? this.doctorProfileState,
      isWorkHoursFieldEmpty:
          isWorkHoursFieldEmpty ?? this.isWorkHoursFieldEmpty,
    );
  }

  @override
  List<Object?> get props => [
        tempSelectedDays,
        confirmedWorkingDays,
        isWorkHoursExpanded,
        workHoursRange,
        confirmWorkHoursRange,
        availableFromTime,
        availableToTime,
        doctorProfileError,
        doctorProfileState,
        isWorkHoursFieldEmpty
      ];
}
