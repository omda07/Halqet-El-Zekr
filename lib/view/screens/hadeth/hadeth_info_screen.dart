import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hesn_elmuslim/view/widgets/app_bar/app_bar_custom.dart';
import 'package:hesn_elmuslim/view/widgets/scaffold_custom/scaffold_custom.dart';
import '../../../cubit/hadeth/hadeth_cubit.dart';
import '../../../cubit/hadeth/hadeth_state.dart';
import '../../resources/color_manager.dart';
import '../../widgets/text_custom/text_custom.dart';

class HadethInfoScreen extends StatelessWidget {
  final String id;

  const HadethInfoScreen({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HadethCubit()..getHadethInfo(id: id),
      child: BlocConsumer<HadethCubit, HadethStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = HadethCubit.get(context);

          return ConditionalBuilder(
            condition: cubit.hadethInfoModel != null,
            builder: (context) {
              return scaffoldCustom(
                appBarCustom: appBarCustom(
                    context: context,
                    leading: cubit.hadethInfoModel!.title!,
                    onPressed: () {
                      Navigator.pop(context);
                    }),
                body: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: EdgeInsets.all(20.0.sp),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      textDirection: TextDirection.rtl,
                      children: [

                        textCustom(
                            decoration: TextDecoration.underline,
                            textAlign: TextAlign.center,
                            context: context,
                            text: 'الحديث',
                            fontSize: 24.sp,
                            color: ColorManager.grey),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Align(
                              alignment: Alignment.centerRight,
                              child: Image.asset(
                                'assets/images/corner.png',
                                width: 60.w,
                                color: ColorManager.primary,
                              ),
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Image.asset(
                                'assets/images/corner3.png',
                                width: 60.w,
                                color: ColorManager.primary,
                              ),
                            ),
                          ],
                        ),
                        textCustom(
                          textAlign: TextAlign.center,
                          context: context,
                          text: cubit.hadethInfoModel!.hadeeth!,
                          fontSize: 24.sp,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Image.asset(
                                'assets/images/corner2.png',
                                width: 60.w,
                                color: ColorManager.primary,
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: Image.asset(
                                'assets/images/corner1.png',
                                width: 60.w,
                                color: ColorManager.primary,
                              ),
                            ),
                          ],
                        ),
                        Divider(
                          height: 20.h,
                          thickness: 2,
                          color: ColorManager.lightGrey,
                        ),
                        Row(
                          children: [
                            textCustom(
                                decoration: TextDecoration.underline,
                                textAlign: TextAlign.center,
                                context: context,
                                text: 'الاسناد: ',
                                fontSize: 24.sp,
                                color: ColorManager.grey),
                            textCustom(
                              textAlign: TextAlign.center,
                              context: context,
                              text: cubit.hadethInfoModel!.attribution!,
                              fontSize: 20.sp,
                            ),
                          ],
                        ),

                        Row(
                          children: [
                            textCustom(
                                decoration: TextDecoration.underline,
                                textAlign: TextAlign.center,
                                context: context,
                                text: 'الدرجة: ',
                                fontSize: 24.sp,
                                color: ColorManager.grey),
                            textCustom(
                              textAlign: TextAlign.center,
                              context: context,
                              text: cubit.hadethInfoModel!.grade!,
                              fontSize: 20.sp,
                            ),
                          ],
                        ),
                        Divider(
                          height: 20.h,
                          thickness: 2,
                          color: ColorManager.lightGrey,
                        ),
                        textCustom(
                            decoration: TextDecoration.underline,
                            textAlign: TextAlign.center,
                            context: context,
                            text: 'التفسير',
                            fontSize: 24.sp,
                            color: ColorManager.grey),

                        textCustom(
                          textAlign: TextAlign.center,
                          context: context,
                          text: cubit.hadethInfoModel!.explanation!,
                          fontSize: 20.sp,
                        ),
                        Divider(
                          height: 20.h,
                          thickness: 2,
                          color: ColorManager.lightGrey,
                        ),
                        textCustom(
                          decoration: TextDecoration.underline,
                          textAlign: TextAlign.center,
                          context: context,
                          text: 'التلميحات',
                          fontSize: 24.sp,
                          color: ColorManager.grey,
                        ),

                        textCustom(
                          textAlign: TextAlign.center,
                          context: context,
                          text: cubit.hadethInfoModel!.hints![0],
                          fontSize: 20.sp,
                        ),
                        Divider(
                          height: 20.h,
                          thickness: 2,
                          color: ColorManager.lightGrey,
                        ),
                        textCustom(
                            decoration: TextDecoration.underline,
                          textAlign: TextAlign.center,
                          context: context,
                          text: 'معاني الكلمات',
                          fontSize: 24.sp,
                            color: ColorManager.grey
                        ),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: List.generate(
                            cubit.hadethInfoModel!.wordsMeanings!.length,
                            (index) => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                textCustom(
                                  textAlign: TextAlign.center,
                                  context: context,
                                  text:
                                      '${cubit.hadethInfoModel!.wordsMeanings![index].word!} : ',
                                  fontSize: 22.sp,

                                ),
                                textCustom(
                                  textAlign: TextAlign.center,
                                  context: context,
                                  text: cubit.hadethInfoModel!
                                      .wordsMeanings![index].meaning!,
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
                        textCustom(
                            decoration: TextDecoration.underline,
                          textAlign: TextAlign.center,
                          context: context,
                          text: 'المرجع',
                          fontSize: 24.sp,
                            color: ColorManager.grey
                        ),

                        textCustom(
                          textAlign: TextAlign.center,
                          context: context,
                          text: cubit.hadethInfoModel!.reference!,
                          fontSize: 16.sp,

                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            fallback: (context) => const Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }
}
