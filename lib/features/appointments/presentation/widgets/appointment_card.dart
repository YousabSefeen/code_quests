import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_task/core/constants/app_strings/app_strings.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../data/models/client_appointments_model.dart';
import 'icon_with_text.dart';

class AppointmentCard extends StatelessWidget {
  final ClientAppointmentsModel appointment;

  const AppointmentCard({super.key, required this.appointment});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      height: MediaQuery.sizeOf(context).height * 0.12,
      margin: const EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          _DoctorImage(imageUrl: appointment.imageUrl),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only( left: 5, right: 10, top: 8, bottom: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  _DoctorNameRow(name: appointment.name),

                  Text(
                    appointment.specialization,
                    style: Theme.of(context)
                        .listTileTheme
                        .subtitleTextStyle!
                        .copyWith(fontSize: 14.sp),
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconWithText(
                        icon: Icons.calendar_month,
                        text: appointment.date,
                        textStyle: textTheme.labelMedium!,
                      ),
                      IconWithText(
                        icon: Icons.alarm,
                        text: appointment.time,
                        textStyle: textTheme.labelMedium!,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DoctorImage extends StatelessWidget {
  final String imageUrl;

  const _DoctorImage({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.horizontal(left: Radius.circular(10)),
      child: CachedNetworkImage(
        width: MediaQuery.sizeOf(context).width * 0.3,
        height: double.infinity,
        fit: BoxFit.fill,
        imageUrl: imageUrl,
        placeholder: (context, url) =>
            const Center(child: CircularProgressIndicator()),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    );
  }
}

class _DoctorNameRow extends StatelessWidget {
  final String name;

  const _DoctorNameRow({required this.name});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        Expanded(
          child: Text(
            AppStrings.dR + name,
            style: textTheme.headlineLarge,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(width: 10),
        FaIcon(
          FontAwesomeIcons.chevronDown,
          color: Colors.black,
          size: 17.sp,
        ),
      ],
    );
  }
}
