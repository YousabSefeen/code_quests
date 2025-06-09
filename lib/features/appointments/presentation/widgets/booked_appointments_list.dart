import 'package:flutter/material.dart';
import 'package:flutter_task/features/appointments/presentation/widgets/upcoming_appointments_list.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/app_strings/app_strings.dart';
import '../../data/models/client_appointments_model.dart';
import 'cancelled_appointments_list.dart';
import 'completed_appointments_list.dart';

class BookedAppointmentsList extends StatelessWidget {
  final List<ClientAppointmentsModel> appointmentsList;

  const BookedAppointmentsList({super.key, required this.appointmentsList});

  @override
  Widget build(BuildContext context) {
    List<Widget> appointmentCategories = [
      const UpcomingAppointmentsList( ),
      const CompletedAppointmentsList( ),
      const CancelledAppointmentsList(),
    ];
    return DefaultTabController(
      length: appointmentCategories.length,
      child: Column(
        children: [
          customTabBar(context),
          Expanded(
            child: TabBarView(
              children: appointmentCategories,
            ),
          ),
        ],
      ),
    );
  }

  Widget customTabBar(BuildContext context) {
    Size deviceSize = MediaQuery.sizeOf(context);

    return Container(
      height: deviceSize.height * 0.055,
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.amber,
        borderRadius: BorderRadius.circular(17),
      ),
      child: TabBar(
        isScrollable: true,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(17),
          color: Colors.blue,
        ),
        labelColor: Colors.white,
        labelStyle: GoogleFonts.raleway(
          textStyle: TextStyle(
            fontSize: MediaQuery.sizeOf(context).width * 0.03,
            fontWeight: FontWeight.w800,
          ),
        ),
        unselectedLabelColor: Colors.black,
        tabs: AppStrings.appointmentsListTitles
            .map((title) => Tab(text: title))
            .toList(),
      ),
    );
  }
}

