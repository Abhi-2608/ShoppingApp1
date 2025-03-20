import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:lane_dane/dependency_inj.dart' as dep;
import 'package:lane_dane/helpers/android_alarm_manager_helper.dart';
import 'package:lane_dane/helpers/object_box.dart';
import 'package:lane_dane/helpers/sms_helper.dart';
import 'package:lane_dane/helpers/telephony_background_sms_helper.dart';
import 'package:lane_dane/repository/auth_repo/auth_local.dart';
import 'package:lane_dane/res/lang/messages.dart';
import 'package:lane_dane/routes.dart';
import 'package:lane_dane/services/after_login_api_service.dart';
import 'package:lane_dane/services/sms_service.dart';
import 'package:lane_dane/utils/init.dart';
import 'package:lane_dane/utils/permission_manager.dart';
import 'package:lane_dane/views/homeIndex.dart';
import 'package:lane_dane/views/introscreens/language_select_view.dart';
import 'package:talker_flutter/talker_flutter.dart';
late ObjectBox OBJECTBOX;
final talker = TalkerFlutter.init(settings: TalkerSettings());
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationResponse? notificationResponse;

// (Optional) Close at some later point.
  FlutterNativeSplash.preserve(widgetsBinding: WidgetsBinding.instance);
  await Future.delayed(const Duration(seconds: 5));

  await setupObjectBox();
  await setupGetStorage();

// (Optional) Close at some later point.
  Firebase.initializeApp();
  FlutterNativeSplash.remove();
  Map<String, Map<String, String>> languages = await dep.init();

  Firebase.initializeApp();
  initVMs();

  await setupTimeZone();
  await setupFirebase();
  await setupGetStorage();
  await setupObjectBox();
  await setupMobAds();
  await askPermissions();
  // await TransactionService().initializeTransaction();
  // appController = await setupGetx();
  notificationResponse = await setupFlutterLocalNotifications();
  if (PermissionManager().smsReadPermission.value) {
    setupTelephony();
    AndroidAlarmManagerHelper().setupDailySmsAlarm();
    SmsHelper().parseAndStoreTransactionSms();
  }

  // Initialise Notifcation Service Class
  // FirebaseMessaging.instance.onTokenRefresh.listen(appController.refreshToken);
  // Permission.notification.request();
  runApp(
    MyApp(
      languages: languages,
      notificationResponse: notificationResponse,
    ),
  );
}
class MyApp extends StatelessWidget {
  const MyApp(
      {super.key,
      required this.languages,
      required NotificationResponse? notificationResponse});
  final Map<String, Map<String, String>> languages;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top],
    );

    SystemChrome.setSystemUIChangeCallback((bool _) async {
      Timer(const Duration(seconds: 1), () {
        SystemChrome.restoreSystemUIOverlays();
      });
    });

    final isAuth = AuthLocal.getToken();

    if (isAuth.isNotEmpty) {
      ApiService();
      SmsService();
    }

    return GetMaterialApp(
      getPages: AppRoutes.getPages,
      // transition: Transition.rightToLeft,
      translations: Messages(languages: languages),
      locale: const Locale('en', 'US'),
      fallbackLocale: const Locale('en', 'US'),
      title: 'Lane Dane',
      navigatorObservers: [TalkerRouteObserver(talker)],
      debugShowCheckedModeBanner: false,
      home: isAuth.isNotEmpty ? const HomeIndex() : LanguageSetting(),
    );
  }
}

