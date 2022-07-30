import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

networkImageCustom(
    {String? url,
    double? width = double.infinity,
    double? height = 30,
    BoxFit fit = BoxFit.cover,
    double? borderRadius = 8,}) {
  return Container(
    clipBehavior: Clip.antiAliasWithSaveLayer,
    width: width?.w,
    height: height?.h,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(borderRadius!),
    ),
    child: FadeInImage.assetNetwork(
        placeholder: 'assets/images/orange.jpg', image: url!, fit: fit),
  );
}
