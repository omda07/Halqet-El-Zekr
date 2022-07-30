import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hesn_elmuslim/cubit/home/home_cubit.dart';
import 'package:hesn_elmuslim/cubit/home/home_state.dart';
import 'package:hesn_elmuslim/view/resources/color_manager.dart';
import 'package:hesn_elmuslim/view/widgets/app_bar/app_bar_custom.dart';
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
        create: (context) => HomeCubit()..getTasbeh(context: context),
        child: BlocConsumer<HomeCubit, HomeStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = HomeCubit.get(context);
            return ConditionalBuilder(
              condition: cubit.tasbehModel != null,
              builder: (context) {
                return Center(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: textCustom(
                          context: context,
                          text: '${cubit.tasbehModel!.tasbeh![i].content}',
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      GestureDetector(
                        onTap: () {
                          cubit.incrementCounter(counter: 99);
                        },
                        child: CircularPercentIndicatorCustom(
                          radius: 120.0,
                          counter: cubit.count,
                          percent: cubit.percent,
                          count: int.parse(
                              '${cubit.tasbehModel!.tasbeh![i].count}'),
                        ),
                      ),
                      const SizedBox(
                        height: 35,
                      ),
                      InkWell(
                        onTap: () {
                          cubit.refresh();
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: ColorManager.primary),
                          child: const Icon(
                            Icons.refresh,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
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
