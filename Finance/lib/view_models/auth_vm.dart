import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lane_dane/main.dart';
import 'package:lane_dane/repository/auth_repo/auth_api.dart';
import 'package:lane_dane/repository/auth_repo/auth_local.dart';
import 'package:lane_dane/routes.dart';
import 'package:lane_dane/services/after_login_api_service.dart';

class AuthVM extends GetxController {
  GetStorage box = GetStorage();
  //pinput accept txt editing controller only so we have to use it or any other logic
  final otpController = TextEditingController();
  RxString fullName = ''.obs;
  RxString email = ''.obs;
  final error = ''.obs;
  RxString pincode = ''.obs;
  RxBool businessAccount = false.obs;
  RxBool autoRequest = false.obs;
  RxString phoneNumber = ''.obs;
  final AuthApi _authApi = AuthApi();
  final resendTimerSeconds = 30.obs;
  var otp = ''.obs;
  late Timer timer;
  bool newUser = false;

  Future<void> submitPhoneNumber() async {
    autoRequest.value = true;
    final res = await _authApi.getOtp(phoneNumber.value);
    newUser = res['new_user'];
    talker.info("@AuthVM : submitPhoneNumber : am i a news user? $newUser");
    //Get.to(() => EnterOtpScreen());
    Get.toNamed(AppRoutes.enterOtp,
        arguments: {'res': res, 'phone': phoneNumber.value});
    autoRequest.value = false;
    startResendTimer();
  }

  Future<void> startResendTimer() async {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (resendTimerSeconds.value > 0) {
        {
          resendTimerSeconds.value--;
        }
      } else {
        timer.cancel();
      }
    });
  }

  Future<bool> requestOtpAgain() async {
    if (resendTimerSeconds.value > 0) {
      return false;
    }
    await _authApi.getOtp(phoneNumber.value);
    resendTimerSeconds.value = 60;
    startResendTimer();
    return true;
  }

  Future<void> submitOtp() async {
    final otp = otpController.text;
    if (otp.isNotEmpty && otp.length == 4 && newUser) {
      //rediect to registeration
      Get.offAllNamed(AppRoutes.registration);
      return;
    }

    await login();
    return;
  }

  void logout() {
    try {
      Get.deleteAll();
      Get.offAllNamed(AppRoutes.introPage);
      // Get.offUntil(
      //   MaterialPageRoute(builder: (_) => EnterPhoneScreen()),
      //   (route) => true,
      // );
    } catch (err) {
      talker.error("@AuthVM : logout() : Error while logging out -> $err");
      rethrow;
    }
  }

  Future<void> login() async {
    try {
      String fcmToken = 'fcmtest';

      final Map<String, dynamic> response = await _authApi.login(
        //context: context,
        phone: int.parse(phoneNumber.value),
        otp: otp.value,
        fcmToken: fcmToken,
      );
      AuthLocal.setUser(response['user']);
      AuthLocal.setToken(response['token']);

      box.write('token', response['token']);
      box.write('auth_user', response['user']);
      talker.debug(
          "@AuthVM : login() : Reponse after user login API called -> ${response['token']}");
      talker.debug(
          "@AuthVM : login() : Reponse after user login API called -> ${response['user']}");

      // FirebaseCrashlytics.instance
      //     .setUserIdentifier(response['user']['full_name']);
      //TODO: firebase setup
      ApiService().addApiCallBack();
      Get.toNamed(AppRoutes.homeIndex);
      talker.info("@AuthVM : login() : ApiService Called");
    } catch (err) {
      talker.error("@AuthVM : login() : Error while logging in -> $err");
      rethrow;
    }
  }

  Future<void> registerUser() async {
    String fullName = this.fullName.value;
    bool businessAccount = this.businessAccount.value;
    String email = this.email.value;
    String pincode = this.pincode.value;

    String fcmToken = 'fcmtest';
    // await FirebaseMessaging.instance.getToken();
    //will setup fcm later
    try {
      final Map<String, dynamic> response = await _authApi.register(
        phone: int.parse(phoneNumber.value),
        fullName: fullName,
        otp: otp.value,
        businessAccount: businessAccount,
        fcmToken: fcmToken,
        email: email,
        pincode: pincode,
      );
      AuthLocal.setUser(response['user']);
      AuthLocal.setToken(response['token']);

      talker.debug(
          "@AuthVM : registerUser() : Reponse after user register API called -> ${response['user']}");
      debugPrint(response.toString());
      ApiService().addApiCallBack();
      talker.info("@AuthVM : registerUser() : ApiService Called");
      Get.toNamed(AppRoutes.homeIndex);
    } catch (err) {
      talker.error(
          "@AuthVM : registerUser() : Error while registering user -> $err");
      rethrow;
    }
  }
}
