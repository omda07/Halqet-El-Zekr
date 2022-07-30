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
// appBarCustom(context:context,{this.iconData = Icons.arrow_back_rounded , this.leading = '', this.onPressed, Key? key}) : super(key: key);

// @override
appBarCustom(
    {iconData = Icons.arrow_back_ios_rounded,
    leading = '',
    onPressed,
    required BuildContext context,
    actions}) {
  return AppBar(
    centerTitle: true,
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.transparent,
    ),
    leading: IconButton(
      onPressed: () {
        onPressed == null ? null : onPressed!();
        // Navigator.pop(context);
      },
      icon: Icon(
        iconData,
        color: ColorManager.primary,
      ),
    ),
    title: textCustom(
      context: context, text: leading!,
      fontSize: 22.sp,
      fontWeight: FontWeight.bold,
      // color: Colors.black,
    ),
    actions: actions,
  );
}
// }
