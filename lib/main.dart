import 'dart:async';
import 'dart:developer' as developer;

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_task/core/app_settings/controller/cubit/app_settings_cubit.dart';
import 'package:flutter_task/core/enum/internet_state.dart';
import 'package:flutter_task/features/appointments/presentation/screens/patient_details_screen.dart';
import 'package:flutter_task/features/auth/presentation/controller/cubit/login_cubit.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:time_range/time_range.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

import 'core/app_settings/controller/states/app_settings_states.dart';
import 'core/constants/app_routes/app_router.dart';
import 'core/constants/themes/app_light_theme.dart';
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

  ///Bloc.observer = MyBlocObserver();
  ServiceLocator().init();
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
    BlocProvider(
      create: (_) =>
          serviceLocator<AppSettingsCubit>(),
    ),
  ], child: MyApp()));
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
              title: 'Flutter Task',
              debugShowCheckedModeBanner: false,
              theme: AppLightTheme.theme,
        themeMode: ThemeMode.light,
        onGenerateRoute: AppRouter.generateRoute,
              builder: (context, child) {
                return BlocListener<AppSettingsCubit, AppSettingsStates>(
                  listenWhen: (previous, current) =>
                      previous.internetState != current.internetState,
                  listener: (context, state) {
                    if (state.internetState == InternetState.disconnected) {
                      ScaffoldMessenger.of(context).clearSnackBars();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("🚫 لا يوجد اتصال بالإنترنت"),
                          duration: Duration(seconds: 3),
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.redAccent,
                        ),
                      );
                    } else if (state.internetState == InternetState.connected) {
                      ScaffoldMessenger.of(context).clearSnackBars();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("🚫 تم اتصال بالإنترنت"),
                          duration: Duration(seconds: 3),
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.green,
                        ),
                      );
                    }
                  },
                  child: child!,
                );
              },
             home: const DoctorListViewScreen(), // أو شاشتك الرئيسية
          ///  home: const PatientDetailsScreen(), // أو شاشتك الرئيسية
          //  home: const FirestoreTestScreen(), // أو شاشتك الرئيسية
            ));
  }
}

class FirestoreTestScreen extends StatefulWidget {
  const FirestoreTestScreen({super.key});

  @override
  State<FirestoreTestScreen> createState() => _FirestoreTestScreenState();
}

class _FirestoreTestScreenState extends State<FirestoreTestScreen> {
  List<ConnectivityResult> _connectionStatus = [ConnectivityResult.none];
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    initConnectivity();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }


    var xxx;
  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initConnectivity() async {
    late List<ConnectivityResult> result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
      xxx=result;
    } on PlatformException catch (e) {
      developer.log('Couldn\'t check connectivity status', error: e);
      return;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(List<ConnectivityResult> result) async {
    setState(() {
      _connectionStatus = result;
    });
    // ignore: avoid_print
    print('Connectivity changed: $_connectionStatus');
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Firestore اختبار")),
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [

              Text('data',style: TextStyle(fontSize: 30,color: Colors.black),),
              ElevatedButton(onPressed: (){
                print('_FirestoreTestScreenState.build ${xxx}');
              }, child: Text('data'))
            ],
          )
      ),
    );
  }
}

