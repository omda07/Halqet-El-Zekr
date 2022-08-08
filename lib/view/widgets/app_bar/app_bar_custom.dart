import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../resources/color_manager.dart';
import '../text_custom/text_custom.dart';

// class AppBarCustom extends StatelessWidget {
IconData? iconData;
String? tittle;
Function? onPressed;
List<Widget>? actions;
bool? isNull;
// appBarCustom(context:context,{this.iconData = Icons.arrow_back_rounded , this.leading = '', this.onPressed, Key? key}) : super(key: key);

// @override
appBarCustom(
    {iconData = Icons.arrow_back_ios_rounded,
    leading = '',
    onPressed,
    required BuildContext context,
      isNull =true,
    actions}) {
  return AppBar(
    centerTitle: true,
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.transparent,
    ),
    leading:isNull? Container(
      margin:  EdgeInsets.all( 4.sp),
      padding: EdgeInsets.all(6.sp),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        color: ColorManager.cardColor  ,
        boxShadow: [
          BoxShadow(
            color: Colors.grey[100]!,
            spreadRadius: 2,
            blurRadius: 3,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: IconButton(
        onPressed: () {
          onPressed == null ? null : onPressed!();
          // Navigator.pop(context);
        },
        icon: Icon(
          iconData,
          color: ColorManager.primary,
        ),
      ),
    ):null,
    title:
    textCustom(
      textAlign: TextAlign.center,
      context: context, text: leading!,
      fontSize: 22.sp,
      fontWeight: FontWeight.bold,
      // color: Colors.black,
    )
    ,
    actions: actions,
  );
}
// }
