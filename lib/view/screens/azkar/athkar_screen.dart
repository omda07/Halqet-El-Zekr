import 'package:flutter/material.dart';
import 'package:hesn_elmuslim/view/widgets/app_bar/app_bar_custom.dart';
import '../../widgets/component.dart';
import '../../widgets/tab_bar_custom/tab_bar_custom.dart';
import '../main_page.dart';
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
    return Scaffold(
        appBar: appBarCustom(

        context: context,
          leading:   'الأذكار',
          onPressed: () {
            navigatorAndRemove(context, const MainPage());
          },
        ),
        body:  Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TabBarCustom(

                widgets: const [
                  MorningAzkarScreen(),
                  EveningAzkarScreen(),
                ], myTabs: const [
                  Tab(text: 'الصباح',),
                  Tab(text: 'المساء',)
              ],

              ),
            ],
          ),
        ));
  }
}