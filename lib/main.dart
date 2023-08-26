import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hesn_elmuslim/core/api/end_points.dart';
import 'package:hesn_elmuslim/core/general_controllers/font_controller/font_cubit.dart';
import 'package:hesn_elmuslim/core/utils/routes_manager.dart';
import 'package:hesn_elmuslim/core/utils/strings_manager.dart';
import 'package:hesn_elmuslim/features/azkar/presentation/azkar_cubit/azkar_cubit.dart';
import 'package:hesn_elmuslim/features/duaa/presentation/duaa_cubit/duaa_cubit.dart';
import 'package:hesn_elmuslim/features/hadeth/presentation/hadeth_cubit/hadeth_cubit.dart';
import 'package:hesn_elmuslim/features/hadeth/presentation/hadeth_details_cubit/hadeth_details_cubit.dart';
import 'package:hesn_elmuslim/features/hadeth/presentation/hadeth_info_cubit/hadeth_info_cubit.dart';
import 'package:hesn_elmuslim/features/pray_time/presentation/pray_time_cubit/pray_time_cubit.dart';
import 'package:hesn_elmuslim/features/quran/presentation/quran_off/quran_off_cubit.dart';
import 'package:hesn_elmuslim/features/yasser_dousery/presentation/manager/rooms_cubit/yasser_surah_cubit.dart';
import 'package:hesn_elmuslim/features/zakat/presentation/zakat_cubit/zakat_cubit.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'core/local/cache_helper.dart';
import 'core/notifications/notification_helper.dart';
import 'core/utils/theme_manager.dart';
import 'features/home/presentation/home_cubit/home_cubit.dart';
import 'features/network/dio_helper.dart';
import 'features/quran/presentation/quran_cubit/quran_cubit.dart';
import 'features/quran/presentation/surah_cubit/surah_cubit.dart';
import 'features/quran_audio/presentation/controller/aduio_cubit/audio_cubit.dart';
import 'features/quran_audio/presentation/controller/recitations_cubit/recitations_cubit.dart';
import 'features/tasbih/presentation/tasbih_cubit/tasbih_cubit.dart';
import 'injection_container.dart';
import 'injection_container.dart' as di;
import 'observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DioHelper.init(EndPoints.getHadeeth);
  await di.init();
  await CacheHelper.init();


  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
    androidNotificationIcon: 'mipmap/launcher_icon',

  );

  await NotificationController.initializeLocalNotifications();


  //Remove this method to stop OneSignal Debugging
  OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
// Your ID if you used OnSignal
  OneSignal.shared.setAppId("");

  OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
    debugPrint("Accepted permission: $accepted");
  });
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => HomeCubit()..determinePosition()),
        BlocProvider(create: (context) => AzkarCubit()),
        BlocProvider(create: (context) => DuaaCubit()),
        BlocProvider(create: (context) => sl<HadethCubit>()),
        BlocProvider(create: (context) => sl<HadethDetailsCubit>()),
        BlocProvider(create: (context) => sl<HadethInfoCubit>()),
        BlocProvider(create: (context) => PrayTimeCubit()..determinePosition()),
        BlocProvider(create: (context) => ZakatCubit()),
        BlocProvider(create: (context) => QuranOffCubit()),
        BlocProvider(create: (context) => TasbihCubit()),
        BlocProvider(create: (context) => sl<QuranCubit>()),
        BlocProvider(create: (context) => sl<SurahCubit>()),
        BlocProvider(create: (context) => sl<RecitationsCubit>()),
        BlocProvider(create: (context) => sl<AudioCubit>()),
        BlocProvider(create: (context) => sl<QuranAudioCubit>()),
        BlocProvider(create: (context) => TasbihCubit()),
        BlocProvider(create: (context) => FontCubit()..getFontSize()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(400, 860),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (BuildContext context, widgets) => MaterialApp(
          title: AppStrings.appName,

          routes: RoutesMap.routesMap(),
          builder: (context, widget) {
            // DynamicLinksHelper().initDynamicLink(context);

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
          initialRoute: Routes.splashRoute,
          // home: const UpdateApp(),
        ),
      ),
    );
  }
}
