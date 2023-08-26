import 'package:analog_clock/analog_clock.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hesn_elmuslim/core/utils/assets_manager.dart';
import 'package:hesn_elmuslim/core/utils/values_manager.dart';
import 'package:hesn_elmuslim/core/widgets/scaffold_custom/scaffold_custom.dart';

import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import '../../../../core/utils/color_manager.dart';
import '../../../../core/widgets/app_bar/app_bar_custom.dart';
import '../pray_time_cubit/pray_time_cubit.dart';
import '../pray_time_cubit/pray_time_state.dart';
import '../widgets/RowTime.dart';

class PrayTimeScreen extends StatelessWidget {
  const PrayTimeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('ar_EG');
    return ScaffoldCustom(
      appBarCustom: const AppBarCustom(
        text: 'مواقيت الصلاة',
      ),
      body: BlocProvider.value(
        value: BlocProvider.of<PrayTimeCubit>(context)..determinePosition(),
        child: BlocConsumer<PrayTimeCubit, PrayTimeStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = PrayTimeCubit.get(context);

            return ConditionalBuilder(
              condition: cubit.locationData != null,
              builder: (context) {
                return Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        AnalogClock(
                          height: 200.h,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                  ImageAssets.logoImg,
                                ),
                                fit: BoxFit.scaleDown,
                                opacity: 0.1,
                              ),
                              color: ColorManager.secondary2,
                              shape: BoxShape.circle),
                          width: 200.0.w,
                          isLive: true,
                          tickColor: ColorManager.primary,
                          hourHandColor: ColorManager.primary,
                          minuteHandColor: ColorManager.primary,
                          showSecondHand: true,
                          numberColor: ColorManager.primary,
                          secondHandColor: ColorManager.greenColor,
                          showNumbers: true,
                          showAllNumbers: true,
                          textScaleFactor: 2,
                          showTicks: true,
                          digitalClockColor: ColorManager.error,
                          showDigitalClock: true,
                          datetime: DateTime.now(),
                        ),
                        SizedBox(
                          height: AppSize.s16.h,
                        ),
                        RowTime(
                          icon: 'assets/images/cloudy-night.png',
                          text: 'الفجر',
                          time: DateFormat.jm('ar_EG')
                              .format(cubit.prayerTimes!.fajr)
                              .toString(),
                        ),
                        RowTime(
                          icon: 'assets/images/sunrise.png',
                          text: 'الشروق',
                          time: DateFormat.jm('ar_EG')
                              .format(cubit.prayerTimes!.sunrise)
                              .toString(),
                        ),
                        RowTime(
                          icon: 'assets/images/sun.png',
                          text: 'الظهر',
                          time: DateFormat.jm('ar_EG')
                              .format(cubit.prayerTimes!.dhuhr)
                              .toString(),
                        ),
                        RowTime(
                          icon: 'assets/images/cloudy.png',
                          text: 'العصر',
                          time: DateFormat.jm('ar_EG')
                              .format(cubit.prayerTimes!.asr)
                              .toString(),
                        ),
                        RowTime(
                          icon: 'assets/images/sunset.png',
                          text: 'المغرب',
                          time: DateFormat.jm('ar_EG')
                              .format(cubit.prayerTimes!.maghrib)
                              .toString(),
                        ),
                        RowTime(
                          icon: 'assets/images/night-mode.png',
                          text: 'العشاء',
                          time: DateFormat.jm('ar_EG')
                              .format(cubit.prayerTimes!.isha)
                              .toString(),
                        ),
                      ],
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
      ),
    );
  }
}
