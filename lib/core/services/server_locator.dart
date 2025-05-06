
import 'package:flutter_task/features/auth/presentation/controller/cubit/login_cubit.dart';
import 'package:flutter_task/features/home/presentation/controller/cubit/doctor_profile_cubit.dart';
import 'package:get_it/get_it.dart';

import '../../features/auth/data/repository/auth_repository.dart';
import '../../features/auth/presentation/controller/cubit/register_cubit.dart';
import '../../features/home/data/repository/doctor_profile_repository.dart';


final sl = GetIt.instance;

class ServicesLocator {
  void init() {
    /// تسجيل الخدمات الأساسية
    //******************************* sl.registerLazySingleton<ApiServices>(() => ApiServices());

    /// خدمات الدفع Paymob
    sl.registerFactory<LoginCubit>(
        () => LoginCubit(authRepository: sl()));

    sl.registerFactory<RegisterCubit>(
        () => RegisterCubit(authRepository: sl()));



    sl.registerFactory<DoctorProfileCubit>(
            () => DoctorProfileCubit(doctorRepository: sl() ));

    // sl.registerLazySingleton<RegisterProvider>(
    //     () => RegisterProvider(authRepository: sl()));
//TODO Repository
    sl.registerLazySingleton<AuthRepository>(() => AuthRepository());
    sl.registerLazySingleton<DoctorProfileRepository>(() => DoctorProfileRepository());

    //   /// مزود الحالة Paymob
    //   sl.registerFactory(() => PaymobPaymentProvider(paymobRepository: sl()));
    //
    //   /// خدمات الدفع stripe
    //   sl.registerLazySingleton<StripeServices>(
    //       () => StripeServices(apiServices: sl()));
    //   sl.registerLazySingleton<StripeRepo>(
    //       () => StripeRepo(stripeServices: sl()));
    //
    //   /// مزود الحالة stripe
    //   sl.registerFactory(() => StripePaymentProvider(stripeRepo: sl()));
    // }
  }
}
