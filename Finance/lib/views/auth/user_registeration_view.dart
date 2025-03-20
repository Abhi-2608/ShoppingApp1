import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:form_validator/form_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lane_dane/main.dart';
import 'package:lane_dane/res/colors.dart';
import 'package:lane_dane/utils/colors.dart';
import 'package:lane_dane/view_models/auth_vm.dart';
import 'package:lane_dane/views/sms/widgets/elevated_btn.dart';

class UserRegistrationView extends GetView<AuthVM> {
  final _formKey = GlobalKey<FormState>();
  UserRegistrationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = Get.mediaQuery.size;
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        width: size.width,
        height: size.height,
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
        child: Form(
          key: _formKey,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'user_meta_info_greeting'.tr,
                  style: GoogleFonts.roboto(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 10.0),
                Text(
                  'user_meta_info_prompt'.tr,
                  style: GoogleFonts.roboto(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 40.0),
                TextFormField(
                  onChanged: (value) => controller.fullName.value = value,
                  style: const TextStyle(fontSize: 17),
                  decoration: const InputDecoration(
                    labelText: 'Full Name',
                    hintText: 'Eg. John Doe',
                    hintStyle: TextStyle(fontSize: 17),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                  ),
                  validator:
                      ValidationBuilder().minLength(1).maxLength(50).build(),
                ),
                const SizedBox(height: 10.0),
                TextFormField(
                  onChanged: (value) => controller.email.value = value,
                  style: const TextStyle(fontSize: 17),
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    hintText: 'Eg. yours@gmail.com',
                    hintStyle: TextStyle(fontSize: 17),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                  ),
                  validator: ValidationBuilder().email().maxLength(50).build(),
                ),
                const SizedBox(height: 10.0),
                TextFormField(
                  onChanged: (value) => controller.pincode.value = value,
                  style: const TextStyle(fontSize: 17),
                  decoration: const InputDecoration(
                    labelText: 'Pincode',
                    hintText: 'Eg. 110003',
                    hintStyle: TextStyle(fontSize: 17),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                  ),
                  validator: ValidationBuilder()
                      .minLength(6, 'Pincode must be 6 digits')
                      .maxLength(6, 'Pincode must be 6 digits')
                      .build(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'business_account'.tr,
                      style: GoogleFonts.roboto(
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Obx(() => Switch(
                          value: controller.businessAccount.value,
                          activeColor: greenColor,
                          onChanged: (bool value) {
                            controller.businessAccount.value = value;
                          },
                        )),
                  ],
                ),
                const SizedBox(height: 10.0),
                RichText(
                  softWrap: true,
                  text: TextSpan(
                    text: 'user_meta_info_sign'.tr,
                    style: const TextStyle(
                      color: AppColors.label,
                    ),
                    children: [
                      TextSpan(
                        text: 'terms_of_use'.tr,
                        // recognizer: TapGestureRecognizer()
                        //   ..onTap = controller.launchTermsOfServices,
                        style: const TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                      TextSpan(
                        text: '&'.tr,
                        style: const TextStyle(
                          color: AppColors.label,
                        ),
                      ),
                      TextSpan(
                        text: 'privacy_policy'.tr,
                        // recognizer: TapGestureRecognizer()
                        //   ..onTap = controller.launchPrivacyPolicy,
                        style: const TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40.0),
                Row(
                  children: [
                    SizedBox(
                      width: size.width - 52,
                      child: CustomButton(
                        buttonName: 'register'.tr,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            controller.registerUser();
                            talker
                                .info('@UserRegistrationView : Form is valid');
                          }
                        },
                      ),
                    ),
                    //),
                  ],
                ),
              ]),
        ),
      ),
    ));
  }
}
