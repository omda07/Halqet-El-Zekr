import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hesn_elmuslim/cubit/quran/quran_cubit.dart';
import 'package:hesn_elmuslim/cubit/quran/quran_state.dart';
import 'package:hesn_elmuslim/view/resources/color_manager.dart';
import 'package:hesn_elmuslim/view/screens/quran/surah_screen.dart';
import 'package:hesn_elmuslim/view/widgets/app_bar/app_bar_custom.dart';
import 'package:hesn_elmuslim/view/widgets/component.dart';

import '../../widgets/scaffold_custom/scaffold_custom.dart';
import '../../widgets/text_custom/text_custom.dart';

class QuranSurahScreen extends StatelessWidget {
  const QuranSurahScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return scaffoldCustom(
      appBarCustom: appBarCustom(
          context: context,
          leading: 'القرآن',
          onPressed: () {
            Navigator.pop(context);
          }),
      body: BlocProvider(
        create: (context) => QuranCubit()..getQuran(),
        child: BlocConsumer<QuranCubit, QuranStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = QuranCubit.get(context);

            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 30.0.sp),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        textCustom(
                          context: context,
                          text: 'السورة',
                          fontSize: 26.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        textCustom(
                          context: context,
                          text: 'عدد الآيات',
                          fontSize: 26.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                  ),
                  ConditionalBuilder(
                    condition: cubit.list.isNotEmpty,
                    builder: (context) {
                      return ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: cubit.list.length,
                        shrinkWrap: true,
                        itemExtent: 80,
                        itemBuilder: (BuildContext context, int index) =>
                            Container(
                              // width: double.infinity,
                              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 0,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16.0.r),
                                boxShadow: [
                                  BoxShadow(spreadRadius: 1,
                                    color: Colors.grey[200]!,
                                    offset: const Offset(0.0, 3), //(x,y)
                                    blurRadius: 2.0,
                                  ),
                                ],
                                color: ColorManager.cardColor,
                              ),
                              child: ListTile(
                                  title: textCustom(
                                    height: 0.0,
                                    context: context,
                                    text: cubit.list[index]['name'],
                                    fontSize: 20.sp,
                                  ),
                                  subtitle: textCustom(
                                    height: 0.0,
                                      context: context,
                                      text: cubit.list[index]
                                          ['transliteration'],
                                      color: ColorManager.grey2),
                                  trailing: SizedBox(
                                    width: 100,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        textCustom(
                                          context: context,
                                          text:
                                             '(${cubit.list[index]['total_verses']})',
                                          fontSize: 16.sp,
                                        ),
                                        SizedBox(
                                          width: 10.w,
                                        ),
                                        Image(
                                          image: cubit.list[index]['type'] ==
                                                  'meccan'
                                              ? const AssetImage(
                                                  'assets/images/kaaba.png',
                                                )
                                              : const AssetImage(
                                                  'assets/images/madena.png',
                                                ),
                                          width: 30,
                                          height: 50,
                                        )
                                      ],
                                    ),
                                  ),
                                  onTap: () {
                                    /// Push to Quran view ([int pages] represent surah page(reversed index))
                                    navigator(context, SurahScreen(
                                        id: cubit.list[index]['id']
                                            .toString()));

                                  }),
                            ),
                      );
                    },
                    fallback: (context) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
