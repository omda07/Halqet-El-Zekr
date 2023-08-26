import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

class NotificationController {
  static ReceivedAction? initialAction;

  ///  *********************************************
  ///     INITIALIZATIONS
  ///  *********************************************
  ///
  static Future<void> initializeLocalNotifications() async {
    await AwesomeNotifications().initialize(
        'resource://drawable/res_app_icon',

        //'resource://drawable/res_app_icon',//
        [
          NotificationChannel(
              channelKey: 'basic_channel',
              channelName: 'Reminders',
              channelGroupKey: 'basic_channel',
              groupKey: 'basic_channel',
              enableVibration: true,
              channelDescription: 'Notification',
              playSound: true,
              onlyAlertOnce: true,
              soundSource: 'resource://raw/res_notifications',
              groupAlertBehavior: GroupAlertBehavior.Children,
              importance: NotificationImportance.High,
              defaultPrivacy: NotificationPrivacy.Public,
              defaultColor: Colors.deepPurple,
              ledColor: Colors.deepPurple),
          NotificationChannel(
              channelKey: 'alert_channel',
              channelName: 'Alerts',
              channelGroupKey: 'alert_channel',
              groupKey: 'alert_channel',
              enableVibration: true,
              channelDescription: 'Alerts Notification',
              playSound: true,
              onlyAlertOnce: true,
              soundSource: 'resource://raw/res_alert',
              groupAlertBehavior: GroupAlertBehavior.Children,
              importance: NotificationImportance.High,
              defaultPrivacy: NotificationPrivacy.Public,
              defaultColor: Colors.deepPurple,
              ledColor: Colors.deepPurple),
          NotificationChannel(
              channelKey: 'adan_channel',
              channelGroupKey: 'adan_channel',
              groupKey: 'adan_channel',
              channelName: 'Azan',
              channelDescription: 'Notification for Azan',
              playSound: true,
              onlyAlertOnce: true,
              soundSource: 'resource://raw/res_azan',
              groupAlertBehavior: GroupAlertBehavior.Children,
              importance: NotificationImportance.High,
              defaultPrivacy: NotificationPrivacy.Public,
              defaultColor: Colors.deepPurple,
              ledColor: Colors.deepPurple),
        ],
        channelGroups: [
          NotificationChannelGroup(
              channelGroupKey: 'basic_channel', channelGroupName: 'Reminders'),
          NotificationChannelGroup(
              channelGroupKey: 'alert_channel', channelGroupName: 'Alerts'),
          NotificationChannelGroup(
              channelGroupKey: 'adan_channel', channelGroupName: 'Azan'),
        ],
        debug: false);

    // Get initial notification action is optional
    // initialAction = await AwesomeNotifications()
    //     .in(removeFromActionEvents: false);
  }

  ///  *********************************************
  ///     NOTIFICATION EVENTS
  ///  *********************************************
  ///
  @pragma('vm:entry-point')
  static Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction) async {
    //
    // if(
    // receivedAction.actionType == ActionType.SilentAction ||
    //     receivedAction.actionType == ActionType.SilentBackgroundAction
    // ){
    //   // For background actions, you must hold the execution until the end
    //   print('Message sent via notification input: "${receivedAction.buttonKeyInput}"');
    //   await executeLongTaskInBackground();
    // }
    // else {
    //   MyApp.navigatorKey.currentState?.pushNamedAndRemoveUntil(
    //       '/notification-page',
    //           (route) =>
    //       (route.settings.name != '/notification-page') || route.isFirst,
    //       arguments: receivedAction);
    // }
  }

  static Future<void> resetBadgeCounter() async {
    await AwesomeNotifications().resetGlobalBadge();
  }

  static Future<void> cancelNotifications() async {
    await AwesomeNotifications().cancelAll();
  }
}
