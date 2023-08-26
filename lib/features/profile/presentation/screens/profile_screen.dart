import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hesn_elmuslim/core/widgets/app_bar/app_bar_custom.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/routes_manager.dart';
import '../../../../core/utils/strings_manager.dart';
import '../../../../core/utils/values_manager.dart';
import '../../../../core/widgets/scaffold_custom/scaffold_custom.dart';
import 'profile_component.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaffoldCustom(
      appBarCustom: const AppBarCustom(
        isNull: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppPadding.p16),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [

              SizedBox(
                height: AppSize.s18.h,
              ),
              Container(
                padding: EdgeInsets.all(AppPadding.p12.r),
                decoration: BoxDecoration(
                    color: ColorManager.white,
                    borderRadius: BorderRadius.circular(AppSize.s10.r)),
                child: const Column(
                  children: [
                    ProfileComponent(
                      iconName: IconsAssets.settingIcon,
                      name: AppStrings.settings,
                      screen: Routes.settingsRoute,
                    ),
                    Divider(),
                    ProfileComponent(
                      iconName: IconsAssets.messageQuestionIcon,
                      name: AppStrings.helpsFeedback,
                      screen: Routes.helpScreenRoute,
                    ),
                  ],
                ),
              ),
              // HelpAndFeedbackScreen(),
            ],
          ),
        ),
      ),
    );
  }
}
