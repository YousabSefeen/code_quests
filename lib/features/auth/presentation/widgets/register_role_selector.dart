import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/themes/app_colors.dart';
import '../../../../core/enum/user_type.dart';

class RegisterRoleSelector extends StatefulWidget {
  const RegisterRoleSelector({super.key});

  @override
  State<RegisterRoleSelector> createState() => _RegisterRoleSelectorState();
}

class _RegisterRoleSelectorState extends State<RegisterRoleSelector> {
  UserType _selectedUserType = UserType.client;

  void _selectUserType(UserType type) {
    if (_selectedUserType != type) {
      setState(() => _selectedUserType = type);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 13, right: 13, bottom: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
           onTap: (){
             print('_selectedUserType ${_selectedUserType.name}');
            },

            child: Text(
              'Registering as',
              style: GoogleFonts.poppins(
                fontSize: 15.sp,
                color: AppColors.white,
                letterSpacing: 1,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(height: 10.h),
          Row(
            children: [
              Expanded(
                child: _RoleOption(
                  title: 'Client',
                  isActive: _selectedUserType == UserType.client,
                  onTap: () => _selectUserType(UserType.client),
                ),
              ),
              SizedBox(width: 20.w),
              Expanded(
                child: _RoleOption(
                  title: 'Doctor',
                  isActive: _selectedUserType == UserType.doctor,
                  onTap: () => _selectUserType(UserType.doctor),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _RoleOption extends StatelessWidget {
  final String title;
  final bool isActive;
  final VoidCallback onTap;

  const _RoleOption({
    required this.title,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        padding:   const EdgeInsets.symmetric(horizontal: 12, vertical: 8 ),
        decoration: ShapeDecoration(
          color: isActive ? Colors.green : Colors.black12,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: isActive
                ? BorderSide.none
                : const BorderSide(color: Colors.white70),
          ),

        ),
        child: Text(
          title,
          style: GoogleFonts.caladea(
            fontSize: 15.sp,
            color: Colors.white,
            letterSpacing: 1.2,

          ),  textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
