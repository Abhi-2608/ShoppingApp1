import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lane_dane/helpers/language_model.dart';
import 'package:lane_dane/res/app_constants.dart';
import 'package:lane_dane/view_models/language_vm.dart';

Future<Map<String, Map<String, String>>> init() async {
  //GetStorage shared = GetStorage();

  //don't understand
  //Get.lazyPut(() => shared);
  Get.lazyPut(() => LanguageSettingVM());

  //
  Map<String, Map<String, String>> languages = {};

  for (LanguageModel languageModel in AppConstants.languages) {
    String jsonStringValues = await rootBundle
        .loadString('assets/locales/${languageModel.languageCode}.json');
    Map<String, dynamic> mappedJson = jsonDecode(jsonStringValues);

    Map<String, String> json = {};
    mappedJson.forEach((key, value) {
      json[key] = value.toString();
    });

    languages['${languageModel.languageCode}_${languageModel.countryCode}'] =
        json;
  }
  return languages;
}
