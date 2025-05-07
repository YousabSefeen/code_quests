import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/core/constants/app_assets/app_assets.dart';

import '../../../../core/constants/themes/app_colors.dart';
import '../controller/cubit/doctor_profile_cubit.dart';
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

  final _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Doctor Profile')),
      body: Padding(
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
                DoctorInfoField(
                  label: 'Name',
                  hintText: 'Enter your full name',
                  controller: _nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                DoctorInfoField(
                  label: 'Specialization',
                  hintText: 'Enter your medical specialization',
                  controller: _specializationController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your medical specialization';
                    }
                    return null;
                  },
                ),
                DoctorInfoField(
                  label: 'Bio',
                  hintText:
                      'Write a short bio about your experience and expertise',
                  controller: _bioController,
                  maxLines: 3,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a short bio about yourself';
                    }
                    return null;
                  },
                ),
                DoctorInfoField(
                  label: 'Location',
                  hintText: 'Enter your clinic or hospital location',
                  controller: _locationController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your clinic or workplace location';
                    }
                    return null;
                  },
                ),
                DoctorAvailabilityDaysField(),
                const DoctorAvailabilityTimeFields(),
                DoctorInfoField(
                    label: 'Fees',
                    hintText: 'Enter your consultation fees',
                    controller: _feesController,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your consultation fee';
                      }
                      final parsed = int.tryParse(value);
                      if (parsed == null) {
                        return 'Fee must be a valid integer number';
                      }
                      return null;
                    }),
                const SizedBox(height: 20),
                SizedBox(
                  height: 55,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8))),
                      backgroundColor: WidgetStatePropertyAll(AppColors.green),
                    ),
                    onPressed: () => _submitDoctorProfile(),
                    child: const Text(
                      'Save',
                      style: TextStyle(fontSize: 20),
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

  _submitDoctorProfile() {
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) {
      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );

    }else{

      _uploadDoctorProfile();
    }
  }

  void _uploadDoctorProfile() =>
      context.read<DoctorProfileCubit>().uploadDoctorProfile(
            imageUrl: AppAssets.images[1],
            name: _nameController.text.trim(),
            specialization: _specializationController.text.trim(),
            bio: _bioController.text.trim(),
            location: _locationController.text.trim(),
            fees: int.parse(_feesController.text.trim()),
          );
}
