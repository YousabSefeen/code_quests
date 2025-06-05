import 'package:get_it/get_it.dart';

import '../../features/appointments/data/repository/appointment_repository.dart';
import '../../features/appointments/presentation/controller/cubit/appointment_cubit.dart';
import '../../features/auth/data/repository/auth_repository.dart';
import '../../features/auth/presentation/controller/cubit/login_cubit.dart';
import '../../features/auth/presentation/controller/cubit/register_cubit.dart';
import '../../features/doctor_list/data/repository/doctor_list_repository.dart';
import '../../features/doctor_list/presentation/controller/cubit/doctor_list_cubit.dart';
import '../../features/doctor_profile/data/repository/doctor_profile_repository.dart';
import '../../features/doctor_profile/presentation/controller/cubit/doctor_profile_cubit.dart';
import '../app_settings/controller/cubit/app_settings_cubit.dart';

final serviceLocator = GetIt.instance;

class ServiceLocator {
  void init() {
    _registerRepositories();
    _registerCubits();
    _registerAppSettings();
  }

  void _registerRepositories() {
    serviceLocator.registerLazySingleton<AuthRepository>(() => AuthRepository());
    serviceLocator.registerLazySingleton<DoctorProfileRepository>(() => DoctorProfileRepository());
    serviceLocator.registerLazySingleton<DoctorListRepository>(() => DoctorListRepository());
    serviceLocator.registerLazySingleton<AppointmentRepository>(() => AppointmentRepository());
  }

  void _registerCubits() {
    serviceLocator.registerFactory<LoginCubit>(
          () => LoginCubit(authRepository: serviceLocator()),
    );

    serviceLocator.registerFactory<RegisterCubit>(
          () => RegisterCubit(authRepository: serviceLocator()),
    );

    serviceLocator.registerFactory<DoctorProfileCubit>(
          () => DoctorProfileCubit(doctorRepository: serviceLocator()),
    );

    serviceLocator.registerFactory<DoctorListCubit>(
          () => DoctorListCubit(doctorListRepository: serviceLocator()),
    );

    serviceLocator.registerFactory<AppointmentCubit>(
          () => AppointmentCubit(
        appSettingsCubit: serviceLocator(),
        appointmentRepository: serviceLocator(),
      ),
    );
  }

  void _registerAppSettings() {
    serviceLocator.registerLazySingleton<AppSettingsCubit>(() {
      final cubit = AppSettingsCubit();
      cubit.checkInitialInternetConnection();
      cubit.startMonitoring();
      return cubit;
    });
  }
}
