import 'package:animate_do/animate_do.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hesn_elmuslim/core/widgets/scaffold_custom/scaffold_custom.dart';

import '../../../../core/local/cache_helper.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../core/widgets/app_bar/app_bar_custom.dart';
import '../../../../core/widgets/circularPercentIndicator_custom.dart';
import '../../../../core/widgets/text_custom/text_custom.dart';
import '../tasbih_cubit/tasbih_cubit.dart';
import '../tasbih_cubit/tasbih_state.dart';

class SelectedTasbehScreen extends StatelessWidget {
  const SelectedTasbehScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaffoldCustom(
      appBarCustom: const AppBarCustom(),
      body: BlocConsumer<TasbihCubit, TasbihStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = TasbihCubit.get(context);
          return ConditionalBuilder(
            condition: cubit.tasbehModel != null,
            builder: (context) {
              return Center(
                child: FadeIn(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 8.h),
                        child: TextCustom(
                          text:
                              '${cubit.tasbehModel!.tasbeh![cubit.index!].content}',
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height: 32.h,
                      ),
                      GestureDetector(
                        onTap: () {
                          cubit.incrementCounter(
                              counter: 99,
                              index: cubit.index!,
                              percent: cubit
                                  .tasbehModel!.tasbeh![cubit.index!].percent!);
                          CacheHelper.put(
                              key: '${cubit.index!}t', value: cubit.count);
                        },
                        child: CircularPercentIndicatorCustom(
                          radius: 120.0.r,
                          counter:
                              CacheHelper.get(key: '${cubit.index!}t') ?? 0,
                          percent:
                              cubit.tasbehModel!.tasbeh![cubit.index!].percent!,
                          count: int.parse(
                              '${cubit.tasbehModel!.tasbeh![cubit.index!].count}'),
                        ),
                      ),
                      SizedBox(
                        height: 35.h,
                      ),
                      InkWell(
                        onTap: () async {
                          await CacheHelper.removeData(key: '${cubit.index!}t');
                          cubit.tasbehModel!.tasbeh![cubit.index!].counter = 0;
                          cubit.tasbehModel!.tasbeh![cubit.index!].percent =
                              0.0;
                          cubit.refresh();
                        },
                        child: Container(
                          padding: EdgeInsets.all(10.sp),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.r),
                              color: ColorManager.cardColor),
                          child: const Icon(
                            Icons.refresh,
                            color: ColorManager.primary,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      const Divider(),
                      const SizedBox(
                        height: 20,
                      ),
                      TextCustom(
                        text:
                            '${cubit.tasbehModel!.tasbeh![cubit.index!].description}',
                        fontSize: 14.sp,
                        color: ColorManager.lightGrey,
                        fontWeight: FontWeight.bold,
                        textAlign: TextAlign.center,
                      ),
                    ],
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
