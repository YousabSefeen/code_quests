import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ConsultationFeeAndWaitRow extends StatelessWidget {
  final String fee;

  const ConsultationFeeAndWaitRow({super.key, required this.fee});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const InfoIconWithText(
          icon: FontAwesomeIcons.clockRotateLeft,
          title: 'Waiting Time',
          subtitle: '15 min',
        ),
        InfoIconWithText(
          icon: FontAwesomeIcons.dollarSign,
          title: 'Consultation Fee',
          subtitle: '$fee EGP',
        ),
      ],
    );
  }
}

class InfoIconWithText extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const InfoIconWithText({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final titleMedium = Theme.of(context).textTheme.titleMedium;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10,
      children: [
        FaIcon(icon, color: Colors.blue),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: titleMedium,
            ),
            Text(
              subtitle,
              style: titleMedium!.copyWith(color: Colors.blue),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ],
    );
  }
}
