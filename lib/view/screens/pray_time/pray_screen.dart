import 'package:analog_clock/analog_clock.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hesn_elmuslim/cubit/home/home_cubit.dart';
import 'package:hesn_elmuslim/cubit/home/home_state.dart';
import 'package:hesn_elmuslim/view/widgets/app_bar/app_bar_custom.dart';
import 'package:hesn_elmuslim/view/widgets/text_custom/text_custom.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import '../../resources/color_manager.dart';

class PrayTimeScreen extends StatelessWidget {
  const PrayTimeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('ar_EG');
    return Scaffold(
      appBar: appBarCustom(
          context: context,
          leading: 'مواقيت الصلاة',
          onPressed: () {
            Navigator.pop(context);
          }),
      body: BlocProvider(
        create: (context) => HomeCubit()..determinePosition(),
        child: BlocConsumer<HomeCubit, HomeStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = HomeCubit.get(context);

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
                              // border: Border.all(width: 2.0, color: Colors.black),
                              color: ColorManager.cardColor,
                              shape: BoxShape.circle),
                          width: 200.0.w,
                          isLive: true,
                          hourHandColor: ColorManager.primary,
                          minuteHandColor: ColorManager.primary,
                          showSecondHand: true,
                          numberColor: ColorManager.primary,secondHandColor: ColorManager.kGreenColor,
                          showNumbers: true,
                          showAllNumbers: true,
                          textScaleFactor: 2.0,
                          showTicks: true,
                          showDigitalClock: false,
                          datetime: DateTime.now(),
                        ),
                        row(
                          context: context,
                          text: 'الفجر',
                          time: DateFormat.jm('ar_EG')
                              .format(cubit.prayerTimes!.fajr)
                              .toString(),
                        ),
                        row(
                          context: context,
                          text: 'الشروق',
                          time: DateFormat.jm('ar_EG')
                              .format(cubit.prayerTimes!.sunrise)
                              .toString(),
                        ),
                        row(
                          context: context,
                          text: 'الظهر',
                          time: DateFormat.jm('ar_EG')
                              .format(cubit.prayerTimes!.dhuhr)
                              .toString(),
                        ),
                        row(
                          context: context,
                          text: 'العصر',
                          time: DateFormat.jm('ar_EG')
                              .format(cubit.prayerTimes!.asr)
                              .toString(),
                        ),
                        row(
                          context: context,
                          text: 'المغرب',
                          time: DateFormat.jm('ar_EG')
                              .format(cubit.prayerTimes!.maghrib)
                              .toString(),
                        ),
                        row(
                          context: context,
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

  Widget row(
      {required BuildContext context,
      required String text,
      required String time}) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(
        bottom: 12.h,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 16,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey[100]!,
            offset: const Offset(0.0, 3.0), //(x,y)
            blurRadius: 1.0,
          ),
        ],
        color: ColorManager.cardColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          textCustom(
            height: 0.0,
            text: text,
            context: context,
            fontSize: 24,
          ),
          textCustom(
            height: 0.0,
            text: time,
            context: context,
            fontSize: 24,
          ),
        ],
      ),
    );
  }
}
