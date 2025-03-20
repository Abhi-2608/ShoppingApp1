import 'package:lane_dane/helpers/language_model.dart';

class AppConstants {

  static List<LanguageModel> languages = [
    LanguageModel(languageName: 'English', countryCode: 'US', languageCode: 'en'),
    LanguageModel(languageName: 'Hindi', countryCode: 'IN', languageCode: 'hi'),
    LanguageModel(languageName: 'Marathi', countryCode: 'IN', languageCode: 'mr'),
    LanguageModel(languageName: 'Tamil', countryCode: 'IN', languageCode: 'ta'),
  ];
}