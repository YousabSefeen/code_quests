import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../../doctor_profile/presentation/controller/cubit/doctor_profile_cubit.dart';
import '../controller/cubit/doctor_list_cubit.dart';
import '../widgets/custom_drawer.dart';


class DoctorListViewScreen extends StatefulWidget {
  const DoctorListViewScreen({super.key});

  @override
  State<DoctorListViewScreen> createState() => _DoctorListViewScreenState();
}

class _DoctorListViewScreenState extends State<DoctorListViewScreen> {
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 20,
          children: [



         ElevatedButton(onPressed: ()async{
           await  context.read<DoctorListCubit>().getDoctors();


            }, child: Text('get Doctors')),

            ElevatedButton(onPressed: ()async{


                final doctors=  context.read<DoctorListCubit>().doctors;

                print('******************************');

                print(' ${doctors }');
                print('******************************');
                }, child: Text('doctor 1111')),

            ElevatedButton(onPressed: ()async{


              final doctors=  context.read<DoctorListCubit>().doctors;

              print('******************************');
              print(' ${doctors[1].doctorId}');
              print(' ${doctors[1].doctorModel.name}');
              print('******************************');
            }, child: Text('doctor 222222')),
          ],
        ),
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

