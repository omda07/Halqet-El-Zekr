import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hesn_elmuslim/view/widgets/text_custom/text_custom.dart';

import '../resources/color_manager.dart';

class SurahCustom extends StatelessWidget {
   String? text;
 Widget? widget;
   SurahCustom({Key? key,  this.text,  this.widget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        row(
            alignmentGeometry: Alignment.topRight,
            alignmentGeometry1: Alignment.topLeft,
            image: 'corner',
            image1: 'corner3'),
        widget ??
        textCustom( height: 1.5.h,
          textAlign: TextAlign.center,
          fontSize: 20.sp,
          text: text!,
          context: context,
        ),
        row(
            alignmentGeometry: Alignment.bottomRight,
            alignmentGeometry1: Alignment.bottomLeft,
            image: 'corner2',
            image1: 'corner1'),
      ],
    );
  }

  Widget row(
      {required AlignmentGeometry alignmentGeometry,
      required AlignmentGeometry alignmentGeometry1,
      required String image,
      required String image1}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Align(
          alignment: alignmentGeometry,
          child: Image.asset(
            'assets/images/$image.png',
            width: 60.w,
            color: ColorManager.frameColor,
          ),
        ),
        Align(
          alignment: alignmentGeometry1,
          child: Image.asset(
            'assets/images/$image1.png',
            width: 60.w,
            color: ColorManager.frameColor,
          ),
        ),
      ],
    );
  }
}
