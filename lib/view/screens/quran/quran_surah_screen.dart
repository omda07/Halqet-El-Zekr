import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hesn_elmuslim/cubit/quran/quran_cubit.dart';
import 'package:hesn_elmuslim/cubit/quran/quran_state.dart';
import 'package:hesn_elmuslim/view/resources/color_manager.dart';
import 'package:hesn_elmuslim/view/screens/quran/surah_screen.dart';
import 'package:hesn_elmuslim/view/widgets/app_bar/app_bar_custom.dart';

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
              child: Padding(
                padding: EdgeInsets.all(20.0.sp),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        textCustom(
                          context: context,
                          text: 'الصورة',
                          fontSize: 28.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        textCustom(
                          context: context,
                          text: 'عدد الآيات',
                          fontSize: 28.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
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
                              ListTile(
                                  title: textCustom(
                                    context: context,
                                    text: cubit.list[index]['name'],
                                    fontSize: 20.sp,
                                  ),
                                  subtitle: textCustom(
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
                                              "${cubit.list[index]['total_verses']}",
                                          fontSize: 20.sp,
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
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => SurahScreen(
                                                id: cubit.list[index]['id']
                                                    .toString())));
                                  }),
                        );
                      },
                      fallback: (context) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
