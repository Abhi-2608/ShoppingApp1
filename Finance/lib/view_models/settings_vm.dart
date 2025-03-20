import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:lane_dane/utils/constants.dart';

class SettingVM extends GetxController {
  Future<void> shareApp() async {
    await Share.share(
      'Hey, check out this app I use for tracking all my financial dealings. ${Constants.kAppLink}',
      subject: 'Lane Dane Invitation',
    );
  }

  Future<void> rateUs() async {
//navigate to play store lane dane app rate us section
  }

  Future<void> privacyPolicy() async {
//navigate to privacy policy
  }
}
