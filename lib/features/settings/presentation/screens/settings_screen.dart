import '../../../../core/general_controllers/font_controller/font_cubit.dart';
import '../../../../core/general_controllers/font_controller/font_state.dart';
import '../../../../core/utils/values_manager.dart';
import '../../../../core/widgets/app_bar/app_bar_custom.dart';
import '../../../../core/widgets/component.dart';
import '../../../../core/widgets/scaffold_custom/scaffold_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/font_manager.dart';
import '../../../../core/utils/strings_manager.dart';
import '../../../../core/widgets/text_custom/text_custom.dart';
import '../../../../injection_container.dart';
import '../cubit/settings_cubit.dart';
import '../cubit/settings_state.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaffoldCustom(
      appBarCustom: const AppBarCustom(
        text: AppStrings.settings,
      ),
      body: BlocProvider(
        create: (context) => sl<SettingsCubit>(),
        child: BlocConsumer<SettingsCubit, SettingsStates>(
          listener: (context, state) {

          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(AppPadding.p20),
              child: Column(
                children: [

                  const TextCustom(
                    text: 'الخطوط',
                    fontSize: FontSize.s20,
                    color: ColorManager.primary,
                  ),
                  Row(
                    children: [
                      const Icon(Icons.keyboard_alt_outlined),
                      const SizedBox(
                        width: AppSize.s10,
                      ),
                      const TextCustom(
                        text: AppStrings.azkarFontSize,
                        fontWeight: FontWeight.w500,
                        fontSize: FontSize.s16,
                        color: ColorManager.black,
                      ),
                      const Spacer(),
                      BlocProvider.value(
                        value: BlocProvider.of<FontCubit>(context)
                          ..getFontSize(),
                        child: BlocConsumer<FontCubit, FontState>(
                          listener: (context, state) {
                            if (state is SaveFontSizeErrorState) {
                              showToast(context, message: state.message);
                            }
                          },
                          builder: (context, state) {
                            var fontCubit = FontCubit.get(context);
                            return Slider(
                              value: fontCubit.azkarFontSize ?? 16,
                              min: 0,
                              max: 30,
                              divisions: 30,
                              label:
                                  fontCubit.azkarFontSize?.round().toString() ??
                                      16.toString(),
                              onChanged: (double value) {
                                fontCubit.azkarFontSize = value;
                                fontCubit.saveAzkarFontSize();
                                fontCubit.getFontSize();
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
                  Row(
                    children: [
                      const Icon(Icons.keyboard_alt_outlined),
                      const SizedBox(
                        width: AppSize.s10,
                      ),
                      const TextCustom(
                        text: AppStrings.duaaFontSize,
                        fontWeight: FontWeight.w500,
                        fontSize: FontSize.s16,
                        color: ColorManager.black,
                      ),
                      const Spacer(),
                      BlocProvider.value(
                        value: BlocProvider.of<FontCubit>(context)
                          ..getFontSize(),
                        child: BlocConsumer<FontCubit, FontState>(
                          listener: (context, state) {
                            if (state is SaveDuaaFontSizeErrorState) {
                              showToast(context, message: state.message);
                            }
                          },
                          builder: (context, state) {
                            var fontCubit = FontCubit.get(context);
                            return Slider(
                              value: fontCubit.duaaFontSize ?? 16,
                              min: 0,
                              max: 30,
                              divisions: 30,
                              label:
                                  fontCubit.duaaFontSize?.round().toString() ??
                                      16.toString(),
                              onChanged: (double value) {
                                fontCubit.duaaFontSize = value;
                                fontCubit.saveDuaaFontSize();
                                fontCubit.getFontSize();
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
                  Row(
                    children: [
                      const Icon(Icons.keyboard_alt_outlined),
                      const SizedBox(
                        width: AppSize.s10,
                      ),
                      const TextCustom(
                        text: AppStrings.hadethFontSize,
                        fontWeight: FontWeight.w500,
                        fontSize: FontSize.s16,
                        color: ColorManager.black,
                      ),
                      const Spacer(),
                      BlocProvider.value(
                        value: BlocProvider.of<FontCubit>(context)
                          ..getFontSize(),
                        child: BlocConsumer<FontCubit, FontState>(
                          listener: (context, state) {
                            if (state is SaveHadethFontSizeErrorState) {
                              showToast(context, message: state.message);
                            }
                          },
                          builder: (context, state) {
                            var fontCubit = FontCubit.get(context);
                            return Slider(
                              value: fontCubit.hadethFontSize ?? 16,
                              min: 0,
                              max: 30,
                              divisions: 30,
                              label: fontCubit.hadethFontSize
                                      ?.round()
                                      .toString() ??
                                  16.toString(),
                              onChanged: (double value) {
                                fontCubit.hadethFontSize = value;
                                fontCubit.saveHadethFontSize();
                                fontCubit.getFontSize();
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
