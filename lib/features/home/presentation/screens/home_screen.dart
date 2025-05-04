import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/core/constants/app_routes/app_router.dart';
import 'package:flutter_task/core/constants/app_routes/app_router_names.dart';
import 'package:flutter_task/features/auth/presentation/controller/cubit/login_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    print('HomeScreen.build');
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: Center(
        child: Column(
          spacing: 40,
          children: [
            ElevatedButton(
                onPressed: () {
                  context.read<LoginCubit>().logout();
                  AppRouter.pushNamedAndRemoveUntil(context, AppRouterNames.login);
                },
                child: Text('Logout'),
            ),

            ElevatedButton(
                onPressed:()=>uploadDummySpecialistsToFirebase(),
                child: Text('UploadData')),
            ElevatedButton(
                onPressed: ()=> getDummySpecialistsToFirebase(),
                child: Text('GetData')),
          ],
        ),
      ),
    );
  }
  Future<void> uploadDummySpecialistsToFirebase() async {
    try {
      final firestore = FirebaseFirestore.instance;
      final specialistsCollection = firestore.collection('specialists');

     final response= await specialistsCollection.add({
        'userName':'user',
        'phoneNumber':'01227155559',
        'country':'egypt',
      });
      print('Response $response');
    } catch (e) {
      print('Failed to upload   $e');
    }



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
