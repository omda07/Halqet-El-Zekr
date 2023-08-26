import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hesn_elmuslim/core/utils/values_manager.dart';
import 'package:hesn_elmuslim/core/widgets/component.dart';
import 'package:hesn_elmuslim/features/yasser_dousery/presentation/manager/rooms_cubit/yasser_surah_cubit.dart';
import 'package:hesn_elmuslim/features/yasser_dousery/presentation/manager/rooms_cubit/yasser_surah_state.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/constants_manager.dart';
import '../../../../core/utils/routes_manager.dart';
import '../../../../core/widgets/app_bar/app_bar_custom.dart';
import '../../../../core/widgets/error_widget.dart';
import '../../../../core/widgets/ornament.dart';
import '../../../../core/widgets/scaffold_custom/scaffold_custom.dart';
import '../../../../core/widgets/shimmer_custom/grid_shimmer.dart';
import '../../../../core/widgets/text_custom/text_custom.dart';
import '../../../quran_audio/presentation/controller/aduio_cubit/audio_cubit.dart';

class YasserSurah extends StatelessWidget {
  const YasserSurah({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldCustom(
      appBarCustom: const AppBarCustom(
        text: 'ياسر الدوسري',
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: BlocProvider.value(
            value: BlocProvider.of<QuranAudioCubit>(context)..getQuranAudios(),
            child: BlocConsumer<QuranAudioCubit, QuranAudioStates>(
              listener: (context, state) {
                // TODO: implement listener
              },
              builder: (context, state) {
                var cubit = QuranAudioCubit.get(context);
                return state is GetQuranAudioSuccess
                    ? GridView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: state.quranAudioEntity.surahEntity.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) =>
                            InkWell(
                          onTap: () async {
                            AudioCubit.get(context).surahId = index;
                            AudioCubit.get(context).getSurahName(state.quranAudioEntity.surahEntity[index].title);
                            AppConstants.reciterName = state.quranAudioEntity.surahEntity[index].content;
                            // for (var element in state.quranAudioEntity.surahEntity) {
                            //   SurahNames.audio.add(element.quranAudioPath);
                            // }
                            navigator(context, Routes.quranAudioRoute);
                            // await cubitQ.getQuranAudioFun();
                          },
                          child: FadeIn(
                            duration: const Duration(milliseconds: 300),
                            child: Container(
                              // width: double.infinity,
                              alignment: Alignment.center,
                              margin: EdgeInsets.symmetric(
                                  horizontal: 8.w, vertical: 5.h),

                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16.0.r),
                                boxShadow: [
                                  BoxShadow(
                                    spreadRadius: 1,
                                    color: Colors.grey[200]!,
                                    offset: const Offset(0.0, 3), //(x,y)
                                    blurRadius: 2.0,
                                  ),
                                ],
                                color: ColorManager.card1Color,
                              ),
                              child: Stack(
                                children: [
                                  const Align(
                                    alignment: Alignment.center,
                                    child: Ornament(
                                      iconName: IconsAssets.ornament1Icon,
                                      iconColor:
                                          ColorManager.labelUnSelectedColor,
                                    ),
                                  ),
                                  Center(
                                    child: TextCustom(
                                      height: 0.0,
                                      text: state.quranAudioEntity
                                          .surahEntity[index].title,
                                      fontSize: 20.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 200,
                                childAspectRatio: 3 / 2,
                                crossAxisSpacing: 20,
                                mainAxisSpacing: 20),
                      )
                    : state is GetQuranAudioLoading
                        ? const GridShimmer()
                        : ErrorWidgetCustom(
                            onPress: () async {
                              await cubit.getQuranAudios();
                            },
                          );
              },
            ),
          ),
        ),
      ),
    );
  }
}
