import 'dart:async';
import 'package:adhan/adhan.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:geolocator/geolocator.dart';

/* *********************************************
    PERMISSIONS
************************************************ */

class PrayerNotifications {
  Position? locationData;
  Coordinates? myCoordinates;
  CalculationParameters? params;
  PrayerTimes? prayerTimes;
  final GeolocatorPlatform geolocatorPlatform = GeolocatorPlatform.instance;
//
//   determinePosition() async {
//
// return prayerTimes;
//
//   }
  notifications() async {
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
    );
    // Replace with your own location lat, lng.

    params = CalculationMethod.egyptian.getParameters();

    params!.madhab = Madhab.shafi;
    prayerTimes = PrayerTimes.today(myCoordinates!, params!);
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) async {
      // awaitDeterminePosition();
      if (!isAllowed) {
        // This is just a basic example. For real apps, you must show some
        // friendly dialog box before call the request method.
        // This is very important to not harm the user experience
        AwesomeNotifications().requestPermissionToSendNotifications();
      } else {
        NotificationUtils.showAlarmNotificationProphet(id: 12);

        NotificationUtils.showAlarmNotificationProphet1(id: 13);
        NotificationUtils.showAlarmNotificationCompletePray(id: 14);
        NotificationUtils.showAlarmNotificationAzkarSabah(id: 15);
        NotificationUtils.showAlarmNotificationAzkarMasaa(id: 16);

        NotificationUtils.prayerNotificationsFajr(
          body: 'صلاة الفجر',
          title: 'صلاة الفجر',
          // hour:20,
          hour: prayerTimes?.fajr.hour != null ? prayerTimes!.fajr.hour : 4,
          // minute:46,
          minute: prayerTimes?.fajr.minute ?? 51,
          // second: 00,
          second: prayerTimes?.fajr.second ?? 00,
        );

        NotificationUtils.prayerNotificationsDuhr(
          body: 'صلاة الظهر',
          title: 'صلاة الظهر',
          hour: prayerTimes?.dhuhr.hour != null ? prayerTimes!.dhuhr.hour : 12,
          // hour:20 ,
          // minute:45,
          minute: prayerTimes?.dhuhr.minute ?? 58,
          // second: 00,
          second: prayerTimes?.dhuhr.second ?? 00,
        );

        NotificationUtils.prayerNotificationsAsr(
          body: 'صلاة العصر',
          title: 'صلاة العصر',
          hour: prayerTimes?.asr.hour != null ? prayerTimes!.asr.hour : 16,
          minute: prayerTimes?.asr.minute ?? 34,
          second: prayerTimes?.asr.second ?? 00,
        );

        NotificationUtils.prayerNotificationsMaghrib(
          body: 'صلاة المغرب',
          title: 'صلاة المغرب',
          hour: prayerTimes?.maghrib.hour != null
              ? prayerTimes!.maghrib.hour
              : 19,
          minute: prayerTimes?.maghrib.minute ?? 31,
          second: prayerTimes?.maghrib.second ?? 00,
        );

        NotificationUtils.prayerNotificationsIsha(
          body: 'صلاة العشاء',
          title: 'صلاة العشاء',
          hour: prayerTimes?.isha.hour != null ? prayerTimes!.isha.hour : 20,
          minute: prayerTimes?.isha.minute ?? 53,
          second: prayerTimes?.isha.second ?? 00,
        );
      }
    });
  }
}

class NotificationUtils {
  static Future<void> prayerNotificationsFajr({
    required int? hour,
    required int? minute,
    required int? second,
    required String? title,
    required String? body,
  }) async {
    await AwesomeNotifications().createNotification(
      schedule: NotificationCalendar(
        preciseAlarm: true,
        allowWhileIdle: true,
        repeats: true,
        hour: hour,
        // hour: 21,
        minute: minute,
        // minute: 37,
        second: second,
        // second: 00,
      ),
      content: NotificationContent(
        showWhen: false,
        wakeUpScreen: true,
        displayOnBackground: true,
        displayOnForeground: true,
        category: NotificationCategory.Reminder,
        id: 1,
        channelKey: 'adan_channel',
        groupKey: 'adan_channel',
        title: title,
        body: 'حان الان موعد $body',
      ),
    );
  }

  static Future<void> prayerNotificationsDuhr({
    required int? hour,
    required int? minute,
    required int? second,
    required String? title,
    required String? body,
  }) async {
    await AwesomeNotifications().createNotification(
      schedule: NotificationCalendar(
        preciseAlarm: true,
        allowWhileIdle: true,
        repeats: true,
        hour: hour,
        // hour: 21,
        minute: minute,
        // minute: 37,
        second: second,
        // second: 00,
      ),
      content: NotificationContent(
        showWhen: false,
        wakeUpScreen: true,
        displayOnBackground: true,
        displayOnForeground: true,
        category: NotificationCategory.Reminder,
        id: 2,
        channelKey: 'adan_channel',
        groupKey: 'adan_channel',
        title: title,
        body: 'حان الان موعد $body',
      ),
    );
  }

  static Future<void> prayerNotificationsAsr({
    required int? hour,
    required int? minute,
    required int? second,
    required String? title,
    required String? body,
  }) async {
    await AwesomeNotifications().createNotification(
      schedule: NotificationCalendar(
        preciseAlarm: true,
        allowWhileIdle: true,
        repeats: true,
        hour: hour,
        // hour: 21,
        minute: minute,
        // minute: 37,
        second: second,
        // second: 00,
      ),
      content: NotificationContent(
        showWhen: false,
        wakeUpScreen: true,
        displayOnBackground: true,
        displayOnForeground: true,
        category: NotificationCategory.Reminder,
        id: 3,
        channelKey: 'adan_channel',
        groupKey: 'adan_channel',
        title: title,
        body: 'حان الان موعد $body',
      ),
    );
  }

