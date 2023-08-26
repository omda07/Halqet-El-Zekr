import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hesn_elmuslim/core/widgets/shimmer_custom/shimmer_custom.dart';

import 'package:hesn_elmuslim/core/widgets/surah_custom.dart';
import '../../../../core/general_controllers/font_controller/font_cubit.dart';
import '../../../../core/general_controllers/font_controller/font_state.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../core/widgets/app_bar/app_bar_custom.dart';
import '../../../../core/widgets/error_widget.dart';
import '../../../../core/widgets/scaffold_custom/scaffold_custom.dart';
import '../../../../core/widgets/text_custom/text_custom.dart';

import '../hadeth_info_cubit/hadeth_info_cubit.dart';
import '../hadeth_info_cubit/hadeth_info_state.dart';

class HadethInfoScreen extends StatelessWidget {
  const HadethInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<HadethInfoCubit>(context)..getHadethInfo(),
      child: BlocConsumer<HadethInfoCubit, HadethInfoStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = HadethInfoCubit.get(context);
          return ScaffoldCustom(
            appBarCustom: AppBarCustom(
              text: cubit.hadeethName,
            ),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.all(20.0.sp),
                child: state is GetHadethInfoSuccess
                    ? FadeIn(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          textDirection: TextDirection.rtl,
                          children: [
                            TextCustom(
                                decoration: TextDecoration.underline,
                                textAlign: TextAlign.center,
                                text: 'الحديث',
                                fontSize: 24.sp,
                                color: ColorManager.grey),
                            BlocConsumer<FontCubit, FontState>(
                              listener: (context, states) {
                                // TODO: implement listener
                              },
                              builder: (context, states) {
                                var fontCubit = FontCubit.get(context);
                                return SurahCustom(
                                  text: state.hadeethInfoEntity.hadeeth,
                                  fontSize:
                                      fontCubit.hadethFontSize?.sp ?? 20.sp,
                                );
                              },
                            ),
                            Divider(
                              height: 20.h,
                              thickness: 2,
                              color: ColorManager.lightGrey,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextCustom(
                                    decoration: TextDecoration.underline,
                                    textAlign: TextAlign.center,
                                    text: 'الاسناد: ',
                                    fontSize: 22.sp,
                                    color: ColorManager.grey),
                                Expanded(
                                  child: TextCustom(
                                    textAlign: TextAlign.center,
                                    text: state.hadeethInfoEntity.attribution,
                                    maxLines: 3,
                                    fontSize: 20.sp,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                TextCustom(
                                    decoration: TextDecoration.underline,
                                    textAlign: TextAlign.center,
                                    text: 'الدرجة: ',
                                    fontSize: 24.sp,
                                    color: ColorManager.grey),
                                TextCustom(
                                  textAlign: TextAlign.center,
                                  text: state.hadeethInfoEntity.grade,
                                  fontSize: 20.sp,
                                ),
                              ],
                            ),
                            Divider(
                              height: 20.h,
                              thickness: 2,
                              color: ColorManager.lightGrey,
                            ),
                            TextCustom(
                                decoration: TextDecoration.underline,
                                textAlign: TextAlign.center,
                                text: 'التفسير',
                                fontSize: 24.sp,
                                color: ColorManager.grey),
                            TextCustom(
                              textAlign: TextAlign.center,
                              text: state.hadeethInfoEntity.explanation,
                              fontSize: 20.sp,
                            ),
                            Divider(
                              height: 20.h,
                              thickness: 2,
                              color: ColorManager.lightGrey,
                            ),
                            TextCustom(
                              decoration: TextDecoration.underline,
                              textAlign: TextAlign.center,
                              text: 'التلميحات',
                              fontSize: 24.sp,
                              color: ColorManager.grey,
                            ),
                            TextCustom(
                              textAlign: TextAlign.center,
                              text: state.hadeethInfoEntity.hints[0],
                              fontSize: 20.sp,
                            ),
                            Divider(
                              height: 20.h,
                              thickness: 2,
                              color: ColorManager.lightGrey,
                            ),
                            TextCustom(
                                decoration: TextDecoration.underline,
                                textAlign: TextAlign.center,
                                text: 'معاني الكلمات',
                                fontSize: 24.sp,
                                color: ColorManager.grey),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: List.generate(
                                state.hadeethInfoEntity.wordsMeanings.length,
                                (index) => Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextCustom(
                                      textAlign: TextAlign.center,
                                      text:
                                          '${state.hadeethInfoEntity.wordsMeanings[index].word} : ',
                                      fontSize: 22.sp,
                                    ),
                                    TextCustom(
                                      textAlign: TextAlign.center,
                                      text: state.hadeethInfoEntity
                                          .wordsMeanings[index].meaning,
                                      fontSize: 20.sp,
                                      color: ColorManager.grey,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Divider(
                              height: 20.h,
                              thickness: 2,
                              color: ColorManager.lightGrey,
                            ),
                            TextCustom(
                                decoration: TextDecoration.underline,
                                textAlign: TextAlign.center,
                                text: 'المرجع',
                                fontSize: 24.sp,
                                color: ColorManager.grey),
                            TextCustom(
                              textAlign: TextAlign.center,
                              text: state.hadeethInfoEntity.reference,
                              fontSize: 16.sp,
                            ),
                          ],
                        ),
                      )
                    : state is GetHadethInfoLoading
                        ? ShimmerCustom(
                            child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            textDirection: TextDirection.rtl,
                            children: [
                              TextCustom(
                                  decoration: TextDecoration.underline,
                                  textAlign: TextAlign.center,
                                  text: 'الحديث',
                                  fontSize: 24.sp,
                                  color: ColorManager.grey),
                              const SurahCustom(
                                text: '',
                              ),
                              Divider(
                                height: 20.h,
                                thickness: 2,
                                color: ColorManager.lightGrey,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextCustom(
                                      decoration: TextDecoration.underline,
                                      textAlign: TextAlign.center,
                                      text: 'الاسناد: ',
                                      fontSize: 22.sp,
                                      color: ColorManager.grey),
                                  Expanded(
                                    child: TextCustom(
                                      textAlign: TextAlign.center,
                                      text: '',
                                      maxLines: 3,
                                      fontSize: 20.sp,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  TextCustom(
                                      decoration: TextDecoration.underline,
                                      textAlign: TextAlign.center,
                                      text: 'الدرجة: ',
                                      fontSize: 24.sp,
                                      color: ColorManager.grey),
                                  const TextCustom(
                                    textAlign: TextAlign.center,
                                    text: '',
                                  ),
                                ],
                              ),
                              Divider(
                                height: 20.h,
                                thickness: 2,
                                color: ColorManager.lightGrey,
                              ),
                              TextCustom(
                                  decoration: TextDecoration.underline,
                                  textAlign: TextAlign.center,
                                  text: 'التفسير',
                                  fontSize: 24.sp,
                                  color: ColorManager.grey),
                              const TextCustom(
                                textAlign: TextAlign.center,
                                text: '',
                              ),
                              Divider(
                                height: 20.h,
                                thickness: 2,
                                color: ColorManager.lightGrey,
                              ),
                              TextCustom(
                                decoration: TextDecoration.underline,
                                textAlign: TextAlign.center,
                                text: 'التلميحات',
                                fontSize: 24.sp,
                                color: ColorManager.grey,
                              ),
                              const TextCustom(
                                textAlign: TextAlign.center,
                                text: '',
                              ),
                              Divider(
                                height: 20.h,
                                thickness: 2,
                                color: ColorManager.lightGrey,
                              ),
                              TextCustom(
                                  decoration: TextDecoration.underline,
                                  textAlign: TextAlign.center,
                                  text: 'معاني الكلمات',
                                  fontSize: 24.sp,
                                  color: ColorManager.grey),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: List.generate(
                                  3,
                                  (index) => const Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      TextCustom(
                                        textAlign: TextAlign.center,
                                        text: '',
                                      ),
                                      TextCustom(
                                        textAlign: TextAlign.center,
                                        text: '',
                                        color: ColorManager.grey,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Divider(
                                height: 20.h,
                                thickness: 2,
                                color: ColorManager.lightGrey,
                              ),
                              TextCustom(
                                  decoration: TextDecoration.underline,
                                  textAlign: TextAlign.center,
                                  text: 'المرجع',
                                  fontSize: 24.sp,
                                  color: ColorManager.grey),
                              const TextCustom(
                                textAlign: TextAlign.center,
                                text: '',
                              ),
                            ],
                          ))
                        : ErrorWidgetCustom(onPress: () {
                            cubit.getHadethInfo();
                          }),
              ),
            ),
            floatingActionButton: state is GetHadethInfoSuccess
                ? FloatingActionButton(
                    child: const Icon(
                      Icons.share_outlined,
                      color: ColorManager.white,
                    ),
                    onPressed: () {

                    },
                  )
                : const SizedBox(),
          );
        },
      ),
    );
  }
}
