import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
    as picker;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_task/core/constants/themes/app_colors.dart';
import 'package:intl/intl.dart';

import '../../../../core/utils/date_time_formatter.dart';
import '../widgets/doctor_info_field.dart';

class DoctorPanelScreen extends StatefulWidget {
  const DoctorPanelScreen({super.key});

  @override
  State<DoctorPanelScreen> createState() => _DoctorPanelScreenState();
}

class _DoctorPanelScreenState extends State<DoctorPanelScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _specializationController = TextEditingController();
  final _bioController = TextEditingController();
  final _locationController = TextEditingController();
  final _workingDaysController = TextEditingController();
  final _availableFromController = TextEditingController();
  final _availableToController = TextEditingController();
  final _feesController = TextEditingController();

  final Set<String> _selectedDays = {};

  static const List<String> _weekDays = [
    'Saturday',
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
  ];

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final doctorData = {
        'name': _nameController.text.trim(),
        'specialization': _specializationController.text.trim(),
        'bio': _bioController.text.trim(),
        'location': _locationController.text.trim(),
        'workingDays': _selectedDays.toList(),
        'availableFrom': _availableFromController.text.trim(),
        'availableTo': _availableToController.text.trim(),
        'fees': _feesController.text.trim(),
      };

      print('Doctor Data: $doctorData');
      // TODO: send to Firestore
    }
  }

  void _openDaySelectionDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Select Working Days'),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView(
              shrinkWrap: true,
              children: _weekDays.map((day) {
                return CheckboxListTile(
                  title: Text(day),
                  value: _selectedDays.contains(day),
                  onChanged: (bool? value) {
                    setState(() {
                      if (value == true) {
                        _selectedDays.add(day);
                      } else {
                        _selectedDays.remove(day);
                      }
                      _workingDaysController.text = _selectedDays.join(', ');
                    });
                  },
                );
              }).toList(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Done'),
            ),
          ],
        );
      },
    );
  }

  String time = DateFormat('hh:mm a').format(DateTime.now()).toString();
  String? _startTime;
  String? _endTime;
  void _openTimePicker( {required bool isStartTime }) {
    final headlineSmall = Theme.of(context).textTheme.headlineSmall;

    picker.DatePicker.showTime12hPicker(
      context,
      theme: picker.DatePickerTheme(
        containerHeight: MediaQuery.sizeOf(context).height * 0.24,
        headerColor: AppColors.darkBlue,
        backgroundColor: AppColors.white,
        itemStyle: headlineSmall!.copyWith(color: Colors.black),
        doneStyle: headlineSmall,
        cancelStyle: headlineSmall,
      ),
      showTitleActions: true,
      onConfirm: (newTime) {
    final timeString=DateTimeFormatter.timeString(newTime);
     isStartTime? _startTime=timeString:_endTime=timeString;

       print('date: $time');

      },
      currentTime: DateFormat('hh:mm a').parse(time),
    );
  }

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
                controller: _nameController,
              ),
              DoctorInfoField(
                label: 'Specialization',
                controller: _specializationController,
              ),
              DoctorInfoField(
                label: 'Bio',
                controller: _bioController,
                maxLines: 3,
              ),
              DoctorInfoField(
                label: 'Location',
                controller: _locationController,
              ),
              DoctorInfoField(
                label: 'Working Days',
                controller: _workingDaysController,

                hintText: _selectedDays.isEmpty
                    ? 'Select Working Days'
                    : _selectedDays.join(', '),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.calendar_month_outlined),
                  onPressed: _openDaySelectionDialog,
                ),
              ),
              Row(
                spacing: 7,
                children: [
                  Expanded(
                    child: DoctorInfoField(
                      label: 'Start Time',
                      hintText: _startTime??'Select Time',
                      controller: _availableFromController,
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.access_alarm_outlined),
                        onPressed: ()=>_openTimePicker(isStartTime: true),
                      ),
                    ),
                  ),
                  Expanded(
                    child: DoctorInfoField(
                      label: 'End Time',
                      hintText: _endTime?? 'Select Time',
                      controller: _availableToController,

                      suffixIcon: IconButton(
                        icon: const Icon(Icons.access_alarm_outlined),
                        onPressed: ()=>_openTimePicker(isStartTime: false),
                      ),
                    ),
                  ),
                ],
              ),
              DoctorInfoField(
                label: 'Fees',
                controller: _feesController,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
