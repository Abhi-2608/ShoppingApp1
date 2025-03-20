import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lane_dane/res/colors.dart';
import 'package:lane_dane/utils/colors.dart';
import 'package:lane_dane/view_models/language_vm.dart';
import 'package:lane_dane/views/introscreens/intro_main.dart';

class LanguageSetting extends GetView<LanguageSettingVM> {
  static const String routeName = 'language-setting';
  final LanguageSettingVM languageViewModel = Get.put(LanguageSettingVM());

  LanguageSetting({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => IntroMain());
        },
        backgroundColor: greenColor,
        child: Icon(
          Icons.arrow_forward,
          color: AppColors.bgWhite,
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/logo/lane_dane_logo_green.png",
                  fit: BoxFit.contain,
                  width: 200,
                  height: 200,
                ),
                Text(
                  'lane_dane'.tr,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.roboto(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'language_setting_prompt_1'.tr,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.roboto(
                    fontSize: 30,
                  ),
                ),
                SizedBox(height: constraints.maxHeight * 0.1),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        buildLanguageRadio(
                            'english', "(device language)", 'en'),
                        buildLanguageRadio('hindi', "Hindi", 'hi'),
                        buildLanguageRadio('marathi', "Marathi", 'mr'),
                        buildLanguageRadio('tamil', "Tamil", 'ta'),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget buildLanguageRadio(
    String title,
    String subtitle,
    String languageCode,
  ) {
    return RadioListTile(
      title: Text(
        title.tr,
        textAlign: TextAlign.left,
        style: GoogleFonts.roboto(
          fontSize: 18,
          fontWeight: FontWeight.normal,
        ),
      ),
      subtitle: Text(
        subtitle.tr,
        textAlign: TextAlign.left,
        style: GoogleFonts.roboto(
          fontSize: 15,
          fontWeight: FontWeight.normal,
        ),
      ),
      value: languageCode,
      activeColor: laneColor,
      fillColor: MaterialStateProperty.all(laneColor),
      splashRadius: 25,
      groupValue: controller.locale.languageCode,
      onChanged: (String? value) {
        if (value != null) {
          controller.setLanguage(Locale(value));
        }
      },
    );
  }
}