  static Future<void> prayerNotificationsMaghrib({
    required int? hour,
    required int? minute,
    required int? second,
    required String? title,
    required String? body,
  }) async {
    await AwesomeNotifications().createNotification(
      schedule: NotificationCalendar(
        preciseAlarm: true,
        allowWhileIdle: true,
        repeats: true,
        hour: hour,
        // hour: 21,
        minute: minute,
        // minute: 37,
        second: second,
        // second: 00,
      ),
      content: NotificationContent(
        showWhen: false,
        wakeUpScreen: true,
        displayOnBackground: true,
        displayOnForeground: true,
        category: NotificationCategory.Reminder,
        id: 4,
        channelKey: 'adan_channel',
        groupKey: 'adan_channel',
        title: title,
        body: 'حان الان موعد $body',
      ),
    );
  }

  static Future<void> prayerNotificationsIsha({
    required int? hour,
    required int? minute,
    required int? second,
    required String? title,
    required String? body,
  }) async {
    await AwesomeNotifications().createNotification(
      schedule: NotificationCalendar(
        preciseAlarm: true,
        allowWhileIdle: true,
        repeats: true,
        hour: hour,
        // hour: 21,
        minute: minute,
        // minute: 37,
        second: second,
        // second: 00,
      ),
      content: NotificationContent(
        showWhen: false,
        wakeUpScreen: true,
        displayOnBackground: true,
        displayOnForeground: true,
        category: NotificationCategory.Reminder,
        id: 5,
        channelKey: 'adan_channel',
        groupKey: 'adan_channel',
        title: title,
        body: 'حان الان موعد $body',
      ),
    );
  }

  //*********************************// Prophet Muhammed //**********************//
  static Future<void> showAlarmNotificationProphet({
    required int id,
  }) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: id,
        channelKey: 'basic_channel',
        groupKey: 'basic_channel',
        title: 'صّلِ عَلۓِ مُحَمد',
        body: 'اللهم صّلِ وسَلّمْ عَلۓِ نَبِيْنَا مُحَمد ﷺ',
        displayOnBackground: true,
        displayOnForeground: true,
        wakeUpScreen: true,
        category: NotificationCategory.Reminder,
        autoDismissible: true,
        customSound: 'resource://raw/res_notifications',
      ),
      schedule: NotificationCalendar(
        preciseAlarm: true,
        allowWhileIdle: true,
        repeats: true,
        hour: 10,
        // hour: 21,
        minute: 00,
        // minute: 37,
        second: 00,
        // second: 00,
      ),
    );
  }

  static Future<void> showAlarmNotificationProphet1({
    required int id,
  }) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: id,
        channelKey: 'basic_channel',
        groupKey: 'basic_channel',
        title: 'صّلِ عَلۓِ مُحَمد',
        body: 'اللَهُمَّ صلِّ وسَلِم وبَارِك على سيدنا محمد (ﷺ)',
        displayOnBackground: true,
        displayOnForeground: true,
        wakeUpScreen: true,
        category: NotificationCategory.Reminder,
        autoDismissible: true,
        customSound: 'resource://raw/res_notifications',
      ),
      schedule: NotificationCalendar(
        preciseAlarm: true,
        allowWhileIdle: true,
        repeats: true,
        hour: 17,
        // hour: 21,
        minute: 00,
        // minute: 37,
        second: 00,
        // second: 00,
      ),
    );
  }

  static Future<void> showAlarmNotificationCompletePray({
    required int id,
  }) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: id,
        channelKey: 'alert_channel',
        groupKey: 'alert_channel',
        title: 'الصلاة',
        body: 'هل اكملت صلواتك اليوم ؟',
        displayOnBackground: true,
        displayOnForeground: true,
        wakeUpScreen: true,
        category: NotificationCategory.Reminder,
        autoDismissible: true,
      ),
      schedule: NotificationCalendar(
        preciseAlarm: true,
        allowWhileIdle: true,
        repeats: true,
        hour: 22,
        // hour: 21,
        minute: 00,
        // minute: 37,
        second: 00,
        // second: 00,
      ),
    );
  }

  static Future<void> showAlarmNotificationAzkarSabah({
    required int id,
  }) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: id,
        channelKey: 'alert_channel',
        groupKey: 'alert_channel',
        title: 'اذكار الصباح',
        body: 'هل اكملت اذكار الصباح ؟',
        displayOnBackground: true,
        displayOnForeground: true,
        wakeUpScreen: true,
        category: NotificationCategory.Reminder,
        autoDismissible: true,
      ),
      schedule: NotificationCalendar(
        preciseAlarm: true,
        allowWhileIdle: true,
        repeats: true,
        hour: 11,
        // hour: 21,
        minute: 00,
        // minute: 37,
        second: 00,
        // second: 00,
      ),
    );
  }

  static Future<void> showAlarmNotificationAzkarMasaa({
    required int id,
  }) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: id,
        channelKey: 'alert_channel',
        groupKey: 'alert_channel',
        title: 'اذكار المساء',
        body: 'هل اكملت اذكار المساء ؟',
        displayOnBackground: true,
        displayOnForeground: true,
        wakeUpScreen: true,
        category: NotificationCategory.Reminder,
        autoDismissible: true,
      ),
      schedule: NotificationCalendar(
        preciseAlarm: true,
        allowWhileIdle: true,
        repeats: true,
        hour: 18,
        // hour: 21,
        minute: 00,
        // minute: 37,
        second: 00,
        // second: 00,
      ),
    );
  }

  String toTwoDigitString(int value) {
    return value.toString().padLeft(2, '0');
  }
}
