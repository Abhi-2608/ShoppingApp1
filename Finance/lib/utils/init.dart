import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lane_dane/controllers/app_controllers/app_controller.dart';
import 'package:lane_dane/data/local/objectbox.g.dart';
import 'package:lane_dane/firebase_options.dart';
import 'package:lane_dane/helpers/object_box.dart';
import 'package:lane_dane/main.dart';
import 'package:lane_dane/utils/firebase_message_handler_utils.dart';
import 'package:lane_dane/utils/permission_manager.dart';
import 'package:lane_dane/view_models/transaction_vm.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/data/latest.dart' as tzl;
import 'package:timezone/timezone.dart' as tz;

tz.Location setupTimeZone() {
  tzl.initializeTimeZones();
  tz.Location india = tz.getLocation('Asia/Kolkata');
  tz.setLocalLocation(india);
  return india;
}

void initVMs() {
  Get.put(AppController(), permanent: true);
  Get.put(TransactionVM());
}

Future<void> askPermissions() async {
  PermissionManager permissionManager = PermissionManager();
  await permissionManager.requestPermission(
      Permission.sms, permissionManager.smsReadPermission);
  await permissionManager.requestPermission(
      Permission.contacts, permissionManager.contactReadPermission);
  await permissionManager.requestPermission(
      Permission.notification, permissionManager.sendNotificationPermission);

}

Future<bool> setupFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseMessaging.instance.setAutoInitEnabled(true);

  FirebaseMessaging.onMessage.listen(firebaseMessageHandler);
  FirebaseMessaging.onBackgroundMessage(firebaseBackgroundMessageHandler);

  if (kDebugMode) {
    // Force disable Crashlytics collection while doing every day development.
    // Temporarily toggle this to true if you want to test crash reporting in your app.
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
    await FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(false);
    talker.info(
        "@init : setupFirebase() : Crashlytics and Analytics disabled in Debug mode");
  } else {
    // Handle Crashlytics enabled status when not in Debug,
    // e.g. allow your users to opt-in to crash reporting.

    // Pass all uncaught errors from the framework to Crashlytics.
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
    await FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(true);
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  }
  return true;
}

Future<bool> setupObjectBox() async {
  OBJECTBOX = await ObjectBox.create();
  if (Admin.isAvailable()) {
    // Keep a reference until no longer needed or manually closed.
    Admin admin = Admin(OBJECTBOX.store);
  }
  return true;
}

Future<bool> setupGetStorage() async {
  await GetStorage.init(); // Initialize GetStorage
  return true;
}

Future<AppController> setupGetx() async {
  AppController appController = Get.put(AppController(), permanent: true);

  /**
     * Define methods that will be called when user logs in. This is a neat way
     * to centralize all post login updates the app needs to do in a single place.
     * This is specifically because there are 3 ways the user can login; login, 
     * register, and autologin.
     */
  appController.postLoginCallbacks
      .add(appController.retrieveTransactionsFromServer);
  // appController.postLoginCallbacks
  //     .add(appController.fetchRemoteGroupTransactionList);
  // appController.postLoginCallbacks.add(runMigrations);

  // await appController.autoLogin();

  return appController;
}

Future<NotificationResponse?> setupFlutterLocalNotifications() async {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  NotificationAppLaunchDetails? launchDetails =
      await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

  if (launchDetails == null) {
    return null;
  }
  if (!launchDetails.didNotificationLaunchApp) {
    return null;
  }

  return launchDetails.notificationResponse;
}

Future<void> setupMobAds() async {
  // await MobileAds.instance.initialize();
  // if (kDebugMode) {
  //   List<String> testDeviceIds = ["BF29F43A88910A1B3FD17468ED3654FB"];
  //   RequestConfiguration configuration = RequestConfiguration(
  //     testDeviceIds: testDeviceIds,
  //   );
  //   await MobileAds.instance.updateRequestConfiguration(configuration);
  // }
}
