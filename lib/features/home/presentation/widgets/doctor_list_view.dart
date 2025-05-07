import 'package:flutter/material.dart';

import 'doctor_profile_card.dart';

class DoctorListView extends StatelessWidget {
  const DoctorListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 20,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      itemBuilder: (context, index) => const DoctorProfileCard(),
    );
  }
}
