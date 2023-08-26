import 'package:flutter/material.dart';
import 'package:hesn_elmuslim/core/widgets/scaffold_custom/scaffold_custom.dart';
import 'package:hesn_elmuslim/features/hadeth/presentation/screens/hadeth_details_screen.dart';
import 'package:hesn_elmuslim/features/hadeth/presentation/screens/hadeth_info_screen.dart';
import 'package:hesn_elmuslim/features/help_and_feedback/presentation/screens/help_and_feedback_screen.dart';
import 'package:hesn_elmuslim/features/home/presentation/screens/home_screen.dart';
import 'package:hesn_elmuslim/features/main_page.dart';
import 'package:hesn_elmuslim/features/quran/presentation/screens/surah_screen.dart';
import 'package:hesn_elmuslim/features/quran_audio/presentation/screens/quran_audio_screen.dart';
import 'package:hesn_elmuslim/features/splash/presentation/pages/splash_screen.dart';
import 'package:hesn_elmuslim/features/yasser_dousery/presentation/pages/surah_screen.dart';
import '../../features/azkar/presentation/screens/athkar_screen.dart';
import '../../features/duaa/presentation/screens/duaa_details_screen.dart';
import '../../features/duaa/presentation/screens/duaa_screen.dart';
import '../../features/hadeth/presentation/screens/hadeth_screen.dart';
import '../../features/pray_time/presentation/screens/pray_screen.dart';
import '../../features/qibla/presentation/screens/qibla_screen.dart';
import '../../features/quran/presentation/screens/quran_screen.dart';
import '../../features/quran/presentation/screens/quran_surah_screen.dart';
import '../../features/quran_audio/presentation/screens/quran_just_audio_screen.dart';
import '../../features/quran_audio/presentation/screens/recitations_screen.dart';
import '../../features/settings/presentation/screens/settings_screen.dart';
import '../../features/tasbih/presentation/screens/selected_tasbih_screen.dart';
import '../../features/tasbih/presentation/screens/tasbih_screen.dart';
import '../../features/zakat/presentation/screens/zakat_screen.dart';

class Routes {
  static const String splashRoute = "splashScreen";
  static const String mainRoute = "mainScreen";
  static const String homeRoute = "homeScreen";
  static const String settingsRoute = "settingsScreen";
  static const String quranDuaaRoute = "quranDuaaScreen";
  static const String peopleDuaaRoute = "peopleDuaaScreen";

  static const String azkarRoute = "azkarScreen";
  static const String tasbehRoute = "tasbehScreen";
  static const String selectedTasbehScreenRoute = "selectedTasbehScreen";
  static const String duaaRoute = "duaaScreen";
  static const String duaaDetailsRoute = "duaaDetailsScreen";
  static const String zakatRoute = "zakat";
  static const String qiblaRoute = "qibla";
  static const String prayRoute = "pray";
  static const String quranRoute = "quran";
  static const String surahRoute = "surah";
  static const String quranOffRoute = "quranOff";
  static const String quranSoundRoute = "quranSound";
  static const String quranAudioRoute = "quranAudio";
  static const String recitationsRoute = "recitations";
  static const String hadethRoute = "hadeth";
  static const String hadethDetailsRoute = "hadethDetails";
  static const String hadethInfoRoute = "hadethInfo";
  static const String audioRoute = "audio";
  static const String helpScreenRoute = "helpScreen";
  static const String yasserSurahRoute = "yasserSurah";

  static Route createRoute(String screen) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          RoutesMap.routeMap(screen),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = const Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeOut;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}

class RoutesMap {
  static Map<String, Widget Function(BuildContext)> routesMap() {
    return {
      Routes.splashRoute: (BuildContext context) => const SplashScreen(),
      Routes.mainRoute: (BuildContext context) => const MainPage(),
      Routes.homeRoute: (BuildContext context) => const HomeScreen(),

      Routes.settingsRoute: (BuildContext context) => const SettingsScreen(),

      Routes.azkarRoute: (BuildContext context) => const AthkarScreen(),
      Routes.tasbehRoute: (BuildContext context) => const TasbehScreen(),
      Routes.selectedTasbehScreenRoute: (BuildContext context) =>
          const SelectedTasbehScreen(),
      Routes.duaaRoute: (BuildContext context) => const DuaaScreen(),
      Routes.zakatRoute: (BuildContext context) => ZakatScreen(),
      Routes.qiblaRoute: (BuildContext context) => QiblaScreen(),
      Routes.prayRoute: (BuildContext context) => const PrayTimeScreen(),
      Routes.quranRoute: (BuildContext context) => const QuranSurahScreen(),
      Routes.quranOffRoute: (BuildContext context) => const QuranScreen(),
      Routes.recitationsRoute: (BuildContext context) =>
          const RecitationsScreen(),
      Routes.quranSoundRoute: (BuildContext context) =>
          const QuranAudioScreen(),
      Routes.quranAudioRoute: (BuildContext context) =>
          const QuranJustAudioScreen(),

      Routes.hadethRoute: (BuildContext context) =>
          const HadethCategoriesScreen(),
      Routes.hadethDetailsRoute: (BuildContext context) =>
          const HadethDetailsScreen(),
      Routes.hadethInfoRoute: (BuildContext context) =>
          const HadethInfoScreen(),
      Routes.duaaDetailsRoute: (BuildContext context) =>
          const DuaaDetailsScreen(),
      Routes.surahRoute: (BuildContext context) => const SurahScreen(),
      Routes.helpScreenRoute: (BuildContext context) => HelpAndFeedbackScreen(),
      Routes.yasserSurahRoute: (BuildContext context) => const YasserSurah(),
    };
  }

  static Widget routeMap(String screen) {
    switch (screen) {
      case Routes.splashRoute:
        return const SplashScreen();
      case Routes.mainRoute:
        return const MainPage();
      case Routes.homeRoute:
        return const HomeScreen();

      case Routes.settingsRoute:
        return const SettingsScreen();
      case Routes.azkarRoute:
        return const AthkarScreen();
      case Routes.tasbehRoute:
        return const TasbehScreen();
      case Routes.selectedTasbehScreenRoute:
        return const SelectedTasbehScreen();
      case Routes.duaaRoute:
        return const DuaaScreen();
      case Routes.zakatRoute:
        return ZakatScreen();
      case Routes.qiblaRoute:
        return QiblaScreen();
      case Routes.prayRoute:
        return const PrayTimeScreen();
      case Routes.quranRoute:
        return const QuranSurahScreen();
      case Routes.quranOffRoute:
        return const QuranScreen();
      case Routes.recitationsRoute:
        return const RecitationsScreen();
      case Routes.quranSoundRoute:
        return const QuranAudioScreen();
      case Routes.quranAudioRoute:
        return const QuranJustAudioScreen();
      case Routes.hadethDetailsRoute:
        return const HadethDetailsScreen();
      case Routes.hadethRoute:
        return const HadethCategoriesScreen();
      case Routes.hadethInfoRoute:
        return const HadethInfoScreen();
      case Routes.duaaDetailsRoute:
        return const DuaaDetailsScreen();
      case Routes.surahRoute:
        return const SurahScreen();
      case Routes.helpScreenRoute:
        return HelpAndFeedbackScreen();
      case Routes.yasserSurahRoute:
        return const YasserSurah();
      default:
        return const ScaffoldCustom(body: SizedBox());
    }
  }
}
