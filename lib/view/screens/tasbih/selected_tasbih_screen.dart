import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hesn_elmuslim/view/resources/color_manager.dart';
import 'package:hesn_elmuslim/view/widgets/app_bar/app_bar_custom.dart';
import '../../../cubit/database/local/cache_helper.dart';
import '../../../cubit/tasbih/tasbih_cubit.dart';
import '../../../cubit/tasbih/tasbih_state.dart';
import '../../widgets/circularPercentIndicator_custom.dart';
import '../../widgets/text_custom/text_custom.dart';

class SelectedTasbehScreen extends StatelessWidget {
  final int i;

  const SelectedTasbehScreen({Key? key, required this.i}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarCustom(
        context: context,
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      body: BlocProvider(
        create: (context) => TasbihCubit()..getTasbeh(context: context),
        child: BlocConsumer<TasbihCubit, TasbihStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = TasbihCubit.get(context);
            return ConditionalBuilder(
              condition: cubit.tasbehModel != null,
              builder: (context) {
                return Center(
                  child: Column(
                    children: [
                      Padding(
                        padding:  EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 8.h),
                        child: textCustom(
                          context: context,
                          text: '${cubit.tasbehModel!.tasbeh![i].content}',
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
                          cubit.incrementCounter(counter: 99);
                          CacheHelper.put(key: '$i', value: cubit.count);
                        },
                        child: CircularPercentIndicatorCustom(
                          radius: 120.0.r,
                          counter: CacheHelper.get(key:'$i') ?? 0,
                          percent: cubit.percent,
                          count: int.parse(
                              '${cubit.tasbehModel!.tasbeh![i].count}'),
                        ),
                      ),
                       SizedBox(
                        height: 35.h,
                      ),
                      InkWell(
                        onTap: () {
                          cubit.refresh();
                          CacheHelper.removeData(key: '$i');
                        },
                        child: Container(
                          padding:  EdgeInsets.all(10.sp),
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
                      textCustom(
                        context: context,
                        text: '${cubit.tasbehModel!.tasbeh![i].description}',
                        fontSize: 14.sp,
                        color: ColorManager.lightGrey,
                        fontWeight: FontWeight.bold,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              },
              fallback: (context) => const Center(
                child: CircularProgressIndicator(),
              ),
            );
          },
        ),
      ),
    );
  }
}
