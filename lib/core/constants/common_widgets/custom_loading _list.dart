import 'package:flutter/material.dart';

import 'custom_shimmer.dart';

class CustomLoadingList extends StatelessWidget {
  final double height;

  const CustomLoadingList({super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.sizeOf(context);
    return Column(
      children: [
        SizedBox(
          height: deviceSize.height * 0.88,
          child: ListView.builder(
            itemCount: 20,
            itemBuilder: (context, index) => CustomShimmer(
              height: height,
              width: deviceSize.width * 8,
            ),
          ),
        ),
      ],
    );
  }
}
