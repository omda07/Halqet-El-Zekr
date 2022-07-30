import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hesn_elmuslim/view/resources/color_manager.dart';
import '../../../cubit/home/home_cubit.dart';
import '../../../cubit/home/home_state.dart';
import '../../widgets/text_custom/text_custom.dart';

class MorningAzkarScreen extends StatelessWidget {
  const MorningAzkarScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getAzkarMorning(context: context),
      child: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = HomeCubit.get(context);
          return ConditionalBuilder(
            condition: cubit.azkarMoriningModel != null,
            builder: (context) {
              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 10.0),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
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
                          padding: const EdgeInsets.only(
                              top: 20, bottom: 10, right: 20, left: 20),
                          child: Column(
                            children: [
                              textCustom(
                                  context: context,
                                  text: cubit.azkarMoriningModel!
                                      .morning![index].zekr!,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold),
                              const Divider(),
                              textCustom(
                                  context: context,
                                  text: cubit.azkarMoriningModel!
                                      .morning![index].description!,
                                  color: ColorManager.grey2),
                              Row(
                                children: [
                                  Expanded(
                                    child: IconButton(
                                      onPressed: () {
                                        Clipboard.setData(ClipboardData(text: cubit.azkarMoriningModel!
                                            .morning![index].zekr!));
                                        Fluttertoast.showToast(msg: 'Copied');
                                      },
                                      icon: const Icon(Icons.copy),
                                    ),
                                  ),
                                  Expanded(
                                    child: textCustom(
                                        textAlign: TextAlign.center,
                                        text:
                                            '${cubit.azkarMoriningModel!.morning![index].count}',
                                        context: context,
                                        fontSize: 24),
                                  ),
                                  Expanded(
                                    child: IconButton(
                                      onPressed: () {
                                        cubit.share(cubit.azkarMoriningModel!
                                            .morning![index].zekr!,'','');
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
                itemCount: cubit.azkarMoriningModel!.morning!.length,
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
