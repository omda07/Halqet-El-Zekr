import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hesn_elmuslim/cubit/home/home_cubit.dart';
import 'package:hesn_elmuslim/cubit/home/home_state.dart';
import 'package:hesn_elmuslim/view/resources/color_manager.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import '../widgets/text_custom/text_custom.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  HijriCalendar hDate = HijriCalendar.now();

  @override
  Widget build(BuildContext context) {
    HijriCalendar.setLocal('ar');
    initializeDateFormatting('ar_EG');
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.topRight,
            children: [
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(bottomRight: Radius.circular(20.0.r),bottomLeft: Radius.circular(20.0.r)),
                    child: SizedBox(
                      width: double.infinity,
                      child: Image.asset(
                        'assets/images/mosque.jpg',
                      ),
                    ),
                  ),
                  BlocProvider(
                    create: (context) => HomeCubit()..determinePosition(),
                    child: BlocConsumer<HomeCubit, HomeStates>(
                      listener: (context, state) {},
                      builder: (context, state) {
                        var cubit = HomeCubit.get(context);

                        return ConditionalBuilder(
                          condition: cubit.locationData != null &&
                              cubit.myCoordinates != null &&
                              cubit.params != null,
                          builder: (context) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [

                                textCustom(
                                  height: 0,
                                    context: context,
                                    text: cubit.getPrayerName() != null ?'${cubit.getPrayerName()}':'',
                                    color: ColorManager.primary,
                                    fontSize: 18.sp),
                                textCustom(
                                  height: 0,
                                    context: context,
                                    text:cubit.getPrayer() != null  ? DateFormat.jm('ar_EG')
                                        .format(cubit.getPrayer()!) : '',
                                    color: ColorManager.primary,
                                    fontSize: 20.sp),
                              ],
                            );
                          },
                          fallback: (context) =>
                              textCustom(text: '', context: context),
                        );
                      },
                    ),
                  ),
                ],
              ),
              Padding(
                padding:  EdgeInsets.only(right: 10.w, top: 36.h),

                child: textCustom(
                  height: 0,
                    context: context,
                    text: hDate.fullDate(),
                    color: ColorManager.black,
                    fontSize: 20.sp),
              ),
            ],
          ),
          GridView.count(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            primary: false,
            padding:  EdgeInsets.all(20.sp),
            childAspectRatio: 1.2,
            crossAxisCount: 2,
            children: <Widget>[
              buildItem(
                  label: 'القرآن الكريم',
                  url: 'assets/images/quran.png',
                  screen: 'quran',
                  context: context),
              buildItem(
                  label: 'المصحف',
                  url: 'assets/images/quran1.png',
                  screen: 'quranOff',
                  context: context),
              buildItem(
                  label: 'التسبيح',
                  url: 'assets/images/tasbih.png',
                  screen: 'tasbehScreen',
                  context: context),
              buildItem(
                  label: 'دعاء',
                  url: 'assets/images/pray.png',
                  screen: 'DuaaScreen',
                  context: context),
              buildItem(
                  label: 'القبلة',
                  url: 'assets/images/qibla.png',
                  screen: 'qibla',
                  context: context),
              buildItem(
                  label: 'الاحاديث النبوية',
                  url: 'assets/images/muslim.png',
                  screen: 'hadeth',
                  context: context),
              buildItem(
                  label: 'مواقيت الصلاة',
                  url: 'assets/images/prayer-mat.png',
                  screen: 'pray',
                  context: context),
              buildItem(
                  label: 'اذكار',
                  url: 'assets/images/moon.png',
                  screen: 'azkarScreen',
                  context: context),
              buildItem(
                  label: 'حساب الزكاة',
                  url: 'assets/images/money-bag.png',
                  screen: 'zakat',
                  context: context),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildItem({
    required String label,
    required String url,
    Function? onTap,
    context,
    String? screen,
  }) {
    return Container(
      margin:  EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        color: ColorManager.cardColor,
        boxShadow: [
          BoxShadow(
            color: Colors.grey[100]!,
            spreadRadius: 1,
            blurRadius: 1,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, screen!);
        },
        child: Container(
          padding:  EdgeInsets.symmetric(vertical: 10.h),
          child: Column(
            children: [
              Image.asset(
                url,
                width: 45.w,
                height: 45.h,
              ),
              textCustom(
                height: 0.0,
                  context: context,
                  text: label,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold),
            ],
          ),
        ),
      ),
    );
  }
}
