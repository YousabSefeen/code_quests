import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_task/core/constants/app_alerts/app_alerts.dart';
import 'package:flutter_task/core/constants/app_routes/app_router.dart';
import 'package:flutter_task/core/constants/app_routes/app_router_names.dart';
import 'package:flutter_task/core/constants/themes/app_colors.dart';
import 'package:flutter_task/features/appointments/presentation/controller/cubit/appointment_cubit.dart';
import 'package:flutter_task/features/appointments/presentation/widgets/select_date_and_time.dart';
import 'package:flutter_task/features/appointments/presentation/widgets/custom_sliver_app_bar.dart';
import 'package:flutter_task/features/doctor_profile/data/models/doctor_model.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/common_widgets/consultation_fee_and_wait_row.dart';
import '../../../../core/enum/lazy_request_state.dart';
import '../../../doctor_list/data/models/doctor_list_model.dart';
import '../controller/states/appointment_state.dart';
import '../widgets/doctor_info_header.dart';

 class CreateAppointmentScreen extends StatelessWidget {
   const CreateAppointmentScreen({super.key});

   @override
   Widget build(BuildContext context) {
     final DoctorListModel doctor =
     ModalRoute.of(context)!.settings.arguments as DoctorListModel;

     final DoctorModel doctorInfo = doctor.doctorModel;


     return Scaffold(
       backgroundColor: Colors.grey.shade50,

       bottomNavigationBar: Container(
         margin: const EdgeInsets.all(12.0),

         width: double.infinity,
         height: 50,
        child: BlocSelector<AppointmentCubit, AppointmentState,
            Tuple2<String?, LazyRequestState>>(
          selector: (state) => Tuple2(state.selectedTimeByUser, state.bookAppointmentState) ,
          builder: (context, values) {
            if (values.value2 == LazyRequestState.loaded) {
              WidgetsBinding.instance.addPostFrameCallback((_) {

                  AppAlerts.showAppointmentSuccessDialog(context);

                Future.delayed(const Duration(milliseconds:2500), () {
                  if (!context.mounted) return;
                     AppRouter.pushNamedAndRemoveUntil(context, AppRouterNames.doctorListView);

                });
                context
                    .read<AppointmentCubit>()
                    .deleteData();
              });
             }

             return ElevatedButton(
              onPressed: values.value1 == ''
                  ? null
                  : () {
                      context
                    .read<AppointmentCubit>()
                          .createAppointmentForDoctor(
                              doctorId: doctor.doctorId);
                    },
              style: ButtonStyle(
                backgroundColor:  WidgetStatePropertyAll( values.value1  =='' ?  Colors.grey.shade300:AppColors.softBlue),

               foregroundColor: WidgetStatePropertyAll( values.value1  ==''?   Colors.black: Colors.white),

             ),
              child: values.value1 != '' &&
                      values.value2 == LazyRequestState.loading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : Text(
                      'Book Appointment',
                      style:  GoogleFonts.raleway(
                    fontSize: 19.sp, fontWeight: FontWeight.w700,
               ),
             ),
            );
          },
        ),
      ),
       body: SafeArea(
         child: CustomScrollView(
           slivers: [
             CustomSliverAppBar(
                 doctorName: doctorInfo.name,
                 doctorImage: doctorInfo.imageUrl,
                 specialization: doctorInfo.specialization,
             ),
             SliverList(
                 delegate: SliverChildListDelegate([
                   Padding(
                     padding: const EdgeInsets.symmetric(horizontal: 8),
                     child: Column(
                       spacing: 20,
                       children: [
                         const SizedBox(height: 5),
                         DoctorInfoHeader(doctorInfo: doctorInfo),
                         ConsultationFeeAndWaitRow(   fee: doctorInfo.fees.toString()),
                         SelectDateAndTime(doctor: doctor),
                       ],
                     ),
                   ),
                 ])),
           ],
         ),
       ),
     );
   }
 }

