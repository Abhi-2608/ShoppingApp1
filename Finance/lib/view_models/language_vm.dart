import 'dart:ui';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lane_dane/helpers/language_model.dart';
import 'package:lane_dane/res/app_constants.dart';

// class LanguageSettingVM extends GetxController {
//   final RxString languageCode = 'en'.obs;
//update local on get_storage
// store.write(userLocale, locale.toString());
//   void changeLanguage(String code) {
//     languageCode.value = code;
//     Get.updateLocale(Locale(code));
//   }
// }

//on language page make the device locale default selected
//we want to rembeber local with help of getStorage
//this local will also be send in register/login api
class LanguageSettingVM extends GetxController implements GetxService {
  final shared = GetStorage();
  LanguageSettingVM() {
    loadCurrentLanguage();
  }

  Locale _locale = Locale(AppConstants.languages.first.languageCode,
      AppConstants.languages.first.countryCode);

  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;
  List<LanguageModel> _languages = [];
  Locale get locale => _locale;
  List<LanguageModel> get languages => _languages;

  // void loadCurrentLanguage() {
  //   _locale = Locale(shared.read(AppConstants.LANGUAGE_CODE) ??
  //       AppConstants.languages[0].languageCode,
  //       shared.read(AppConstants.COUNTRY_CODE) ??
  //           AppConstants.languages[0].countryCode);

  //   for (int index = 0; index < AppConstants.languages.length; index++) {
  //     if (AppConstants.languages[index].languageCode == _locale.languageCode) {
  //       _selectedIndex = index;
  //       break;
  //     }
  //   }
  //   _languages = [];
  //   _languages.addAll(AppConstants.languages);
  //   update();
  // }

  void loadCurrentLanguage() {
    final savedLanguageCode =
        shared.read('locale') ?? AppConstants.languages.first.languageCode;
    final savedCountryCode =
        shared.read('country') ?? AppConstants.languages.first.countryCode;

    // _locale = Locale(savedLanguageCode, savedCountryCode);

    _selectedIndex = AppConstants.languages
        .indexWhere((lang) => lang.languageCode == _locale.languageCode);
    _languages = List.from(AppConstants.languages);

    update();
  }

  void setLanguage(Locale locale) {
    Get.updateLocale(locale);
    _locale = locale;
    saveLanguage(_locale);
    print("$_locale");

    update();
  }

  void setSelectedIndex(int index) {
    _selectedIndex = index;
    update();
  }

  void saveLanguage(Locale locale) async {
    shared.write('locale', locale.languageCode);
    shared.write('country', locale.countryCode);
  }
}
