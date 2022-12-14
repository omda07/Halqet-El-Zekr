import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hesn_elmuslim/cubit/home/home_cubit.dart';
import 'package:hesn_elmuslim/view/resources/color_manager.dart';
import 'package:hesn_elmuslim/view/widgets/app_bar/app_bar_custom.dart';
import '../../../cubit/home/home_state.dart';
import '../../../model/duaa/duaaModel.dart';
import '../../widgets/scaffold_custom/scaffold_custom.dart';
import '../../widgets/text_custom/text_custom.dart';

class DuaaDetailsScreen extends StatelessWidget {
  DuaaDetailsScreen({required this.azkarName, Key? key}) : super(key: key);
  String azkarName;
  AzkarByCategory azkarByCategory = AzkarByCategory();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        azkarByCategory.getAzkarByCategory(azkarName);
        var cubit = HomeCubit.get(context);
        return scaffoldCustom(
          appBarCustom: appBarCustom(
            context: context,
            leading: azkarName,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          body: ConditionalBuilder(
            condition: azkarByCategory.azkarList.isNotEmpty,
            builder: (context) {
              return ListView(
                physics: const BouncingScrollPhysics(),
                children: azkarByCategory.azkarList.map((model) {
                  return Container(
                    width: double.infinity,
                    margin:
                         EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
                    padding:  EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 16.h,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.0.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey[200]!,
                          offset: const Offset(0.6, 1.2), //(x,y)
                          blurRadius: 6.0,
                        ),
                      ],
                      color: ColorManager.cardColor,
                    ),
                    child: Column(
                      children: [
                        textCustom(
                          context: context,
                          text: model.zekr!,
                          fontSize: 20.sp,
                        ),
                        const Divider(),
                        SizedBox(
                          height: 20.h,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () {
                                  Clipboard.setData(
                                      ClipboardData(text: model.zekr!));
                                  Fluttertoast.showToast(msg: 'Copied');
                                },
                                icon: const Icon(
                                  Icons.copy,
                                  color: ColorManager.primary,
                                ),
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
