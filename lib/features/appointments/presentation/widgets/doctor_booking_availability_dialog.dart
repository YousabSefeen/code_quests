// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_task/core/constants/app_routes/app_router.dart';
// import 'package:flutter_task/core/enum/request_state.dart';
//
// import '../../../../core/constants/themes/app_colors.dart';
// import '../../../appointments/presentation/controller/cubit/appointment_cubit.dart';
// import '../../../appointments/presentation/controller/states/appointment_state.dart';
// import '../../../appointments/presentation/widgets/custom_action_button.dart';
// import 'custom_date_time_line.dart';
//
//
// class DoctorBookingAvailabilityDialog extends StatefulWidget {
//   final String doctorId;
//
//   const DoctorBookingAvailabilityDialog({super.key, required this.doctorId});
//
//   @override
//   State<DoctorBookingAvailabilityDialog> createState() =>
//       _DoctorBookingAvailabilityDialogState();
// }
//
// class _DoctorBookingAvailabilityDialogState
//     extends State<DoctorBookingAvailabilityDialog> {
//   @override
//   void initState() {
//     super.initState();
//
//     context
//         .read<AppointmentCubit>()
//         .getDoctorAppointments(doctorId: widget.doctorId);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final deviceSize = MediaQuery.sizeOf(context);
//     final deviceHeight = deviceSize.height;
//     final deviceWidth = deviceSize.width;
//     return   Scaffold(
//       appBar: AppBar(
//         title: Text('data')
//         ,
//       ),
//       body: SizedBox(
//         width: deviceWidth * 0.95,
//         height: deviceHeight * 0.6,
//         child: Column(
//           spacing: 16,
//           children: [
//             Container(
//               width: double.infinity,
//               color: Colors.amber,
//               child: Text('DoctorBookingAvailability'),
//             ),
//
//
//
//               Expanded(
//             child: SingleChildScrollView(
//               child: Padding(
//                 padding: const EdgeInsets.all(20),
//                 child: BlocBuilder<AppointmentCubit, AppointmentState>(
//                   builder: (context, state) {
//                     switch (state.doctorAppointmentState) {
//                       case RequestState.loading:
//                         return const Center(
//                             child: CircularProgressIndicator());
//                       case RequestState.loaded:
//                         return state.doctorAppointmentModel.isEmpty
//                             ? Center(
//                                 child: Text('doctorAppointmentModel.isEmpty'),
//                               )
//                             : Column(
//                                 spacing: 20,
//                                 children: [
//                                   Text(
//                                       '${state.doctorAppointmentModel[0].appointmentModel.date}'),
//                                   Text(
//                                       '${state.doctorAppointmentModel[0].appointmentModel.date}'),
//                                   Text(
//                                       '${state.doctorAppointmentModel[0].appointmentModel.time}'),
//                                   Text(
//                                       '${state.doctorAppointmentModel[0].appointmentModel.clientId}'),
//                                   Text(
//                                       'DoctorBookingAvailabilityDoctorBookingAvailabilityDoctorBookingAvailability '),
//                                   Text(
//                                       'DoctorBookingAvailabilityDoctorBookingAvailabilityDoctorBookingAvailability '),
//                                   Text(
//                                       'DoctorBookingAvailabilityDoctorBookingAvailabilityDoctorBookingAvailability '),
//                                   Text(
//                                       'DoctorBookingAvailabilityDoctorBookingAvailabilityDoctorBookingAvailability '),
//                                   Text(
//                                       'DoctorBookingAvailabilityDoctorBookingAvailabilityDoctorBookingAvailability '),
//                                   Text(
//                                       'DoctorBookingAvailabilityDoctorBookingAvailabilityDoctorBookingAvailability '),
//                                 ],
//                               );
//                       case RequestState.error:
//                         return Center(
//                             child: Text(
//                                 'doctorAppointmentError: ${state.doctorAppointmentError}'));
//                     }
//                   },
//                 ),
//               ),
//             ),
//           ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 CustomActionButton(
//                   text: 'Cancel',
//                   onPressed: () => AppRouter.pop(context),
//                   backgroundColor: Colors.white,
//                   textColor: Colors.black54,
//                   borderColor: Colors.grey,
//                 ),
//                 const SizedBox(width: 10),
//                 CustomActionButton(
//                   text: 'Confirm Booking',
//                   onPressed: () {
//                     // TODO: implement booking confirmation logic
//                   },
//                   backgroundColor: AppColors.green,
//                   textColor: Colors.white,
//                   borderColor: Colors.white70,
//                 ),
//                 const SizedBox(width: 20),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }