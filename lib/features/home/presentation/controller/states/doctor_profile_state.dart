

class DoctorProfileState {
  final Set<String> selectedDays;
  final String? startTime;
  final String? endTime;

  DoctorProfileState({
    required this.selectedDays,
    required this.startTime,
    required this.endTime,
  });

  factory DoctorProfileState.initial() {
    return DoctorProfileState(selectedDays: {}, startTime: null, endTime: null);
  }

  DoctorProfileState copyWith({
    Set<String>? selectedDays,
    String? startTime,
    String? endTime,
  }) {
    return DoctorProfileState(
      selectedDays: selectedDays ?? this.selectedDays,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
    );
  }
}
