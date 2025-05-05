class DoctorProfileState {
  final List<String> tempSelectedDays;
  final List<String> confirmedWorkingDays;
  final String? availableFromTime;
  final String? availableToTime;

  DoctorProfileState({
    required this.tempSelectedDays,
    required this.confirmedWorkingDays,
    required this.availableFromTime,
    required this.availableToTime,
  });

  factory DoctorProfileState.initial() {
    return DoctorProfileState(
      tempSelectedDays: [],
      confirmedWorkingDays: [],
      availableFromTime: null,
      availableToTime: null,
    );
  }

  DoctorProfileState copyWith({
    List<String>? tempSelectedDays,
    List<String>? confirmedWorkingDays,
    String? availableFromTime,
    String? availableToTime,
  }) {
    return DoctorProfileState(
      tempSelectedDays: tempSelectedDays ?? this.tempSelectedDays,
      confirmedWorkingDays: confirmedWorkingDays ?? this.confirmedWorkingDays,
      availableFromTime: availableFromTime ?? this.availableFromTime,
      availableToTime: availableToTime ?? this.availableToTime,
    );
  }
}
