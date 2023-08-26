import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/widgets/scaffold_custom/scaffold_custom.dart';
import '../../../../core/widgets/app_bar/app_bar_custom.dart';
import '../../../../core/widgets/tab_bar_custom/tab_bar_custom.dart';
import 'evening_athkar_screen.dart';
import 'morning_athkar_screen.dart';

class AthkarScreen extends StatefulWidget {
  const AthkarScreen({Key? key}) : super(key: key);

  @override
  State<AthkarScreen> createState() => _AthkarScreenState();
}

class _AthkarScreenState extends State<AthkarScreen> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldCustom(
        appBarCustom: const AppBarCustom(
          text: 'الأذكار',
        ),
        body: Padding(
          padding: EdgeInsets.all(8.0.sp),
          child: const Column(
            children: [
              TabBarCustom(
                widgets: [
                  MorningAzkarScreen(),
                  EveningAzkarScreen(),
                ],
                myTabs: [
                  Tab(
                    text: 'الصباح',
                  ),
                  Tab(
                    text: 'المساء',
                  )
                ],
              ),
            ],
          ),
        ));
  }
}
