import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomSliverAppBar extends StatelessWidget {
  final String doctorName;
  final String specialization;
  final String doctorImage;

  const CustomSliverAppBar(
      {super.key,
      required this.doctorName,
      required this.doctorImage,
      required this.specialization});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final deviceSize = MediaQuery.sizeOf(context);
    final deviceHeight = deviceSize.height;
    final deviceWidth = deviceSize.height;
    return SliverAppBar(
      pinned: true,
      expandedHeight: deviceHeight * 0.32,
      flexibleSpace: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final isCollapsed = constraints.maxHeight <=
              kToolbarHeight + MediaQuery.of(context).padding.top;

          return FlexibleSpaceBar(
            title: isCollapsed
                ? Text(
                    doctorName,
                    style: textTheme.bodyMedium!.copyWith(
                      fontSize: 19.sp,
                    ),
                  )
                : null,
            background: Stack(
              alignment: Alignment.bottomLeft,
              children: [
                Image.network(
                  doctorImage,
                  fit: BoxFit.fill,
                  width: double.infinity,
                ),
                Container(
                  margin:
                      EdgeInsets.only(left: 16, bottom: deviceHeight * 0.05),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 3, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.black38,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  constraints: BoxConstraints(
                    maxWidth: deviceWidth * 0.52,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(doctorName, style: textTheme.bodyMedium),
                      Text(specialization, style: textTheme.bodySmall),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
