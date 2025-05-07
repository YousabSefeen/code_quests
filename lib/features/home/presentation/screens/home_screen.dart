import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/core/constants/app_assets/app_assets.dart';
import 'package:flutter_task/features/home/presentation/controller/cubit/doctor_profile_cubit.dart';
import 'package:flutter_task/features/home/presentation/widgets/appointment_booking_button.dart';
import 'package:flutter_task/features/home/presentation/widgets/custom_drawer.dart';
import 'package:flutter_task/features/home/presentation/widgets/doctor_list_view.dart';
import 'package:flutter_task/features/home/presentation/widgets/doctor_location_display.dart';
import 'package:flutter_task/features/home/presentation/widgets/doctor_profile_header.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../widgets/doctor_profile_card.dart';
import '../widgets/info_icon_with_text.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    print('HomeScreen.build');
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(title: const Text('Home Screen')),
     // body:  const DoctorListView(),
      body:  Center(
        child: ElevatedButton(onPressed: (){
          context.read<DoctorProfileCubit>().getDoctors();
        }, child: Text('data')),
      ),
    );
  }



  Future<void> getDummySpecialistsToFirebase() async {
    try {
      final firestore = FirebaseFirestore.instance;
      final querySnapshot = await firestore.collection('specialists').get();

      for (var doc in querySnapshot.docs) {
        print('Document ID: ${doc.id}');
        print('Data: ${doc.data()}');
      }
    } catch (e) {
      print('Failed to fetch data: $e');
    }
  }
}

