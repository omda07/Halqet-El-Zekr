import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/color_manager.dart';
import '../../../../core/widgets/text_custom/text_custom.dart';

class RowTime extends StatelessWidget {
  final String text;
  final String icon;
  final String time;

  const RowTime(
      {super.key, required this.text, required this.icon, required this.time});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(
        bottom: 10.h,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 12.w,
        vertical: 10.h,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey[100]!,
            offset: const Offset(0.0, 3.0), //(x,y)
            blurRadius: 1.0,
          ),
        ],
        color: ColorManager.cardColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset(
            icon,
            width: 27,
            height: 27,
          ),
          TextCustom(
            // height: 0.0,
            text: text,
            fontSize: 24.sp,
          ),
          TextCustom(
            // height: 0.0,
            text: time,
            fontSize: 24.sp,
          ),
        ],
      ),
    );
  }
}
