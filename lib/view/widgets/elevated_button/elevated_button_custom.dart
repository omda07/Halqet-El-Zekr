import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../resources/color_manager.dart';
import '../text_custom/text_custom.dart';


class ElevatedButtonCustom extends StatelessWidget {
  final String? text;
  final Function? onPressed;
  final double? radius;
  final double? width;
  final double? height;
  final double? elevation;
  final Color? colors;
  final Color? textColor;
  final double? fontSize;
final Widget? widget;
final Color? borderColor;
  const ElevatedButtonCustom({
    Key? key,
     this.text,
    this.onPressed,
    this.radius = 10,
    this.width = 50,
    this.height = 12,
    this.elevation = 0,
    this.colors,
    this.fontSize ,
    this.textColor = Colors.black,
    this.widget, this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child:widget??textCustom(context:context,text: text!,color: textColor,fontSize: fontSize),
      onPressed: () {
        onPressed!();
      },
      style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius!),
            side:  BorderSide(color:borderColor?? ColorManager.swatch),
          ),
          elevation: elevation,
          primary: colors ?? ColorManager.swatch,
          padding:
              EdgeInsets.symmetric(horizontal: width!.w, vertical: height!.h),
          textStyle: TextStyle(fontSize:fontSize?? 16.sp, fontWeight: FontWeight.bold)),
    );
  }
}
