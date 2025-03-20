import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lane_dane/utils/assets.dart';
import 'package:lane_dane/view_models/auth_vm.dart';
import 'package:lane_dane/views/sms/widgets/elevated_btn.dart';
import 'package:pinput/pinput.dart';

class EnterOtpScreen extends StatefulWidget {
  const EnterOtpScreen({
    super.key,
  });

  @override
  State<EnterOtpScreen> createState() => _EnterOtpScreenState();
}

class _EnterOtpScreenState extends State<EnterOtpScreen> {
  final controller = Get.find<AuthVM>();
  @override
  Widget build(BuildContext context) {
    final Size size = Get.mediaQuery.size;
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
              const SizedBox(height: 40),
              IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: context.theme.colorScheme.background,
                ),
              ),
              const SizedBox(height: 50),
              Flexible(
                flex: 6,
                child: Image.asset(
                  Assets.imagesEnterOtp,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Flexible(
                flex: 2,
                child: Text(
                  'otp_verification'.tr,
                  style: GoogleFonts.roboto(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Flexible(
                flex: 2,
                child: Obx(() => Row(
                      children: [
                        Text(
                          'enter_otp_prompt'.tr,
                          style: GoogleFonts.roboto(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          "+91 ${controller.phoneNumber.value} ",
                          style: GoogleFonts.roboto(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    )),
              ),
              const SizedBox(
                height: 10.0,
              ),
              const SizedBox(
                height: 20.0,
              ),
              Flexible(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Obx(() => Pinput(
                          controller: controller.otpController,
                          onChanged: (value) {
                            controller.otp.value = value;
                          },
                          onCompleted: (_) => controller.submitOtp(),
                          isCursorAnimationEnabled: true,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          autofocus: true,
                          forceErrorState: controller.error.value.isNotEmpty,
                          // errorText: controller.error.value,
                          errorTextStyle: GoogleFonts.roboto(
                            fontSize: 10,
                            color: Colors.red.withOpacity(0.8),
                          ),
                          defaultPinTheme: PinTheme(
                            height: 50,
                            width: 56,
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(color: Colors.black),
                              ),
                            ),
                            textStyle: GoogleFonts.roboto(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )),
                  ],
                ),
              ),
              Flexible(
                flex: 2,
                child: Obx(() => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          controller.resendTimerSeconds.value > 0
                              ? 'Resend OTP in ${controller.resendTimerSeconds.toString()} seconds'
                              : 'You can now resend OTP',
                          style: TextStyle(
                            color: controller.resendTimerSeconds > 0
                                ? Colors.grey
                                : Colors.green,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () => controller.requestOtpAgain(),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              controller.resendTimerSeconds.value > 0
                                  ? Colors.grey
                                  : const Color(0xff008069),
                            ),
                          ),
                          child: const Text('Resend OTP',
                              style: TextStyle(color: Colors.white)),
                        ),
                      ],
                    )),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Flexible(
                flex: 2,
                child: Obx(() => controller.autoRequest.value
                    ? const Center(child: CircularProgressIndicator())
                    : CustomButton(
                        onPressed: () {
                          controller.submitOtp();
                        },
                        buttonName: 'submit'.tr,
                      )),
              ),
              const SizedBox(height: 220),
            ],
          ),
        ),
      ),
    );
  }
}
