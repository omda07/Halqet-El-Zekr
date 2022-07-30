import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';

import '../../resources/color_manager.dart';
import '../../screens/layout/layout.dart';


scaffoldCustom({
  required Widget body,
  String? appBarTitle,
  IconData? icon,
  Function? onPressed,
  BottomNavigationBar? bottomNavigationBar,
  AppBar? appBarCustom,
  bool? condition = true,
  bool? isExtend = false,
  Widget? floatingActionButton,
}) {
  return Scaffold(
    extendBodyBehindAppBar:isExtend! ,
    appBar: appBarCustom,
    body: Layout(
     widget:  ConditionalBuilder(
       condition: condition!,
       builder: (BuildContext context) {
         return body;
       },
       fallback: (BuildContext context) =>  Center(
         child: CircularProgressIndicator(
           color: ColorManager.swatch,
         ),
       ),
     ),
    ),
    bottomNavigationBar: bottomNavigationBar,
    floatingActionButton: floatingActionButton,
  );
}
