import 'package:flutter/material.dart';
import 'package:flutter_task/features/home/presentation/widgets/doctor_availability_time_fields.dart';
import 'package:intl/intl.dart';

import '../widgets/doctor_availability_days_field.dart';
import '../widgets/doctor_info_field.dart';

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Doctor Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              DoctorInfoField(
                label: 'Name',
                hintText: 'Enter your full name',
                controller: _nameController,

              ),
              DoctorInfoField(
                label: 'Specialization',
                hintText: 'Enter your medical specialization',
                controller: _specializationController,
              ),
              DoctorInfoField(
                label: 'Bio',
                hintText: 'Write a short bio about your experience and expertise',
                controller: _bioController,
                maxLines: 3,
              ),
              DoctorInfoField(
                label: 'Location',
                hintText: 'Enter your clinic or hospital location',
                controller: _locationController,
              ),
              DoctorAvailabilityDaysField(),
              const DoctorAvailabilityTimeFields(),

              DoctorInfoField(
                label: 'Fees',
                hintText: 'Enter your consultation fees',
                controller: _feesController,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: (){

                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
