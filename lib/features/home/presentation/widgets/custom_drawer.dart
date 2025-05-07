import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/app_routes/app_router.dart';
import '../../../../core/constants/app_routes/app_router_names.dart';
import '../../../auth/presentation/controller/cubit/login_cubit.dart';


class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return  Drawer(
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
          ),
          ElevatedButton(
            onPressed: () {
              context.read<LoginCubit>().logout();
              AppRouter.pushNamedAndRemoveUntil(
                  context, AppRouterNames.login);
            },
            child: Text('Logout'),
          ),
        ],
      ),
    );
  }
}
