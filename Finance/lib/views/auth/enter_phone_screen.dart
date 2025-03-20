import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lane_dane/utils/assets.dart';
import 'package:lane_dane/utils/colors.dart';
import 'package:lane_dane/view_models/auth_vm.dart';
import 'package:lane_dane/views/auth/enter_otp_screen.dart';
import 'package:lane_dane/views/sms/widgets/elevated_btn.dart';

class EnterPhoneNumber extends GetView<AuthVM> {
  const EnterPhoneNumber({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: size.width,
          height: size.height,
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40.0),
              Flexible(
                  flex: 10,
                  child: Center(
                      child: Image.asset(Assets.imagesOtpOnBoarding,
                          height: 360, width: 301, fit: BoxFit.fitHeight))),
              const SizedBox(height: 28.0),
              Flexible(
                flex: 2,
                child: Text(
                  'otp_verification'.tr,
                  style: GoogleFonts.roboto(
                      fontSize: 24.0, fontWeight: FontWeight.w900),
                ),
              ),
              // TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold) ,)),
              const SizedBox(height: 10.0),
              Flexible(
                flex: 1,
                child: Text(
                  'enter_phone_details_1'.tr,
                  style: GoogleFonts.roboto(
                      fontSize: 12, fontWeight: FontWeight.w400),
                ),
              ),
              Flexible(
                flex: 1,
                child: Text(
                  'enter_phone_details_2'.tr,
                  style: GoogleFonts.roboto(
                      fontSize: 12, fontWeight: FontWeight.w400),
                ),
              ),
              const SizedBox(height: 24.0),
              Flexible(
                flex: 1,
                child: Text(
                  'phone_number'.tr,
                  // style: TextStyle(color: Color(0xff008069) ),)
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: greenColor,
                  ),
                ),
              ),
              Flexible(
                flex: 4,
                child: TextFormField(
                  onChanged: (value) {
                    controller.phoneNumber = value.obs;
                    if (value.length == 10) {
                      controller.submitPhoneNumber();
                    }
                  },

                  //controller: controller._phoneNumberController,
                  //focusNode: controller.phoneNode,
                  autofocus: true,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    /**
                     * 91 or +91 is never sent to the server. The app will
                     * always use the base phone number without country code.
                     * The prefix widget is only to prevent users from being
                     * confused if they should add the country code or not.
                     */
                    prefix: Text(
                      '+91 ',
                      style: GoogleFonts.roboto(),
                    ),
                    focusedErrorBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                          // color: //controller.error.isEmpty
                          //     ? const Color(0xFF008069)
                          //     : Colors.red,
                          ),
                    ),
                    errorBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                          // color: controller.error.isEmpty
                          //     ? const Color(0xFF008069)
                          //     : Colors.red,
                          ),
                    ),
                    //errorText: controller.error,
                  ),
                ),
              ),
              const SizedBox(height: 36.0),
              Flexible(
                flex: 2,
                child: Obx(
                  () => controller.autoRequest.value
                      ? const Center(child: CircularProgressIndicator())
                      : CustomButton(
                          onPressed: () => controller.submitOtp(),
                          buttonName: 'otp'.tr,
                        ),
                ),
              ),
              const SizedBox(height: 40.0),
            ],
          ),
        ),
      ),
    );
  }
}
