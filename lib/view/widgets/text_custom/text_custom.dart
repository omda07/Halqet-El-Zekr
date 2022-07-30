import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../resources/color_manager.dart';

textCustom({
  required String text,
   double? fontSize = 14.0,
  Color? color = ColorManager.primary,
  FontWeight? fontWeight = FontWeight.normal,
  TextDecoration decoration = TextDecoration.none,
TextOverflow? overflow,
  int? maxLines,
  TextAlign textAlign = TextAlign.start,
  required BuildContext context,
}) {
  return Text(
    text,
maxLines:maxLines ,
     overflow: overflow,
    textAlign: textAlign,
    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
      fontSize: fontSize?.sp,
      color: color,
      fontWeight: fontWeight,
      decoration: decoration,
      decorationColor: ColorManager.primary,
    ),
  );
}
