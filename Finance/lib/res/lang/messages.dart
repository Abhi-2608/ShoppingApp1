import 'package:get/get.dart';

class Messages extends Translations {
  final Map<String, Map<String, String>> languages;
  Messages({required this.languages});

  @override
  Map<String, Map<String, String>> get keys {
    return languages;
  }
}



// class Messages extends Translations {
//   @override
//   Map<String, Map<String, String>> get keys {
//     return _loadJsonMapFiles();
//   }

//   Map<String, Map<String, String>> _loadJsonMapFiles() {
//     Map<String, Map<String, String>> languages = {};
//     AppConstants.languages.forEach((languageModel) {
//       _loadLanguageJson(languageModel, languages);
//     });
//     return languages;
//   }

//   Future<void> _loadLanguageJson(
//       LanguageModel languageModel, Map<String, Map<String, String>> languages) async {
//     String jsonStringValues =
//         await rootBundle.loadString('assets/locales/${languageModel.languageCode}.json');
//     Map<String, dynamic> mappedJson = jsonDecode(jsonStringValues);

//     Map<String, String> json = {};
//     mappedJson.forEach((key, value) {
//       json[key] = value.toString();
//     });

//     languages['${languageModel.languageCode}_${languageModel.countryCode}'] = json;
//   }
// }
