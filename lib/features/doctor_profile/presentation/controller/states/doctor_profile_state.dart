import 'package:equatable/equatable.dart';
import 'package:flutter_task/core/enum/lazy_request_state.dart';

class DoctorProfileState extends Equatable {
  final List<String> tempSelectedDays;
  final List<String> confirmedWorkingDays;
  final String? availableFromTime;
  final String? availableToTime;
  final String? doctorProfileError;
  final LazyRequestState doctorProfileState;

  const DoctorProfileState({
    required this.tempSelectedDays,
    required this.confirmedWorkingDays,
    required this.availableFromTime,
    required this.availableToTime,
    required this.doctorProfileError,
    required this.doctorProfileState,
  });

  factory DoctorProfileState.initial() {
    return const DoctorProfileState(
      tempSelectedDays: [],
      confirmedWorkingDays: [],
      availableFromTime: null,
      availableToTime: null,
      doctorProfileError: '',
      doctorProfileState: LazyRequestState.lazy,
    );
  }

  DoctorProfileState copyWith({
    List<String>? tempSelectedDays,
    List<String>? confirmedWorkingDays,
    String? availableFromTime,
    String? availableToTime,
    String? doctorProfileError,
    LazyRequestState? doctorProfileState,
  }) {
    return DoctorProfileState(
      tempSelectedDays: tempSelectedDays ?? this.tempSelectedDays,
      confirmedWorkingDays: confirmedWorkingDays ?? this.confirmedWorkingDays,
      availableFromTime: availableFromTime ?? this.availableFromTime,
      availableToTime: availableToTime ?? this.availableToTime,
      doctorProfileError: doctorProfileError ?? this.doctorProfileError,
      doctorProfileState: doctorProfileState ?? this.doctorProfileState,
    );
  }

  @override
  List<Object?> get props => [
        tempSelectedDays,
        confirmedWorkingDays,
        availableFromTime,
        availableToTime,
        doctorProfileError,
        doctorProfileState,
      ];
}
