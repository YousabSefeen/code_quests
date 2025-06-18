import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/core/constants/app_strings/app_strings.dart';
import 'package:flutter_task/features/appointments/presentation/controller/cubit/appointment_cubit.dart';
import 'package:flutter_task/features/appointments/presentation/controller/form_contollers/patient_fields_controllers.dart';
import 'package:flutter_task/features/appointments/presentation/controller/form_contollers/patient_fields_validator.dart';
import 'package:flutter_task/features/appointments/presentation/controller/states/appointment_state.dart';
import 'package:flutter_task/features/appointments/presentation/widgets/patient_widgets/pay_now_button.dart';
import 'package:flutter_task/features/doctor_profile/presentation/widgets/doctor_info_field.dart';

import '../widgets/patient_widgets/gender_dropdown_field.dart';

class PatientDetailsScreen extends StatefulWidget {
  const PatientDetailsScreen({super.key});

  @override
  State<PatientDetailsScreen> createState() => _PatientDetailsScreenState();
}

class _PatientDetailsScreenState extends State<PatientDetailsScreen> {
  late final PatientFieldsControllers _formControllers;
  late final PatientFieldsValidator _formValidator;

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  @override
  void dispose() {
    _formControllers.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final doctorId=ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildFormContent(doctorId),
    );
  }

  void _initializeControllers() {
    _formControllers = PatientFieldsControllers();
    _formValidator = PatientFieldsValidator();
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text(AppStrings.patientDetails),
    );
  }

  Widget _buildFormContent(String doctorId) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      child: BlocSelector<AppointmentCubit, AppointmentState, bool>(
        selector: (state) => state.hasValidatedBefore,
        builder: (context, hasValidatedBefore) => Form(
          key: _formControllers.formKey,
          autovalidateMode: hasValidatedBefore
              ? AutovalidateMode.always
              : AutovalidateMode.disabled,
          child: SizedBox(
            child: Column(
              spacing: 25,
              children: [
                _buildNameField(),
                _buildGenderField(),
                _buildAgeField(),
                _buildProblemField(),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: PayNowButton(
                      formControllers: _formControllers,
                      doctorId: doctorId,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNameField() => DoctorInfoField(
        label: AppStrings.fullNameLabel,
        hintText: AppStrings.fullNameHint,
        controller: _formControllers.nameController,
        validator: _formValidator.validateName,
      );

  Widget _buildGenderField() => GenderDropdownField(
        controller: _formControllers.genderController,
      );

  Widget _buildAgeField() => DoctorInfoField(
        label: AppStrings.ageLabel,
        hintText: AppStrings.ageHint,
        controller: _formControllers.ageController,
        keyboardType: TextInputType.number,
        validator: _formValidator.validateAge,
      );

  Widget _buildProblemField() => DoctorInfoField(
        label: AppStrings.problemLabel,
        hintText: AppStrings.problemHint,
        controller: _formControllers.problemController,
        maxLines: 4,
        validator: _formValidator.validateProblem,
      );
}
