import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../resources/color_manager.dart';

class TabBarCustom extends StatelessWidget {
  List<Widget> widgets;
  List<Tab> myTabs;
  Function(int index)? onTap;
  dynamic radius;

  TabBarCustom(
      {required this.myTabs,
      required this.widgets,
      this.onTap,
      this.radius = 20,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: DefaultTabController(
        animationDuration: const Duration(milliseconds: 800),
        length: myTabs.length,
        initialIndex: 0,
        child: Column(
          children: [
            Container(
              height: 40.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(double.parse('$radius')),
                color: ColorManager.prerequisiteCardColor,
              ),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: TabBar(
                onTap: (int index) {
                  onTap == null ? null : onTap!(index);
                },
                tabs: myTabs,
                labelStyle:
                    TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
                enableFeedback: true,
                labelColor: ColorManager.primary  ,
                indicator:  const BoxDecoration(
                  color: ColorManager.indicatorColor,
                ),
                unselectedLabelColor: ColorManager.labelUnSelectedColor,
              ),
            ),
            Expanded(
              child: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                children: widgets,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
