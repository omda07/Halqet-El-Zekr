import 'package:flutter/material.dart';
import 'package:hesn_elmuslim/core/utils/assets_manager.dart';
import 'package:hesn_elmuslim/core/utils/color_manager.dart';
import 'package:hesn_elmuslim/core/utils/font_manager.dart';
import 'package:hesn_elmuslim/core/utils/routes_manager.dart';
import 'package:hesn_elmuslim/core/utils/strings_manager.dart';
import 'package:hesn_elmuslim/core/utils/values_manager.dart';
import 'package:hesn_elmuslim/core/widgets/component.dart';
import 'package:hesn_elmuslim/core/widgets/scaffold_custom/scaffold_custom.dart';
import 'package:hesn_elmuslim/core/widgets/text_custom/text_custom.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool animate = false;

  @override
  void initState() {
    super.initState();
    startAnimation();
  }

  Future startAnimation() async {
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() {
      animate = true;
    });
    await Future.delayed(const Duration(milliseconds: 2000));
    Future.delayed(
      const Duration(milliseconds: 20),
      () => navigatorAndRemove(context, Routes.mainRoute),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldCustom(
      body: Stack(
        children: [
          AnimatedPositioned(
            duration: const Duration(milliseconds: 1000),
            top: 80,
            left: animate ? 120 : -80,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 1000),
              opacity: animate ? 1 : 0,
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextCustom(
                    text: AppStrings.appName,
                    fontSize: FontSize.s18,
                    fontWeight: FontWeightManager.medium,
                    color: ColorManager.secondary,
                  ),
                  TextCustom(
                    text: 'كل ما يخص المسلم في تطبيق واحد',
                    fontSize: FontSize.s20,
                    fontWeight: FontWeightManager.bold,
                    color: ColorManager.black,
                  )
                ],
              ),
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 1400),
            bottom: animate ? 250 : 0,
            right: animate ? 35 : 0,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 1000),
              opacity: animate ? 1 : 0,
              child: const Image(
                image: AssetImage(ImageAssets.logoImg),
                height: AppSize.s100 * 3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
