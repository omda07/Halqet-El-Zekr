import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hesn_elmuslim/cubit/database/network/dio_helper.dart';
import 'package:hesn_elmuslim/cubit/home/home_cubit.dart';
import 'package:hesn_elmuslim/cubit/quran/quran_cubit.dart';
import 'package:hesn_elmuslim/view/screens/azkar/athkar_screen.dart';
import 'package:hesn_elmuslim/view/screens/duaa/duaa_screen.dart';
import 'package:hesn_elmuslim/view/screens/main_page.dart';
import 'package:hesn_elmuslim/view/screens/pray_time/pray_screen.dart';
import 'package:hesn_elmuslim/view/screens/qibla/qibla_screen.dart';
import 'package:hesn_elmuslim/view/screens/quran/quran_surah_screen.dart';
import 'package:hesn_elmuslim/view/screens/tasbih/tasbih_screen.dart';
import 'package:hesn_elmuslim/view/screens/zakat/zakat_screen.dart';
import 'package:hesn_elmuslim/view/styles/theme.dart';

import 'cubit/cubit For Internet/internet_cubit.dart';
import 'observer.dart';
import 'view/screens/quran/quran_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  BlocOverrides.runZoned(
    () {
      // Use cubits...
      runApp(const MyApp());
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => InternetCubit()),
        BlocProvider(create: (context) => HomeCubit()),
        BlocProvider(create: (context) => QuranCubit()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (BuildContext context, widgets) => MaterialApp(
          routes: {
            'azkarScreen': (BuildContext context) => const AthkarScreen(),
            'tasbehScreen': (BuildContext context) => const TasbehScreen(),
            'DuaaScreen': (BuildContext context) => const DuaaScreen(),
            'zakat': (BuildContext context) => ZakatScreen(),
            'qibla': (BuildContext context) => QiblaScreen(),
            'pray': (BuildContext context) => PrayTimeScreen(),
            'quran': (BuildContext context) => QuranSurahScreen(),
            'quranOff': (BuildContext context) => QuranScreen(),
            // 'hadeethCategoriesScreen': (BuildContext context) =>  const HadeethCategoriesScreen(),
          },
          builder: (context, widget) {
            return MediaQuery(
              //Setting font does not change with system font size
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: widget!,
              ),
            );
          },
          //This to Hide Debugger Banner in UI.
          debugShowCheckedModeBanner: false,
          theme: getApplicationTheme(),
          //Here The Theme.

          home: MainPage(),
        ),
      ),
    );
  }
}
