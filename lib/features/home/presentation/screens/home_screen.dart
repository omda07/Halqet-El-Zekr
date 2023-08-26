import 'package:animate_do/animate_do.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hesn_elmuslim/core/utils/assets_manager.dart';
import 'package:hesn_elmuslim/core/utils/constants_manager.dart';
import 'package:hesn_elmuslim/core/utils/routes_manager.dart';
import 'package:hesn_elmuslim/core/utils/strings_manager.dart';
import 'package:hesn_elmuslim/core/utils/values_manager.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/media_query_values.dart';
import '../../../../core/widgets/text_custom/text_custom.dart';
import '../home_cubit/home_cubit.dart';
import '../home_cubit/home_state.dart';
import '../widgets/home_card.dart';
import '../widgets/home_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    HijriCalendar.setLocal('ar');
    initializeDateFormatting('ar_EG');
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: BlocProvider.value(
        value: BlocProvider.of<HomeCubit>(context)..determinePosition(),
        child: BlocConsumer<HomeCubit, HomeStates>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            var cubit = HomeCubit.get(context);
            return SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: AppSize.s100 * 2.6,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Container(
                          width: double.infinity,
                          color: ColorManager.secondary2,
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: AppSize.s100 * 2.6,
                          child: FadeIn(
                            child: Image.asset(
                              ImageAssets.mosqueImg,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        ConditionalBuilder(
                          condition: cubit.locationData != null &&
                              cubit.myCoordinates != null &&
                              cubit.params != null,
                          builder: (context) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextCustom(
                                    height: 0.0,
                                    text: cubit.getPrayerName() != null
                                        ? '${cubit.getPrayerName()}'
                                        : AppStrings.empty,
                                    color: ColorManager.primary,
                                    fontSize: 18.sp),
                                TextCustom(
                                    height: 0.0,
                                    text: cubit.getPrayer() != null
                                        ? DateFormat.jm('ar_EG')
                                            .format(cubit.getPrayer()!)
                                        : AppStrings.empty,
                                    color: ColorManager.primary,
                                    fontSize: 20.sp),
                              ],
                            );
                          },
                          fallback: (context) => const TextCustom(
                            text: AppStrings.empty,
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding: EdgeInsets.only(right: 10.w, top: 10.h),
                            child: ClipRect(
                              child: TextCustom(
                                  height: 0,
                                  text: cubit.hDate.fullDate(),
                                  color: ColorManager.black,
                                  fontSize: 20.sp),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const HomeItem(title: 'القرآن الكريم', widgets: <Widget>[
                    HomeCard(
                      label: AppStrings.quran,
                      url: ImageAssets.quranImg,
                      screen: Routes.quranRoute,
                    ),
                    HomeCard(
                      label: AppStrings.quran2,
                      url: ImageAssets.quranAImg,
                      screen: Routes.recitationsRoute,
                    ),
                    HomeCard(
                      label: AppStrings.quran1,
                      url: ImageAssets.quran1Img,
                      screen: Routes.quranOffRoute,
                    ),
                    HomeCard(
                      label: AppStrings.yasser,
                      url: ImageAssets.quranAImg,
                      screen: Routes.yasserSurahRoute,
                    ),
                  ]),
                  const HomeItem(title: 'اذكار و ادعية', widgets: <Widget>[
                    HomeCard(
                      label: AppStrings.tasbeh,
                      url: ImageAssets.tasbihImg,
                      screen: Routes.tasbehRoute,
                    ),
                    HomeCard(
                      label: AppStrings.azkar,
                      url: ImageAssets.moonImg,
                      screen: Routes.azkarRoute,
                    ),
                    HomeCard(
                      label: AppStrings.duaa,
                      url: ImageAssets.prayImg,
                      screen: Routes.duaaRoute,
                    ),
                    HomeCard(
                      label: AppStrings.hadith,
                      url: ImageAssets.muslimImg,
                      screen: Routes.hadethRoute,
                    ),
                  ]),
                  const HomeItem(title: 'المزيد', widgets: <Widget>[
                    HomeCard(
                      label: AppStrings.prayTime,
                      url: ImageAssets.prayerMatImg,
                      screen: Routes.prayRoute,
                    ),

                    HomeCard(
                      label: AppStrings.qibla,
                      url: ImageAssets.qiblaImg,
                      screen: Routes.qiblaRoute,
                    ),
                    HomeCard(
                      label: AppStrings.zakat,
                      url: ImageAssets.moneyBagImg,
                      screen: Routes.zakatRoute,
                    ),
                  ]),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
