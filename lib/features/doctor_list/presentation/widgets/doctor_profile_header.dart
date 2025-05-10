import 'package:flutter/material.dart';

import '../../../doctor_profile/data/models/doctor_model.dart';

class DoctorProfileHeader extends StatelessWidget {
  final DoctorModel doctorInfo;

  const DoctorProfileHeader(
      {super.key, required this.doctorInfo});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        radius: 40,
        backgroundImage: NetworkImage(doctorInfo.imageUrl),
      ),
      title: Text(doctorInfo.name),
      subtitle: Text(doctorInfo.bio),
    );
  }
}
