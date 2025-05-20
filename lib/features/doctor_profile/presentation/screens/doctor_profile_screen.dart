import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/core/enum/lazy_request_state.dart';

import '../../../../core/constants/app_alerts/app_alerts.dart';
import '../../../../core/constants/app_routes/app_router.dart';
import '../../../../core/constants/app_routes/app_router_names.dart';
import '../../../../core/constants/app_strings/app_strings.dart';
import '../controller/cubit/doctor_profile_cubit.dart';
import '../controller/form_controllers/doctor_profile_controllers.dart';
import '../controller/form_controllers/doctor_profile_validator.dart';
import '../controller/states/doctor_profile_state.dart';
import '../widgets/doctor_profile_body.dart';

class DoctorProfileScreen extends StatefulWidget {
  const DoctorProfileScreen({super.key});

  @override
  State<DoctorProfileScreen> createState() => _DoctorProfileScreenState();
}

class _DoctorProfileScreenState extends State<DoctorProfileScreen> {
  late final DoctorProfileControllers doctorProfileControllers;

  late final DoctorProfileValidator doctorProfileValidator;
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    doctorProfileControllers = DoctorProfileControllers();
    doctorProfileValidator = DoctorProfileValidator();
  }

  @override
  void dispose() {
    doctorProfileControllers.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text(AppStrings.doctorProfileTitle)),
      body: BlocSelector<DoctorProfileCubit, DoctorProfileState,
          LazyRequestState>(
        selector: (state) => state.doctorProfileState,
        builder: (context, doctorProfileState) {
          if (doctorProfileState == LazyRequestState.loaded) {
            Future.microtask(() {
              if (!context.mounted) return;
              AppAlerts.showAppointmentSuccessDialog(
                context: context,
                message: 'Successfully',
              );
              Future.delayed(const Duration(milliseconds: 1500), () {
                if (!context.mounted) return;
                AppRouter.pushNamedAndRemoveUntil(
                  context,
                  AppRouterNames.doctorListView,
                );
                context.read<DoctorProfileCubit>().resetStates();
              });
            });
          }
          return Padding(
            //padding: const EdgeInsets.all(16.0),
            padding: const EdgeInsets.symmetric(vertical: 16.0,horizontal: 10),
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Form(
                key: doctorProfileControllers.formKey,
                autovalidateMode: AutovalidateMode.disabled,
                child: DoctorProfileBody(
                  doctorProfileControllers: doctorProfileControllers,
                    doctorProfileValidator:doctorProfileValidator,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
