import 'package:flutter/material.dart';

class DoctorProfileHeader extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String bio;

  const DoctorProfileHeader(
      {super.key,
      required this.imageUrl,
      required this.name,
      required this.bio});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        radius: 40,
        backgroundImage: NetworkImage(imageUrl),
      ),
      title: Text(name),
      subtitle: Text(bio),
    );
  }
}
