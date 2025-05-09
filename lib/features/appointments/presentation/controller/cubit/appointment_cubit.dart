import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/enum/request_state.dart';
import '../../../data/repository/appointment_repository.dart';
import '../states/appointment_state.dart';

class AppointmentCubit extends Cubit<AppointmentState> {
  AppointmentRepository appointmentRepository;

  AppointmentCubit({
    required this.appointmentRepository,
  }) : super(const AppointmentState());

  Future getDoctorAppointments({required String doctorId}) async {
    print('AppointmentCubit.getDoctorAppointments Clicked');
    final response =
        await appointmentRepository.getDoctorAppointments(doctorId: doctorId);

    response.fold(
        (failure) => emit(
              state.copyWith(
                doctorAppointmentState: RequestState.error,
                doctorAppointmentError: failure.toString(),
              ),
            ),
        (success) => emit(
              state.copyWith(
                doctorAppointmentState: RequestState.loaded,
                doctorAppointmentModel: success,
              ),
            ));
  }
}
