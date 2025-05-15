import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_task/features/auth/presentation/controller/cubit/login_cubit.dart';
import 'package:flutter_task/features/auth/presentation/screens/login_screen.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'core/constants/app_routes/app_router.dart';
import 'core/constants/themes/app_light_theme.dart';
import 'core/base/my_bloc_observer.dart';
import 'core/services/server_locator.dart';
import 'features/appointments/presentation/controller/cubit/appointment_cubit.dart';
import 'features/auth/presentation/controller/cubit/register_cubit.dart';
import 'features/doctor_list/presentation/controller/cubit/doctor_list_cubit.dart';
import 'features/doctor_list/presentation/screen/doctor_list_view_screen.dart';
import 'features/doctor_profile/presentation/controller/cubit/doctor_profile_cubit.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('en_US');
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
    BlocProvider(
      create: (_) => serviceLocator<LoginCubit>(),
    ),
    BlocProvider(
      create: (_) => serviceLocator<RegisterCubit>(),
    ),
    BlocProvider(
      create: (_) => serviceLocator<DoctorProfileCubit>(),
    ),
    BlocProvider(
      create: (_) => serviceLocator<DoctorListCubit>(),
    ),
    BlocProvider(
      create: (_) => serviceLocator<AppointmentCubit>(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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

        themeMode: ThemeMode.light,
        onGenerateRoute: AppRouter.generateRoute,

        home: FirebaseAuth.instance.currentUser == null
            ? const LoginScreen()
            : const DoctorListViewScreen(),
        // home: WelcomeFormScreen(),
      ),
    );
  }
}

class WelcomeFormScreen extends StatefulWidget {
  const WelcomeFormScreen({super.key});

  @override
  State<WelcomeFormScreen> createState() => _WelcomeFormScreenState();
}

class _WelcomeFormScreenState extends State<WelcomeFormScreen> {
  final TextEditingController firstFieldController = TextEditingController();
  final TextEditingController secondFieldController = TextEditingController();
  final FocusNode focusNode1 = FocusNode();
  final FocusNode focusNode2 = FocusNode();

  @override
  void dispose() {
    firstFieldController.dispose();
    secondFieldController.dispose();
    focusNode1.dispose();
    focusNode2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final keyboardPadding = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // 👋 الترحيب
                  Container(
                    height: screenHeight * 0.4,
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "مرحباً بك 👋",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "نحن سعداء برؤيتك! يرجى إدخال التفاصيل للمتابعة.",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 🟦 الزر الثابت فوق الكيبورد
          Positioned(
            bottom: keyboardPadding > 0 ? keyboardPadding + 10 : 30,
            left: 16,
            right: 16,
            child: Column(
              children: [
                const SizedBox(height: 30),

                // 📝 الحقول
                TextFormField(
                  controller: firstFieldController,
                  focusNode: focusNode1,
                  decoration: const InputDecoration(labelText: 'الحقل الأول'),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: secondFieldController,
                  focusNode: focusNode2,
                  decoration: const InputDecoration(labelText: 'الحقل الثاني'),
                ),
                ElevatedButton(
                  onPressed: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    // زر الإرسال
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2575FC),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'إرسال',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
