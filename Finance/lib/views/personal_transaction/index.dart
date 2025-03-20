import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lane_dane/main.dart';
import 'package:lane_dane/utils/assets.dart';
import 'package:lane_dane/utils/colors.dart';
import 'package:lane_dane/view_models/personal_tx_vm.dart';

class PersonalTnxIndex extends GetView<PersonalTransactionVM> {
  const PersonalTnxIndex({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(PersonalTransactionVM());
    controller.getSmsTransactions();

    return Scaffold(body: Builder(
      builder: (BuildContext context) {
        return Obx(
          () => controller.personalTnxRecordList.isNotEmpty
              ? const PersonalTnxLoader()
              : const PersonalTnxLoading(),
        );
      },
    ));
  }
}

class PersonalTnxLoading extends StatelessWidget {
  const PersonalTnxLoading({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    const double usableAreaVPadding = 0;
    const double usableAreaHPadding = 40;

    const double primaryTextFontSize = 20;
    const double secondaryTextFontSize = 12;
    return Container(
      width: size.width,
      height: 600,
      padding: const EdgeInsets.only(
        top: usableAreaVPadding,
        left: usableAreaHPadding,
        right: usableAreaHPadding,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset(Assets.imageschatMesssageIconLightGreen),
          Column(
            children: [
              Column(
                children: [
                  Text(
                    'sms_loading_text_1'.tr,
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
                    'sms_permission_safety_1'.tr,
                    style: GoogleFonts.roboto(fontSize: secondaryTextFontSize),
                  ),
                  Text(
                    'sms_permission_safety_2'.tr,
                    style: GoogleFonts.roboto(fontSize: secondaryTextFontSize),
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
            )),
          ),
        ],
      ),
    );
  }
}

class PersonalTnxLoader extends GetView<PersonalTransactionVM> {
  const PersonalTnxLoader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    //  Get.put(PersonalTransactionVM());
    const Color laneArrowColor = Color(0xFF55AA55);
    const Color daneArrowColor = Color(0xFFDD2222);
    final Color laneBackgroundColor = laneArrowColor.withOpacity(0.2);
    final Color daneBackgroundColor = daneArrowColor.withOpacity(0.2);
    return Obx(() => ListView.builder(
          itemCount: controller.personalTnxRecordList.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Obx(
                  () => controller.haveTitle(index) == true
                      ? Container(
                          height: 32,
                          color: const Color.fromRGBO(223, 228, 237, 1),
                          width: double.infinity,
                          child: Center(
                              child: Text(DateFormat("d MMM").format(controller
                                  .personalTnxRecordList[index].createdAt))),
                        )
                      : Container(
                          height: 1,
                        ),
                ),
                ListTile(
                  onTap: () {
                    controller.indx.value = index;
                    talker.debug(
                        "@PersonalTnxLoader : _build -> Tapped a individual List, TOOD: Navigate to personalTnxDetail Screen $index");
                    // Navigator.push(context, MaterialPageRoute(
                    //   builder: (context) {
                    //     return PersonalTnxDetailIndex(
                    //       personalTnx: controller.personalTnxRecordList[index],
                    //     );
                    //   },
                    // ));
                  },
                  style: ListTileStyle.list,
                  leading: CircleAvatar(
                    radius: 21,
                    backgroundColor: controller
                                .personalTnxRecordList[index].transactionType ==
                            'dane'
                        ? daneBackgroundColor
                        : laneBackgroundColor,
                    child: Transform.rotate(
                      angle: controller.personalTnxRecordList[index]
                                  .transactionType ==
                              'dane'
                          ? math.pi / 4
                          : math.pi / -1.25,
                      child: Icon(
                        Icons.arrow_upward,
                        color: controller.personalTnxRecordList[index]
                                    .transactionType ==
                                'dane'
                            ? daneArrowColor
                            : laneArrowColor,
                        size: 24,
                      ),
                    ),
                  ),
                  title: Text(
                    '${controller.personalTnxRecordList[index].amount}',
                    style: TextStyle(
                        color: controller.personalTnxRecordList[index]
                                    .transactionType ==
                                'dane'
                            ? Colors.red
                            : Colors.green,
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text(
                    '${controller.personalTnxRecordList[index].accNumber}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                  trailing: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        DateFormat("d MMM").format(
                            controller.personalTnxRecordList[index].createdAt),
                        style: GoogleFonts.roboto(
                          color: const Color(0xFF8F8F8F),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        DateFormat("jm").format(
                            controller.personalTnxRecordList[index].createdAt),
                        style: GoogleFonts.roboto(
                          color: const Color(0xFF8F8F8F),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ));
  }
}
