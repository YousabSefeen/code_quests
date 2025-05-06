import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_task/core/constants/app_routes/app_router.dart';
import 'package:flutter_task/core/constants/app_routes/app_router_names.dart';
import 'package:flutter_task/features/auth/presentation/controller/cubit/login_cubit.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    print('HomeScreen.build');
    return Scaffold(
      drawer: Drawer(
        width: 230,
        child: Column(
          spacing: 20,
          children: [
            Container(
              height: 200,
              width: double.infinity,
              color: Colors.black,
              child: Center(
                child: Text(
                  'MediLink',
                  style: GoogleFonts.poppins(
                    fontSize: 36.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,

                  ),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.manage_accounts,size: 16.sp,color: Colors.black),
              title: const Text('Doctor Panel') ,
              trailing: Icon(Icons.arrow_forward_ios,size: 18.sp,color: Colors.blue),
              onTap: () {
                Navigator.pop(context);
                AppRouter.pushNamed(context, AppRouterNames.doctorPanel);
              },
            )
          ],
        ),
      ),
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
            GestureDetector(
              onTap: () {},
              child: Container(
                width: 400,
                height: 300,
                child: Text(
                  '${FirebaseAuth.instance.currentUser!.uid}',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            )
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
