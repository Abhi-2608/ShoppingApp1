import 'dart:async';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:lane_dane/res/colors.dart';
import 'package:lane_dane/utils/colors.dart';
import 'package:lane_dane/view_models/user_transaction_vm.dart';
import 'dart:math' as math;

import 'package:lane_dane/views/Usertrasaction/IndividualUserTxn/User_trasaction_create.dart';
import 'package:lane_dane/views/Usertrasaction/IndividualUserTxn/User_trasaction_detail.dart';

class UsertransactionIndex extends GetView<UserTransactionVM> {
  Color laneArrowColor = const Color(0xFF55AA55);
  Color daneArrowColor = const Color(0xFFDD2222);
  final Color laneBackgroundColor = const Color(0xFF55AA55).withOpacity(0.2);
  final Color daneBackgroundColor = const Color(0xFFDD2222).withOpacity(0.2);

  @override
  Widget build(BuildContext context) {
    Get.put(UserTransactionVM());
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      floatingActionButton: Builder(
        builder: (context) => Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10.0,
          ),
          child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            // Padding(
            //   padding: const EdgeInsets.only(left: 30),
            //   child: FloatingActionButton(
            //     onPressed: () {},
            //     backgroundColor: lightGreenColor,
            //     child: const Icon(
            //       Icons.schedule,
            //       size: 17,
            //     ),
            //   ),
            // ),

            FloatingActionButton(
              heroTag: "AddTransactionClass",
              onPressed: () {
                Get.to(UserTransactionCreate());
              },
              backgroundColor: lightGreenColor,
              child: const Icon(
                Icons.add,
                color: AppColors.bgWhite, // Change the color to white
              ),
            )
          ]),
        ),
      ),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(0, 128, 105, 1),
        title: const Row(
          children: [
            CircleAvatar(
              backgroundColor: AppColors.bgWhite,
              child: Text('D'),
            ),
            SizedBox(width: 2),
            Text('Deepak'),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.dummyTransactions.length,
              itemBuilder: (context, index) {
                bool isReceived =
                    controller.dummyTransactions[index]['type'] == 'received';
                String formattedTimestamp = DateFormat('MMM d')
                    .format(controller.dummyTransactions[index]['timestamp']);
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        formattedTimestamp,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Align(
                        alignment: isReceived
                            ? Alignment.centerLeft
                            : Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () {
                            Get.to(UserTransactionDetail());
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 4.0, horizontal: screenWidth * 0.05),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Obx(
                                  () => Container(
                                    height: isReceived
                                        ? MediaQuery.of(context).size.height *
                                            0.1889
                                        : MediaQuery.of(context).size.height *
                                            0.18,
                                    width: screenWidth * 0.6789,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16.0),
                                      color: AppColors.bgWhite,
                                      border: Border.all(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    padding: const EdgeInsets.only(
                                        top: 8.0, left: 16, right: 16),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      //AMOUNT ROW AND LANE DANE BUTTON
                                      children: [
                                        isReceived
                                            ? Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    controller
                                                            .dummyTransactions[
                                                        index]['amount'],
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        color: Colors.black87,
                                                        fontSize: 45),
                                                  ),
                                                  //const SizedBox(width: 35.0),
                                                  CircleAvatar(
                                                    radius: 21,
                                                    backgroundColor:
                                                        laneBackgroundColor,
                                                    child: Transform.rotate(
                                                      angle: math.pi / -1.25,
                                                      child: Icon(
                                                        Icons.arrow_upward,
                                                        color: laneArrowColor,
                                                        size: 24,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            : Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    controller
                                                            .dummyTransactions[
                                                        index]['amount'],
                                                    style: GoogleFonts.roboto(
                                                      color: Colors.black87,
                                                      fontSize: 45,
                                                    ),
                                                  ),
                                                  //const SizedBox(width: 35.0),
                                                  CircleAvatar(
                                                    radius: 21,
                                                    backgroundColor:
                                                        daneBackgroundColor,
                                                    child: Transform.rotate(
                                                      angle: math.pi / -1.25,
                                                      // : math.pi / -1.25,
                                                      child: Icon(
                                                        Icons.arrow_downward,
                                                        color: daneArrowColor,
                                                        size: 24,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                        // const SizedBox(height: 8.0),
                                        // isReceived
                                        //     ? Container(
                                        //         margin: EdgeInsets.only(bottom: 8),
                                        //         child: Row(
                                        //           mainAxisSize: MainAxisSize.min,
                                        //           children: [
                                        //             const Icon(
                                        //               Icons
                                        //                   .arrow_drop_down_circle_rounded,
                                        //               color: Colors.green,
                                        //             ),
                                        //             Text(
                                        //               'Received',
                                        //               style: const TextStyle(
                                        //                 fontSize: 18,
                                        //                 color: Colors.grey,
                                        //               ),
                                        //             ),
                                        //           ],
                                        //         ),
                                        //       )
                                        //     : Row(
                                        //         children: [
                                        //           const Icon(
                                        //             Icons.arrow_outward_outlined,
                                        //             color: Colors.red,
                                        //           ),
                                        //           Text(
                                        //             'Sent',
                                        //             style: const TextStyle(
                                        //               fontSize: 18,
                                        //               color: Colors.grey,
                                        //             ),
                                        //           ),
                                        //         ],
                                        //       ),
                                        const SizedBox(height: 8.0),
                                        //BUTTONS ROW
                                        if ((controller.dummyTransactions[index]
                                                    ['status'] ==
                                                'Pending') &&
                                            isReceived)
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  controller.declineTransaction(
                                                      index);
                                                },
                                                child: Container(
                                                  width: screenWidth * 0.25,
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: screenWidth *
                                                        0.03, // Adjust horizontal padding based on screen width
                                                    vertical: screenWidth *
                                                        0.02, // Adjust vertical padding based on screen width
                                                  ),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50.0),
                                                    color: controller
                                                                .dummyTransactions[
                                                            index]
                                                        ['declineButtonColor'],
                                                    border: Border.all(
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                  child: const Center(
                                                    child: Text(
                                                      'Decline',
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        color: AppColors.label,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  controller
                                                      .acceptTransaction(index);
                                                },
                                                child: Container(
                                                  width: screenWidth * 0.25,
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: screenWidth *
                                                        0.03, // Adjust horizontal padding based on screen width
                                                    vertical: screenWidth *
                                                        0.02, // Adjust vertical padding based on screen width
                                                  ),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50.0),
                                                    color: controller
                                                                .dummyTransactions[
                                                            index]
                                                        ['acceptButtonColor'],
                                                    // border: Border.all(
                                                    //   color: Colors.grey,
                                                    // ),
                                                  ),
                                                  child: const Center(
                                                    child: Text(
                                                      'Accept',
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        color:
                                                            AppColors.bgWhite,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        if (!isReceived)
                                          const Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Icon(
                                                Icons.alarm_rounded,
                                                color: Colors.grey,
                                              ),
                                              Text(
                                                'Requested',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ],
                                          ),
                                        if (controller.dummyTransactions[index]
                                                ['status'] !=
                                            'Pending')
                                          Row(
                                            children: [
                                              controller.dummyTransactions[
                                                          index]['status'] ==
                                                      'Declined'
                                                  ? const Icon(
                                                      Icons.cancel_rounded,
                                                      color: Colors.red,
                                                    )
                                                  : const Icon(
                                                      Icons
                                                          .check_circle_rounded, // Change this to the icon you want to use for 'Declined'
                                                      color: Colors.green,
                                                    ),
                                              Text(
                                                controller.dummyTransactions[
                                                    index]['status'],
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color:
                                                      controller.dummyTransactions[
                                                                      index]
                                                                  ['status'] ==
                                                              'Declined'
                                                          ? Colors.red
                                                          : Colors.green,
                                                ),
                                              ),
                                            ],
                                          ),
                                        const SizedBox(height: 8.0),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ))
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// void main() {
//   runApp(MaterialApp(
//     home: Usertransaction(),
//   ));
// }