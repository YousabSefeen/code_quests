import '../../../../doctor_profile/data/models/doctor_model.dart';

class DoctorListState {
  final List<DoctorModel> doctors;
  final bool isLoading;
  final String? errorMessage;

  DoctorListState({
    required this.doctors,
    required this.isLoading,
    this.errorMessage,
  });

  factory DoctorListState.initial() {
    return DoctorListState(doctors: [], isLoading: false);
  }

  DoctorListState copyWith({
    List<DoctorModel>? doctors,
    bool? isLoading,
    String? errorMessage,
  }) {
    return DoctorListState(
      doctors: doctors ?? this.doctors,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}
