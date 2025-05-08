
import 'package:flutter/material.dart';
import 'package:flutter_task/features/doctor_list/presentation/screen/doctor_list_view_screen.dart';

import '../../../features/auth/presentation/screens/login_screen.dart';
import '../../../features/auth/presentation/screens/register_screen.dart';
import '../../../features/doctor_profile/presentation/screens/doctor_profile_screen.dart';

import '../../animations/animation_route.dart';
import 'app_router_names.dart';

class AppRouter {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {


        case AppRouterNames.login:
        return _animatedRoute(settings, const LoginScreen());
      case AppRouterNames.register:
        return _animatedRoute(settings, const RegisterScreen());
      // case AppRouterNames.emailVerification:
      //   return _animatedRoute(settings, const EmailVerificationScreen());

      case AppRouterNames.doctorProfile:
        return _animatedRoute(settings, const DoctorProfileScreen());
      case AppRouterNames.doctorListView:
        return _animatedRoute(settings, const DoctorListViewScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }

  static AnimatedRoute _animatedRoute(RouteSettings settings, Widget screen) {
    return AnimatedRoute(
      builder: (_) => screen,
      arguments: settings.arguments,
    );
  }

  static pushNamed(BuildContext context, String screenName,
          {Object? arguments}) =>
      Navigator.of(context).pushNamed(screenName, arguments: arguments);

  static pushNamedAndRemoveUntil(BuildContext context, String screenName,
          {Object? arguments}) =>
      Navigator.of(context).pushNamedAndRemoveUntil(
        screenName, (Route<dynamic> route) => false,
          arguments: arguments);
   static pop(BuildContext context)=> Navigator.pop(context);
}
