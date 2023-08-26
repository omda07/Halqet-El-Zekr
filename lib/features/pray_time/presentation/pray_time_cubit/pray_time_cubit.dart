import 'package:adhan/adhan.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'pray_time_state.dart';

class PrayTimeCubit extends Cubit<PrayTimeStates> {
  PrayTimeCubit() : super(InitialHomeState());

  static PrayTimeCubit get(context) => BlocProvider.of(context);

  Position? locationData;
  Coordinates? myCoordinates;
  CalculationParameters? params;
  PrayerTimes? prayerTimes;
  final GeolocatorPlatform geolocatorPlatform = GeolocatorPlatform.instance;
  // Future<Position> determinePosition() async {
  //   bool serviceEnabled;
  //   LocationPermission permission;
  //
  //   // Test if location services are enabled.
  //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     // Location services are not enabled don't continue
  //     // accessing the position and request users of the
  //     // App to enable the location services.
  //     return Future.error('Location services are disabled.');
  //   }
  //
  //   permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       // Permissions are denied, next time you could try
  //       // requesting permissions again (this is also where
  //       // Android's shouldShowRequestPermissionRationale
  //       // returned true. According to Android guidelines
  //       // your App should show an explanatory UI now.
  //       return Future.error('Location permissions are denied');
  //     }
  //   }
  //
  //   if (permission == LocationPermission.deniedForever) {
  //     // Permissions are denied forever, handle appropriately.
  //     return Future.error(
  //         'Location permissions are permanently denied, we cannot request permissions.');
  //   }
  //
  //   // When we reach here, permissions are granted and we can
  //   // continue accessing the position of the device.
  //   return await Geolocator.getCurrentPosition();
  // }
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

      // emit(GetPrayer());
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
  // makeNotification()async{
  //   String localTimeZone = await AwesomeNotifications().getLocalTimeZoneIdentifier();
  //   getPrayer();
  // }
}
