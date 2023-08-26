import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hesn_elmuslim/core/widgets/app_bar/app_bar_custom.dart';
import 'package:hesn_elmuslim/core/widgets/elevated_button/elevated_button_custom.dart';
import 'package:hesn_elmuslim/core/widgets/scaffold_custom/scaffold_custom.dart';
import 'package:hesn_elmuslim/features/duaa/presentation/duaa_cubit/duaa_cubit.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/font_manager.dart';
import '../../../../core/utils/strings_manager.dart';
import '../../../../core/utils/values_manager.dart';
import '../../../../core/widgets/text_custom/text_custom.dart';

class HelpAndFeedbackScreen extends StatelessWidget {
  HelpAndFeedbackScreen({Key? key}) : super(key: key);

  final List<String> icons = [
    IconsAssets.facebookIcon,
    IconsAssets.instagramIcon,
  ];
  final List<String> links = [
    AppStrings.facebook,
    AppStrings.instagram,
  ];

  @override
  Widget build(BuildContext context) {
    return ScaffoldCustom(
      appBarCustom: const AppBarCustom(
        text: AppStrings.helpsFeedback,
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppPadding.p20),
        child: SafeArea(
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                  child: Image.asset(ImageAssets.logoImg,
                      fit: BoxFit.cover, width: AppSize.s100)),
              const SizedBox(
                height: AppSize.s20,
              ),
              const TextCustom(
                text: 'مواقع التواصل الاجتماعي',
                color: ColorManager.primary,
                fontSize: FontSize.s18,
                fontWeight: FontWeight.w600,
              ),
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                alignment: WrapAlignment.center,
                children: List.generate(
                    icons.length,
                    (index) => Padding(
                          padding: const EdgeInsets.all(AppPadding.p8),
                          child: InkWell(
                              onTap: () async {
                                await launchInBrowser(Uri.parse(links[index]));
                              },
                              child: SvgPicture.asset(
                                icons[index],
                                height: AppSize.s40 * 1.3,
                              )),
                        )),
              ),
              const TextCustom(
                text: 'شارك التطبيق',
                color: ColorManager.primary,
                fontSize: FontSize.s18,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(
                height: AppSize.s8.h,
              ),
              ElevatedButtonCustom(
                colors: ColorManager.secondary,
                borderColor: ColorManager.secondary,
                width: AppSize.s100,
                widget: const Icon(Icons.share_outlined,
                    color: ColorManager.scaffold),
                onPressed: () {
                  BlocProvider.of<DuaaCubit>(context).share(AppStrings.appName,
                      'تطبيق يحتوي علي كل ما يهم المسلم', AppStrings.appLink,
                      isText: false);
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }
}
