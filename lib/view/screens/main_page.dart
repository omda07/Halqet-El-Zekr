import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hesn_elmuslim/cubit/people/people_cubit.dart';
import 'package:hesn_elmuslim/view/resources/color_manager.dart';
import 'package:hesn_elmuslim/view/screens/people/people_screen.dart';

import '../widgets/text_custom/text_custom.dart';
import 'home_screen.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _screens = [ HomeScreen(), PeopleScreen()];

  Future<bool> onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            actionsAlignment: MainAxisAlignment.start,
            title: textCustom(
                context: context, text: 'هل انت متأكد ؟', fontSize: 20.sp),
            content: textCustom(
                context: context,
                text: 'هل تريد الخروج من التطبيق ؟',
                fontSize: 18.sp),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                //<-- SEE HERE
                child:
                    textCustom(context: context, text: 'لا', fontSize: 20.sp),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                // <-- SEE HERE
                child:
                    textCustom(context: context, text: 'نعم', fontSize: 20.sp),
              ),
            ],
          ),
        )) ??
        false;
  }

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        body: Stack(
          children: _screens
              .asMap()
              .map((index, screen) {
                return MapEntry(
                  index,
                  Offstage(
                    offstage: _selectedIndex != index,
                    child: screen,
                  ),
                );
              })
              .values
              .toList(),
        ),
        bottomNavigationBar: BottomNavigationBar(selectedLabelStyle: TextStyle(color: ColorManager.black),
          currentIndex: _selectedIndex,
          onTap: (index) {
            if(index == 1){
              BlocProvider.of<PeopleCubit>(context).getNames();
            }
            setState(() {
              _selectedIndex = index;
            });
          },
          items:  [
           const BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'الرئيسة',
              activeIcon: Icon(Icons.home_outlined),
            ),
            BottomNavigationBarItem(
              icon: Image.asset('assets/images/sadqa.png',scale: 16,),
              label: 'صدقة جارية',
              activeIcon:  Image.asset('assets/images/sadqa.png',scale: 15,),
            ),
          ],
        ),
      ),
    );
  }
}
