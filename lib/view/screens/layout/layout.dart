import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import '../../../cubit/cubit For Internet/internet_cubit.dart';
import '../../../cubit/cubit For Internet/internet_states.dart';
import '../../resources/color_manager.dart';
import '../../resources/constants.dart';
import '../../widgets/no_internet.dart';
import '../../widgets/text_custom/text_custom.dart';

class Layout extends StatelessWidget {
  final Widget widget;

  const Layout({required this.widget, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // liston to the BlocProvider that exist in main.dart
    return BlocConsumer<InternetCubit, InternetStates>(
      listener: (context, state) {},
      builder: (context, state) =>
          // RefreshIndicator It was used because when scroll starts displaying the new data
          // and show NoInternet Widget if we lost our connection
          RefreshIndicator(onRefresh: () async {
            // Check if the internet connection lost
        InternetCubit.get(context).checkInternetConnection();
      }, child: Builder(builder: (BuildContext context) {
            // Check if the internet connection lost
        return OfflineBuilder(
          connectivityBuilder: (context, connectivity, child) {
            connected = connectivity != ConnectivityResult.none;
            // if internet lost show container with the text no connection
            return Scaffold(
              body: Stack(
                fit: StackFit.expand,
                children: [
                  child,
                  Positioned(
                    top: 0,
                    left: 0.0,
                    right: 0.0,
                    height: 32.0.h,
                    child: AnimatedContainer(
                      curve: Curves.bounceInOut,
                      duration: const Duration(milliseconds: 200),
                      color: connected != true ? ColorManager.primary : null,
                      child: connected != true
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children:  <Widget>[
                                textCustom(context:context,text:
                                  "لا يوجد اتصال بالانترنت",
                                    color: Colors.white
                                ),
                                const SizedBox(
                                  width: 8.0,
                                ),
                                 SizedBox(
                                  width: 12.0.w,
                                  height: 12.0.h,
                                  child:  const CircularProgressIndicator(
                                    strokeWidth: 2.0,
                                    valueColor:  AlwaysStoppedAnimation<Color>(
                                        Colors.white),
                                  ),
                                ),
                              ],
                            )
                          : null,
                    ),
                  ),
                ],
              ),
            );
          },
          child: ConditionalBuilder(
            // if connected is true go to widget
            // else show no internet screen
            condition: connected,
            // The widget will be the screen I'm standing on
            builder: (context) => widget,
            fallback: (context) => noInternet(context),
          ),
        );
      })),
    );
  }
}
