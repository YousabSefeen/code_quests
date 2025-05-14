import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/core/constants/app_assets/app_assets.dart';
import 'package:flutter_task/core/enum/lazy_request_state.dart';

import '../../../../core/constants/app_alerts/app_alerts.dart';
import '../../../../core/constants/app_routes/app_router.dart';
import '../../../../core/constants/app_routes/app_router_names.dart';
import '../../../../core/constants/app_strings/app_strings.dart';
import '../../../../core/constants/themes/app_colors.dart';
import '../controller/cubit/doctor_profile_cubit.dart';
import '../controller/states/doctor_profile_state.dart';
import '../widgets/doctor_availability_days_field.dart';
import '../widgets/doctor_availability_time_fields.dart';
import '../widgets/doctor_info_field.dart';
import '../widgets/doctor_profile_image.dart';


class DoctorProfileScreen extends StatefulWidget {
  const DoctorProfileScreen({super.key});

  @override
  State<DoctorProfileScreen> createState() => _DoctorProfileScreenState();
}

class _DoctorProfileScreenState extends State<DoctorProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _specializationController = TextEditingController();
  final _bioController = TextEditingController();
  final _locationController = TextEditingController();
  final _feesController = TextEditingController();
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _nameController.dispose();
    _specializationController.dispose();
    _bioController.dispose();
    _locationController.dispose();
    _feesController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.doctorProfileTitle)),
      body: BlocSelector<DoctorProfileCubit, DoctorProfileState, LazyRequestState>(
        selector: (state) => state.doctorProfileState,
        builder: (context, doctorProfileState) {

          if(doctorProfileState==LazyRequestState.loaded){
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
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.disabled,
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.topCenter,
                    child: DoctorProfileImage(),
                  ),
                  _buildTextField(
                    label: AppStrings.nameLabel,
                    hintText: AppStrings.nameHint,
                    controller: _nameController,
                    validator: _requiredFieldValidator(AppStrings.nameValidationMessage),
                  ),
                  _buildTextField(
                    label: AppStrings.specializationLabel,
                    hintText: AppStrings.specializationHint,
                    controller: _specializationController,
                    validator: _requiredFieldValidator(AppStrings.specializationValidationMessage),
                  ),
                  _buildTextField(
                    label: AppStrings.bioLabel,
                    hintText: AppStrings.bioHint,
                    controller: _bioController,
                    maxLines: 3,
                    validator: _requiredFieldValidator(AppStrings.bioValidationMessage),
                  ),
                  _buildTextField(
                    label: AppStrings.locationLabel,
                    hintText: AppStrings.locationHint,
                    controller: _locationController,
                    validator: _requiredFieldValidator(AppStrings.locationValidationMessage),
                  ),
                    DoctorAvailabilityDaysField(),
                  const DoctorAvailabilityTimeFields(),
                  _buildTextField(
                    label: AppStrings.feesLabel,
                    hintText: AppStrings.feesHint,
                    controller: _feesController,
                    keyboardType: TextInputType.number,
                    validator: _feeValidator,
                  ),
                  const SizedBox(height: 20),
                  _buildSaveButton(),
                ],
              ),
            ),
          ),
        );
        },
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required String hintText,
    required TextEditingController controller,
    int? maxLines=1,
    required String? Function(String?) validator,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return DoctorInfoField(
      label: label,
      hintText: hintText,
      controller: controller,
      maxLines: maxLines!,
      validator: validator,
      keyboardType: keyboardType,
    );
  }

  String? Function(String?) _requiredFieldValidator(String errorMessage) {
    return (value) {
      if (value == null || value.isEmpty) {
        return errorMessage;
      }
      return null;
    };
  }

  String? _feeValidator(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.feeValidationMessage;
    }
    final parsed = int.tryParse(value);
    if (parsed == null) {
      return AppStrings.feeInvalidMessage;
    }
    return null;
  }

  Widget _buildSaveButton() {
    return SizedBox(
      height: 55,
      width: double.infinity,
      child: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8))),
          backgroundColor: MaterialStateProperty.all(AppColors.green),
        ),
        onPressed: _submitDoctorProfile,
        child: const Text(
          AppStrings.saveButtonText,
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }

  void _submitDoctorProfile() {
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) {
      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _uploadDoctorProfile();
    }
  }

  void _uploadDoctorProfile() {
    context.read<DoctorProfileCubit>().uploadDoctorProfile(
      imageUrl: AppAssets.images[4],
      name: _nameController.text.trim(),
      specialization: _specializationController.text.trim(),
      bio: _bioController.text.trim(),
      location: _locationController.text.trim(),
      fees: int.parse(_feesController.text.trim()),
    );
  }
}
