
import 'package:arabic_numbers/arabic_numbers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hesn_elmuslim/view/widgets/text_custom/text_custom.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../resources/color_manager.dart';

class CircularPercentIndicatorCustom extends StatelessWidget {
  double percent;
  double? radius;
  int? counter;
  int? count;
  int? fontSize;
  bool? tasbih = false;

  CircularPercentIndicatorCustom({
    required this.percent,
    this.radius,
    required this.counter,
    this.fontSize,
    this.tasbih,
    this.count,
    Key? key,
  }) : super(key: key);
  ArabicNumbers arabicNumber = ArabicNumbers();
  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      radius: radius?.r ?? 80.r,
      lineWidth: 5.0.w,
      percent: percent,
      animation: true,
      animateFromLastPercent: true,

      circularStrokeCap: CircularStrokeCap.round,
      center: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          textCustom(
              context: context,
              text:arabicNumber.convert('$counter') ,
            fontSize: 50.sp,
            fontWeight: FontWeight.w500,),
          Padding(
            padding:  EdgeInsets.only(right: 65.0.w),
            child: textCustom(
                context: context,
                text: '/${arabicNumber.convert('$count')}',
                fontSize: 16.sp,),
          ),
        ],
      ),
      // onAnimationEnd:1,
      progressColor: ColorManager.primary,
    );
  }
}
