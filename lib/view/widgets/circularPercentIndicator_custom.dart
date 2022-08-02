import 'package:arabic_numbers/arabic_numbers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hesn_elmuslim/view/widgets/text_custom/text_custom.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

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
      radius: radius ?? 80,
      lineWidth: 5.0,
      percent: percent,
      animation: false,
      animateFromLastPercent: false,

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
            padding: const EdgeInsets.only(right: 65.0),
            child: textCustom(
                context: context,
                text: '/${arabicNumber.convert('$count')}',
                fontSize: 16.sp,),
          ),
        ],
      ),
      // onAnimationEnd:1,
      progressColor: Colors.green,
    );
  }
}
