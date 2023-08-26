import 'package:animate_do/animate_do.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../core/general_controllers/font_controller/font_cubit.dart';
import '../../../../core/general_controllers/font_controller/font_state.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../core/widgets/app_bar/app_bar_custom.dart';
import '../../../../core/widgets/scaffold_custom/scaffold_custom.dart';
import '../../../../core/widgets/text_custom/text_custom.dart';
import '../duaa_cubit/duaa_cubit.dart';
import '../duaa_cubit/duaa_state.dart';

class DuaaDetailsScreen extends StatelessWidget {
  const DuaaDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DuaaCubit, DuaaStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = DuaaCubit.get(context);
        cubit.azkarByCategory.getAzkarByCategory(cubit.azkarName!);

        return ScaffoldCustom(
          appBarCustom: AppBarCustom(
            text: cubit.azkarName,
          ),
          body: ConditionalBuilder(
            condition: cubit.azkarByCategory.azkarList.isNotEmpty,
            builder: (context) {
              return ListView(
                physics: const BouncingScrollPhysics(),
                children: cubit.azkarByCategory.azkarList.map((model) {
                  return FadeIn(
                    child: Container(
                      width: double.infinity,
                      margin:
                          EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 16.h,
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.r),
                          image: DecorationImage(
                            image: const AssetImage(
                              'assets/images/paper_backgroun2.jpg',
                            ),
                            colorFilter: ColorFilter.mode(
                              Colors.cyan.withOpacity(0.5),
                              BlendMode.modulate,
                            ),
                            fit: BoxFit.cover,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.7),
                              spreadRadius: 1,
                              blurRadius: 9,
                              offset: const Offset(
                                  0, 7), // changes position of shadow
                            ),
                          ]),
                      child: Column(
                        children: [
                          BlocConsumer<FontCubit, FontState>(
                            listener: (context, state) {
                              // TODO: implement listener
                            },
                            builder: (context, state) {
                              var fontCubit = FontCubit.get(context);
                              return TextCustom(
                                text: model.zekr!,
                                fontSize: fontCubit.duaaFontSize?.sp ?? 20.sp,
                              );
                            },
                          ),
                          const Divider(),
                          SizedBox(
                            // height: 20.h,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    Clipboard.setData(
                                        ClipboardData(text: model.zekr!));
                                    Fluttertoast.showToast(msg: 'تم النسخ');
                                  },
                                  icon: const Icon(
                                    Icons.copy,
                                    color: ColorManager.primary,
                                  ),
                                ),
                                TextCustom(
                                  text: model.reference!,
                                  fontSize: 20.sp,
                                ),
                                IconButton(
                                  onPressed: () {
                                    cubit.share(model.zekr!, '', '');
                                  },
                                  icon: const Icon(
                                    Icons.share,
                                    color: ColorManager.primary,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }).toList(),
              );
            },
            fallback: (context) => const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
  }
}
