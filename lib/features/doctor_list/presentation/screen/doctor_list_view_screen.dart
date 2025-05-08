import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/core/enum/request_state.dart';
import 'package:flutter_task/features/doctor_list/presentation/widgets/doctor_list_view.dart';

import '../controller/cubit/doctor_list_cubit.dart';
import '../controller/states/doctor_list_state.dart';
import '../widgets/custom_drawer.dart';


class DoctorListViewScreen extends StatefulWidget {
  const DoctorListViewScreen({super.key});

  @override
  State<DoctorListViewScreen> createState() => _DoctorListViewScreenState();
}

class _DoctorListViewScreenState extends State<DoctorListViewScreen> {
  @override
  Widget build(BuildContext context) {
    print('_DoctorListViewScreenState.build');
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(title: const Text('Home Screen')),
     // body:  const DoctorListView(),
      body: BlocBuilder<DoctorListCubit, DoctorListState>(
        buildWhen: (previous, current) =>
            previous.doctorListState != current.doctorListState,
        builder: (context, state) {
          switch (state.doctorListState) {
            case RequestState.loading:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case RequestState.loaded:
              return DoctorListView(doctorList: state.doctorList);
            case RequestState.error:
              return Center(
                child: Text(
                  state.doctorListError,
                  style: const TextStyle(fontSize: 30, color: Colors.red),
                ),
              );
          }
        },
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

