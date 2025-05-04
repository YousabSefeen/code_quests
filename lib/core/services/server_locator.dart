
import 'package:flutter_task/features/auth/presentation/controller/cubit/login_cubit.dart';
import 'package:get_it/get_it.dart';

import '../../features/auth/data/repository/auth_repository.dart';


final sl = GetIt.instance;

class ServicesLocator {
  void init() {
    /// تسجيل الخدمات الأساسية
    //******************************* sl.registerLazySingleton<ApiServices>(() => ApiServices());

    /// خدمات الدفع Paymob
    sl.registerLazySingleton<LoginCubit>(
        () => LoginCubit(authRepository: sl()));
    // sl.registerLazySingleton<RegisterProvider>(
    //     () => RegisterProvider(authRepository: sl()));

    sl.registerLazySingleton<AuthRepository>(() => AuthRepository());

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
