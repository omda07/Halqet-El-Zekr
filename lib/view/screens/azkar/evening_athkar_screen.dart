import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hesn_elmuslim/view/resources/color_manager.dart';
import 'package:hesn_elmuslim/view/widgets/text_custom/text_custom.dart';
import '../../../cubit/home/home_cubit.dart';
import '../../../cubit/home/home_state.dart';

class EveningAzkarScreen extends StatelessWidget {
  const EveningAzkarScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getAzkarEvening(context: context),
      child: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = HomeCubit.get(context);
          return ConditionalBuilder(
            condition: cubit.azkarEveningModel != null,
            builder: (context) {
              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => Column(
                  children: [
                    Padding(
                      padding:  EdgeInsets.symmetric(
                          horizontal: 15.0.w, vertical: 10.0.h),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.r),
                            image: const DecorationImage(
                              image: AssetImage(
                                  'assets/images/paperBackground.jpg'),
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
                        child: Padding(
                          padding:  EdgeInsets.only(
                              top: 20.h, bottom: 10.h, right: 20.w, left: 20.w),
                          child: Column(
                            children: [
                              textCustom(
                                  context: context,
                                  text: cubit
                                      .azkarEveningModel!.evening![index].zekr!,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold),
                              const Divider(),
                              textCustom(
                                  context: context,
                                  text: cubit.azkarEveningModel!.evening![index]
                                      .description!,
                                  color: ColorManager.grey2),
                              Row(
                                children: [
                                  Expanded(
                                    child: IconButton(
                                      onPressed: () {
                                        Clipboard.setData(ClipboardData(text: cubit.azkarEveningModel!
                                            .evening![index].zekr!));
                                        Fluttertoast.showToast(msg: 'Copied');
                                      },
                                      icon: const Icon(Icons.copy),
                                    ),
                                  ),
                                  Expanded(
                                    child: textCustom(
                                        textAlign: TextAlign.center,
                                        text:
                                            '${cubit.azkarEveningModel!.evening![index].count}',
                                        context: context,
                                        fontSize: 24.sp),
                                  ),
                                  Expanded(
                                    child: IconButton(
                                      onPressed: () {
                                        cubit.share(cubit.azkarEveningModel!
                                            .evening![index].zekr!,'','');
                                      },
                                      icon: const Icon(Icons.share),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                itemCount: cubit.azkarEveningModel!.evening!.length,
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
