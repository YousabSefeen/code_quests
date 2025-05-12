import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_task/features/auth/presentation/controller/cubit/login_cubit.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'core/constants/app_routes/app_router.dart';
import 'core/constants/themes/app_dark_theme.dart';
import 'core/constants/themes/app_light_theme.dart';
import 'core/my_bloc_observer.dart';
import 'core/services/server_locator.dart';
import 'features/appointments/presentation/controller/cubit/appointment_cubit.dart';
import 'features/auth/presentation/controller/cubit/register_cubit.dart';
import 'features/doctor_list/presentation/controller/cubit/doctor_list_cubit.dart';
import 'features/doctor_profile/presentation/controller/cubit/doctor_profile_cubit.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
    await initializeDateFormatting('en_US' );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  Bloc.observer = MyBlocObserver();
  ServicesLocator().init();
  await Future.wait([
    Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    ),
  ]);
  runApp(MultiBlocProvider(providers: [
    BlocProvider (
      create: (_) =>serviceLocator<LoginCubit>()    ,
    ),
    BlocProvider (
      create: (_) => serviceLocator<RegisterCubit>(),
    ),
    BlocProvider (
      create: (_) => serviceLocator<DoctorProfileCubit>(),
    ),
    BlocProvider (
      create: (_) => serviceLocator<DoctorListCubit>(),
    ),
    BlocProvider (
     create: (_) => serviceLocator<AppointmentCubit>() ,

    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MaterialApp(
        title: 'Flutter task',
        debugShowCheckedModeBanner: false,
        theme: AppLightTheme.theme,
        darkTheme: AppDarkTheme.theme,
        themeMode: ThemeMode.light,
        onGenerateRoute: AppRouter.generateRoute,
        initialRoute: '/',
      ),
    );
  }
}



