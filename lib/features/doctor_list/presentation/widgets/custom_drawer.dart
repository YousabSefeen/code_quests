import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_task/core/constants/themes/app_colors.dart';
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
            color: AppColors.softBlue,
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
            title: FittedBox(
                child: Text(
              'Doctor Panel',
              style: TextStyle(fontSize: 15.sp),
            )),
            trailing: Icon(Icons.arrow_forward_ios,size: 18.sp,color: Colors.blue),
            onTap: () {
              Navigator.pop(context);
              AppRouter.pushNamed(context, AppRouterNames.doctorProfile);
            },
          ),
          ElevatedButton(
            onPressed: () {
              context.read<LoginCubit>().logout();
              AppRouter.pushNamedAndRemoveUntil(
                  context, AppRouterNames.login);
            },
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}