class NewPage extends StatelessWidget {
  const NewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('data'),
      ),
      body: Center(
        child: BlocBuilder<AppSettingsCubit, AppSettingsStates>(
          builder: (context, state) => Column(
            spacing: 30,
            children: [
              Container(
                height: 100,
                width: 100,
                color: state.internetState == InternetState.connected
                    ? Colors.amber
                    : Colors.blueAccent,
                child: Text('data'),
              ),
              ElevatedButton(onPressed: () {}, child: Text('xxxxxxxxxxxx')),
              ElevatedButton(
                  onPressed: () {
                    WoltModalSheet.show<void>(
                      context: context,
                      barrierDismissible: true,
                      pageListBuilder: (modalSheetContext) {
                        final textTheme = Theme.of(context).textTheme;
                        return [
                          WoltModalSheetPage(
                            hasSabGradient: false,
                            stickyActionBar: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                children: [
                                  // Container(
                                  //   height: 200,
                                  //   width: 200,color: Colors.amber,
                                  // ),
                                  //  const SizedBox(height: 8),
                                  //  Container(
                                  //    height: 200,
                                  //    width: 200,color: Colors.deepOrange,
                                  //  ),
                                ],
                              ),
                            ),
                            topBarTitle:
                                Text('Pagination', style: textTheme.titleSmall),
                            isTopBarLayerAlwaysVisible: true,
                            trailingNavBarWidget: IconButton(
                              padding: const EdgeInsets.all(20),
                              icon: const Icon(
                                Icons.close,
                                color: Colors.black,
                              ),
                              onPressed: Navigator.of(modalSheetContext).pop,
                            ),
                            child: Padding(
                                padding: EdgeInsets.fromLTRB(
                                  10,
                                  10,
                                  10,
                                  10,
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      height: 200,
                                      width: 200,
                                      color: Colors.amber,
                                    ),
                                    const SizedBox(height: 8),
                                    Container(
                                      height: 200,
                                      width: 200,
                                      color: Colors.deepOrange,
                                    ),
                                    Text(
                                      '''
              Pagination involves a sequence of screens the user navigates sequentially. We chose a lateral motion for these transitions. When proceeding forward, the next screen emerges from the right; moving backward, the screen reverts to its original position. We felt that sliding the next screen entirely from the right could be overly distracting. As a result, we decided to move and fade in the next page using 30% of the modal side.
              ''',
                                    ),
                                  ],
                                )),
                          )
                        ];
                      },
                      onModalDismissedWithBarrierTap: () {
                        debugPrint('Closed modal sheet with barrier tap');
                        Navigator.of(context).pop();
                      },
                    );
                  },
                  child: Text('data')),
            ],
          ),
        ),
      ),
    );
  }
}



class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const orange = Color(0xFFFE9A75);
  static const dark = Color(0xFF333A47);
  static const double leftPadding = 50;

  final _defaultTimeRange = TimeRangeResult(
    const TimeOfDay(hour: 8, minute: 00),
    const TimeOfDay(hour: 22, minute: 00),
  );
  TimeRangeResult? _timeRange;

  @override
  void initState() {
    super.initState();
    _timeRange = _defaultTimeRange;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 16, left: leftPadding),
              child: Text(
                'Opening Times',
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .copyWith(fontWeight: FontWeight.bold, color: dark),
              ),
            ),
            const SizedBox(height: 20),
            TimeRange(
              fromTitle: const Text(
                'FROM',
                style: TextStyle(
                  fontSize: 14,
                  color: dark,
                  fontWeight: FontWeight.w600,
                ),
              ),
              toTitle: const Text(
                'TO',
                style: TextStyle(
                  fontSize: 14,
                  color: dark,
                  fontWeight: FontWeight.w600,
                ),
              ),
              titlePadding: leftPadding,
              textStyle: const TextStyle(
                fontWeight: FontWeight.normal,
                color: dark,
              ),
              activeTextStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                color: orange,
              ),
              borderColor: dark,
              activeBorderColor: dark,
              backgroundColor: Colors.transparent,
              activeBackgroundColor: dark,
              firstTime: const TimeOfDay(hour: 8, minute: 00),
              lastTime: const TimeOfDay(hour: 20, minute: 00),
              initialRange: _timeRange,
              timeStep: 60,
              timeBlock: 60,
              onRangeCompleted: (range) => setState(() => _timeRange = range),
              onFirstTimeSelected: (startHour) {},
            ),
            const SizedBox(height: 30),
            if (_timeRange != null)
              Padding(
                padding: const EdgeInsets.only(top: 8.0, left: leftPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Selected Range: ${_timeRange!.start.format(context)} - ${_timeRange!.end.format(context)}',
                      style: const TextStyle(fontSize: 20, color: dark),
                    ),
                    const SizedBox(height: 20),
                    MaterialButton(
                      onPressed: () =>
                          setState(() => _timeRange = _defaultTimeRange),
                      color: orange,
                      child: const Text('Default'),
                    )
                  ],
                ),
              ),

            ElevatedButton(onPressed: (){
              print('_HomePageState.build');
                }, child: Text('data'))
          ],
        ),
      ),
    );
  }
}