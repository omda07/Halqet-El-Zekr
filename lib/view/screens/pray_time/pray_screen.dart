import 'package:adhan/adhan.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hesn_elmuslim/cubit/home/home_cubit.dart';
import 'package:hesn_elmuslim/cubit/home/home_state.dart';
import 'package:hesn_elmuslim/view/widgets/app_bar/app_bar_custom.dart';
import 'package:hesn_elmuslim/view/widgets/text_custom/text_custom.dart';
import 'package:intl/intl.dart';

class PrayTimeScreen extends StatelessWidget {
  const PrayTimeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarCustom(context: context, leading: 'مواقيت الصلاة',onPressed: (){
        Navigator.pop(context);
      }),
      body: BlocProvider(
        create: (context) => HomeCubit()..determinePosition(),
        child: BlocConsumer<HomeCubit, HomeStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = HomeCubit.get(context);

            return ConditionalBuilder(
              condition: cubit.locationData != null ,
              builder: (context) {
                final myCoordinates = Coordinates(
                  cubit.locationData!.latitude!,
                  cubit.locationData!
                      .longitude!,); // Replace with your own location lat, lng.
                final params = CalculationMethod.egyptian.getParameters();
                params.madhab = Madhab.shafi;
                final prayerTimes = PrayerTimes.today(myCoordinates, params);
                return Padding(
                  padding: EdgeInsets.all(20.sp),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          textCustom(
                            text: 'الفجر',
                            context: context,
                            fontSize: 24,
                          ),
                          textCustom(
                            text: DateFormat.jm().format(prayerTimes.fajr),
                            context: context,
                            fontSize: 24,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          textCustom(
                            text: 'الشروق',
                            context: context,
                            fontSize: 24,
                          ),
                          textCustom(
                            text:  DateFormat.jm().format(prayerTimes.sunrise),
                            context: context,
                            fontSize: 24,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          textCustom(
                            text: 'الظهر',
                            context: context,
                            fontSize: 24,
                          ),
                          textCustom(
                            text: DateFormat.jm().format(prayerTimes.dhuhr),
                            context: context,
                            fontSize: 24,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          textCustom(
                            text: 'العصر',
                            context: context,
                            fontSize: 24,
                          ),
                          textCustom(
                            text:DateFormat.jm().format(prayerTimes.asr),
                            context: context,
                            fontSize: 24,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          textCustom(
                            text: 'المغرب',
                            context: context,
                            fontSize: 24,
                          ),
                          textCustom(
                            text: DateFormat.jm().format(prayerTimes.maghrib),
                            context: context,
                            fontSize: 24,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          textCustom(
                            text: 'العشاء',
                            context: context,
                            fontSize: 24,
                          ),
                          textCustom(
                            text: DateFormat.jm().format(prayerTimes.isha),
                            context: context,
                            fontSize: 24,
                          ),
                        ],
                      ),

                    ],
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
