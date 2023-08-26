import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/font_manager.dart';
import '../../../../core/utils/values_manager.dart';
import '../../../../core/widgets/component.dart';
import '../../../../core/widgets/svg_pic/svg_pic.dart';
import '../../../../core/widgets/text_custom/text_custom.dart';

class ProfileComponent extends StatelessWidget {
  final String iconName;
  final String name;
  final String screen;

  const ProfileComponent(
      {Key? key,
      required this.name,
      required this.iconName,
      required this.screen})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SlideInLeft(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppPadding.p6),
        child: InkWell(
          onTap: () {
            navigator(context, screen);
          },
          child: Row(
            children: [
              CircleAvatar(
                radius: AppSize.s20,
                backgroundColor: ColorManager.catCardColor,
                child: SvgPictureCustom(
                  assetsName: iconName,
                  color: ColorManager.primary,
                ),
              ),
              const SizedBox(
                width: AppSize.s10,
              ),
              TextCustom(
                text: name,
                fontWeight: FontWeight.w500,
                fontSize: FontSize.s16,
                color: ColorManager.black,
              ),
              const Spacer(),
              const Icon(Icons.arrow_forward_ios_outlined),
            ],
          ),
        ),
      ),
    );
  }
}
