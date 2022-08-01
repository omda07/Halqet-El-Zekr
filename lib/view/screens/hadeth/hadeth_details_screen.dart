import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hesn_elmuslim/view/widgets/app_bar/app_bar_custom.dart';
import 'package:hesn_elmuslim/view/widgets/scaffold_custom/scaffold_custom.dart';
import '../../../cubit/hadeth/hadeth_cubit.dart';
import '../../../cubit/hadeth/hadeth_state.dart';
import '../../resources/color_manager.dart';
import '../../widgets/component.dart';
import '../../widgets/text_custom/text_custom.dart';
import 'hadeth_info_screen.dart';

class HadethDetailsScreen extends StatelessWidget {
  final String id;
  final String name;

  const HadethDetailsScreen({Key? key, required this.id, required this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HadethCubit()..getHadethDetails(id: id),
      child: BlocConsumer<HadethCubit, HadethStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = HadethCubit.get(context);

          return ConditionalBuilder(
            condition: cubit.hadethDetailsModel != null,
            builder: (context) {
              return scaffoldCustom(
                appBarCustom: appBarCustom(
                    context: context,
                    leading: name,
                    onPressed: () {
                      Navigator.pop(context);
                    }),
                body: Padding(
                  padding: EdgeInsets.all(20.0.sp),
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: cubit.hadethDetailsModel!.data!.length,
                    // itemExtent: 100.0,
                    itemBuilder: (BuildContext context, int index) => Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0.sp),
                      child: Column(
                        textDirection: TextDirection.rtl,
                        children: [
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 10,
                                child: ListTile(
                                  title: textCustom(
                                    textAlign: TextAlign.center,
                                    context: context,
                                    text: cubit.hadethDetailsModel!.data![index]
                                        .title!,
                                    fontSize: 24.sp,
                                  ),
                                  subtitle: TextButton(
                                    onPressed: () {
                                      navigator(
                                          context,
                                          HadethInfoScreen(
                                            id: '${cubit.hadethDetailsModel!.data![index].id}',
                                          ));
                                    },
                                    child: textCustom(
                                      decoration: TextDecoration.underline,
                                      textAlign: TextAlign.center,
                                      color: ColorManager.grey2,
                                      context: context,
                                      text: 'أقرأ المزيد',
                                      fontSize: 18.sp,
                                    ),
                                  ),
                                ),
                              ),
                            ],
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
                            color: ColorManager.primary,
                          ),
                        ],
                      ),
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
