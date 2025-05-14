import 'package:equatable/equatable.dart';

import '../../../../../core/enum/request_state.dart';
import '../../../data/models/doctor_list_model.dart';

class DoctorListState extends Equatable {
  final List<DoctorListModel> doctorList;
  final RequestState doctorListState;
  final String doctorListError;

  const DoctorListState({
    this.doctorList = const [],
    this.doctorListState = RequestState.loading,
    this.doctorListError = '',
  });

  DoctorListState copyWith({
    List<DoctorListModel>? doctorList,
    RequestState? doctorListState,
    String? doctorListError,
  }) {
    return DoctorListState(
      doctorList: doctorList ?? this.doctorList,
      doctorListState: doctorListState ?? this.doctorListState,
      doctorListError: doctorListError ?? this.doctorListError,
    );
  }

  @override
  List<Object> get props => [
        doctorList,
        doctorListState,
        doctorListError,
      ];
}
