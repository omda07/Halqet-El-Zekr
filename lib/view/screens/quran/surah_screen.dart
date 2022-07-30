import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hesn_elmuslim/view/widgets/app_bar/app_bar_custom.dart';
import 'package:hesn_elmuslim/view/widgets/scaffold_custom/scaffold_custom.dart';
import '../../../cubit/quran/quran_cubit.dart';
import '../../../cubit/quran/quran_state.dart';
import '../../resources/color_manager.dart';
import '../../widgets/text_custom/text_custom.dart';

class SurahScreen extends StatelessWidget {
  final String id;

  const SurahScreen({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QuranCubit()..getQuranSurah(id: id),
      child: BlocConsumer<QuranCubit, QuranStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = QuranCubit.get(context);

          return ConditionalBuilder(
            condition: cubit.quranSurah != null,
            builder: (context) {
              return scaffoldCustom(
                appBarCustom: appBarCustom(
                    context: context,
                    leading: cubit.quranSurah!.name,
                    onPressed: () {
                      Navigator.pop(context);
                    }),
                body: Padding(
                  padding: EdgeInsets.all(20.0.sp),
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: cubit.quranSurah!.verses!.length,
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
                                    text:
                                        '${cubit.quranSurah!.verses![index].text!} ${cubit.quranSurah!.verses![index].id}',
                                    fontSize: 24.sp,
                                  ),
                                  subtitle: textCustom(
                                    textAlign: TextAlign.center,
                                    context: context,
                                    text: cubit.quranSurah!.verses![index]
                                        .transliteration!,
                                    color: ColorManager.grey2,
                                    fontSize: 14.sp,
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
