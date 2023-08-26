import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/color_manager.dart';
import '../../../../core/widgets/text_custom/text_custom.dart';

class ListItemCustom extends StatelessWidget {
  final String screen;
  final String text;
  final Widget? leading;
  final String image;
  final int index;

  const ListItemCustom(
      {Key? key,
      required this.screen,
      required this.text,
      required this.image,
      this.leading,
      required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 0,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey[200]!,
            offset: const Offset(0.6, 1.2), //(x,y)
            blurRadius: 6.0,
          ),
        ],
        color: ColorManager.cardColor,
      ),
      child: Padding(
        padding: EdgeInsets.all(8.0.sp),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              'assets/images/$image.png', scale: 10,
              // width: 60,
            ),
            Flexible(
              child: TextCustom(
                textAlign: TextAlign.start,
                text: text,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
            leading ?? const SizedBox(),
          ],
        ),
      ),
    );
  }
}
