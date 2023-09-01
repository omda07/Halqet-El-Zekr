import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hesn_elmuslim/core/utils/assets_manager.dart';
import 'package:hesn_elmuslim/core/utils/strings_manager.dart';
import 'package:hesn_elmuslim/core/utils/values_manager.dart';
import 'package:hesn_elmuslim/core/widgets/scaffold_custom/scaffold_custom.dart';
import 'package:hesn_elmuslim/core/widgets/svg_pic/svg_pic.dart';
import 'package:hesn_elmuslim/features/profile/presentation/screens/profile_screen.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import 'package:store_redirect/store_redirect.dart';
import 'package:upgrader/upgrader.dart';

import '../core/notifications/notifications_utils.dart';
import '../core/utils/color_manager.dart';
import '../core/widgets/elevated_button/elevated_button_custom.dart';
import '../core/widgets/text_custom/text_custom.dart';
import 'home/presentation/screens/home_screen.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    initPlatformState();
    PrayerNotifications().notifications();

    super.initState();
  }

  String subtitle = '';
  String content = '';
  String data = '';
  String debugLabelString = '';

  Future<void> initPlatformState() async {
    if (!mounted) return;

    // OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

    OneSignal.shared
        .setNotificationOpenedHandler((OSNotificationOpenedResult result) {
      debugPrint('NOTIFICATION OPENED HANDLER CALLED WITH: $result');
      setState(() {
        debugLabelString =
            "Opened notification:${result.notification.title} \n${result.notification.jsonRepresentation().replaceAll("\\n", "\n")}";
      });
    });

    OneSignal.shared.setNotificationWillShowInForegroundHandler(
        (OSNotificationReceivedEvent event) {
      debugPrint('FOREGROUND HANDLER CALLED WITH: $event');

      /// Display Notification, send null to not display
      event.complete(event.notification);

      setState(() {
        debugLabelString =
            "Notification received in foreground notification: \n${event.notification.jsonRepresentation().replaceAll("\\n", "\n")}";
      });
    });

    OneSignal.shared
        .setSubscriptionObserver((OSSubscriptionStateChanges changes) {
      debugPrint("SUBSCRIPTION STATE CHANGED: ${changes.jsonRepresentation()}");
    });

    OneSignal.shared.setPermissionObserver((OSPermissionStateChanges changes) {
      debugPrint("PERMISSION STATE CHANGED: ${changes.jsonRepresentation()}");
    });

// NOTE: Replace with your own app ID from https://www.onesignal.com
    await OneSignal.shared.setAppId("");
  }

  final _screens = [
    const HomeScreen(),
    const ProfileScreen()
  ];

  Future<bool> dialog() async {
    return await AwesomeDialog(
      context: context,
      animType: AnimType.scale,
      dialogType: DialogType.noHeader,
      title: '',
      width: double.infinity,
      dialogBackgroundColor: ColorManager.scaffold,
      desc: '',
      showCloseIcon: true,
      body: Padding(
        padding: EdgeInsets.all(18.0.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextCustom(
              text: AppStrings.youWantToExit,
              color: ColorManager.black,
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
            ),
            SizedBox(
              height: 30.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: ElevatedButtonCustom(
                    textColor: ColorManager.white,
                    colors: ColorManager.primary,
                    text: AppStrings.no,
                    radius: 10.r,
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                    child: TextCustom(
                      text: AppStrings.yes,
                      fontSize: 16.sp,
                      decoration: TextDecoration.underline,
                      decorationColor: ColorManager.black,
                      fontWeight: FontWeight.w700,
                      color: ColorManager.black,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: AppSize.s8,
            ),
            ElevatedButtonCustom(
              elevation: AppSize.s1_5,
              textColor: ColorManager.white,
              colors: ColorManager.greenColor,
              borderColor: ColorManager.greenColor,
              text: AppStrings.rateUs,
              radius: 10.r,
              onPressed: () {
                StoreRedirect.redirect(
                  androidAppId: "com.omda.halqetElZekr",
                  iOSAppId: "",
                );
              },
            ),
          ],
        ),
      ),
    ).show();
  }

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: dialog,
      child: UpgradeAlert(
        upgrader:
            Upgrader(showIgnore: false, messages: UpgraderMessages(code: 'ar')),
        child: ScaffoldCustom(
          // key: Key('${Random()}'),
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
          bottomNavigationBar: CurvedNavigationBar(
            index: _selectedIndex,
            buttonBackgroundColor: Colors.white,
            animationCurve: Curves.fastOutSlowIn,
            backgroundColor: ColorManager.secondary,
            height: 50.h,
            color: ColorManager.secondary2,
            items: <Widget>[
              Image.asset(
                ImageAssets.homeImg,
                scale: 18,
              ),
              const SvgPictureCustom(assetsName: IconsAssets.personIcon),
            ],
            onTap: (index) {
              //Handle button tap

              setState(() {
                _selectedIndex = index;
              });
            },
          ),
        ),
      ),
    );
  }
}
