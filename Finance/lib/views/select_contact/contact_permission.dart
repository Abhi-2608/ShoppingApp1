import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lane_dane/utils/assets.dart';
import 'package:lane_dane/utils/colors.dart';
import 'package:lane_dane/view_models/transaction_vm.dart';
import 'package:lane_dane/views/select_contact/select_contact.dart';
import 'package:lane_dane/views/sms/widgets/elevated_btn.dart';

class ContactPermissionView extends StatelessWidget {
  final void Function() onPressed = () => Get.off(const ContactLoadingView());
  ContactPermissionView({
    Key? key,
  }) : super(key: key);

  final controller = Get.find<TransactionVM>();
  void onInit() {
    controller.addTransactions();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    const double usableAreaVPadding = 0;
    const double usableAreaHPadding = 40;

    const double primaryTextFontSize = 20;
    const double secondaryTextFontSize = 12;

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: const Color(0xFF128C7E),
        title: Text(
          'select_contact'.tr,
          style: GoogleFonts.roboto(color: Colors.white),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset(Assets.imagesContactBookIconLightGreen),
          Column(
            children: [
              Column(
                children: [
                  Text(
                    'contact_permission_prompt_1'.tr,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                      fontSize: primaryTextFontSize,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Column(
                children: [
                  Text(
                    'contact_permission_safety_1'.tr,
                    style: GoogleFonts.roboto(fontSize: secondaryTextFontSize),
                  ),
                  Text(
                    'contact_permission_safety_2'.tr,
                    style: GoogleFonts.roboto(fontSize: secondaryTextFontSize),
                  ),
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: CustomButton(
              onPressed: onPressed,
              buttonName: 'okay'.tr,
            ),
          ),
        ],
      ),
    );
  }
}

class ContactLoadingView extends StatefulWidget {
  const ContactLoadingView({Key? key}) : super(key: key);

  @override
  State<ContactLoadingView> createState() => _ContactLoadingViewState();
}

class _ContactLoadingViewState extends State<ContactLoadingView> {
  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(
      const Duration(milliseconds: 500),
      () {
        Get.off(const SelectContact());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    const double usableAreaVPadding = 0;
    const double usableAreaHPadding = 40;

    const double primaryTextFontSize = 20;
    const double secondaryTextFontSize = 12;

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: const Color(0xFF128C7E),
        title: Text(
          'select_contact'.tr,
          style: GoogleFonts.roboto(color: Colors.white),
        ),
      ),
      body: Container(
        width: size.width,
        height: 600,
        // color: Colors.red,
        padding: const EdgeInsets.only(
          top: usableAreaVPadding,
          left: usableAreaHPadding,
          right: usableAreaHPadding,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(Assets.imagesContactBookIconLightGreen),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text(
                      'contact_loading_text_1'.tr,
                      style: GoogleFonts.roboto(
                        fontSize: primaryTextFontSize,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'We will not upload your contact or account data',
                      style:
                          GoogleFonts.roboto(fontSize: secondaryTextFontSize),
                    ),
                    Text(
                      'or share with anyone',
                      style:
                          GoogleFonts.roboto(fontSize: secondaryTextFontSize),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 50,
              child: Center(
                child: CircularProgressIndicator(
                  color: greenColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
