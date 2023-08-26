import 'package:adhan/adhan.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hijri/hijri_calendar.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(InitialHomeState());

  static HomeCubit get(context) => BlocProvider.of(context);

  int selectedIndex = 0;

  HijriCalendar hDate = HijriCalendar.now();

  Position? locationData;
  Coordinates? myCoordinates;
  CalculationParameters? params;
  PrayerTimes? prayerTimes;
  final GeolocatorPlatform geolocatorPlatform = GeolocatorPlatform.instance;

  determinePosition() async {
    bool serviceEnabled;
    LocationPermission permissionGranted;

    serviceEnabled = await geolocatorPlatform.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      // _updatePositionList(
      //   _PositionItemType.log,
      //   _kLocationServicesDisabledMessage,
      // );

      return false;
    }

    permissionGranted = await geolocatorPlatform.checkPermission();
    if (permissionGranted == LocationPermission.denied) {
      permissionGranted = await geolocatorPlatform.requestPermission();
      if (permissionGranted != LocationPermission.denied) {
        return;
      }
    }

    locationData = await geolocatorPlatform.getCurrentPosition();
    myCoordinates = Coordinates(
      locationData!.latitude,
      locationData!.longitude,
    ); // Replace with your own location lat, lng.
    params = CalculationMethod.egyptian.getParameters();

    params!.madhab = Madhab.shafi;
    prayerTimes = PrayerTimes.today(myCoordinates!, params!);
    emit(GetLocation());
  }

  String? getPrayerName() {
    switch (prayerTimes!.nextPrayer().name) {
      case 'fajr':
        return 'صلاة الفجر';
      case 'sunrise':
        return 'صلاة الشروق';
      case 'dhuhr':
        return 'صلاة الظهر';
      case 'asr':
        return 'صلاة العصر';
      case 'maghrib':
        return 'صلاة المغرب';
      case 'isha':
        return 'صلاة العشاء';
      case 'none':
      default:
        return null;

        emit(GetPrayer());
    }
  }

  DateTime? getPrayer() {
    switch (prayerTimes!.nextPrayer().name) {
      case 'fajr':
        return prayerTimes!.timeForPrayer(Prayer.fajr);
      case 'sunrise':
        return prayerTimes!.timeForPrayer(Prayer.sunrise);
      case 'dhuhr':
        return prayerTimes!.timeForPrayer(Prayer.dhuhr);
      case 'asr':
        return prayerTimes!.timeForPrayer(Prayer.asr);
      case 'maghrib':
        return prayerTimes!.timeForPrayer(Prayer.maghrib);
      case 'isha':
        return prayerTimes!.timeForPrayer(Prayer.isha);
      case 'none':
        return null;
      default:
        return null;

      // emit(GetPrayer());
    }
  }
}
