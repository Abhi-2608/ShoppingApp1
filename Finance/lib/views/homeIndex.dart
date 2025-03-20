import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lane_dane/res/colors.dart';
import 'package:lane_dane/views/calculator/calculatorIndex.dart';

import 'package:lane_dane/views/personal_transaction/index.dart';
import 'package:lane_dane/views/profile/profileIndex.dart';
import 'package:lane_dane/views/reminder_screen/index.dart';
import 'package:lane_dane/views/select_contact/select_contact.dart';
import 'package:lane_dane/views/settings/settingIndex.dart';
import 'package:lane_dane/views/user_transaction/userTransactionIndex.dart';

bool flag = true;

class HomeIndex extends StatefulWidget {
  static const String routeName = 'home';
  const HomeIndex({
    Key? key,
  }) : super(key: key);

  // final List<Contact> fetchedContacts;

  @override
  _HomeIndexState createState() => _HomeIndexState();
}

class _HomeIndexState extends State<HomeIndex>
    with SingleTickerProviderStateMixin {
  bool isSearch = false;
  int pageIndex = 0;

  final pages = [
    // const SmsList(),
    const PersonalTnxIndex(),
    const UserTransactionIndex(),
    const ProfileIndex(),
    const ReminderList(),
    const CalculatorIndex(),
  ];

  double slider = 52;

  @override
  Widget build(BuildContext context) {
    TextStyle defaultStyle = GoogleFonts.roboto();
    Size size = MediaQuery.of(context).size;

    AppBar buildAppBar() {
      switch (pageIndex) {
        case 0:
          return isSearch
              ? AppBar(
                  elevation: 0.0,
                  title: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: SearchBar(
                      leading: const Icon(Icons.search),
                      trailing: [
                        IconButton(
                          onPressed: () => setState(() {
                            isSearch = false;
                          }),
                          icon: const Icon(Icons.cancel),
                        ),
                      ],
                      hintText: 'Search here',
                    ),
                  ),
                  automaticallyImplyLeading: false,
                  backgroundColor: const Color(0xFF128C7E),
                )
              : AppBar(
                  elevation: 0.0,
                  automaticallyImplyLeading: false,
                  title: Text(
                    'lane_dane'.tr,
                    style: defaultStyle.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.bgWhite,
                    ),
                  ),
                  backgroundColor: const Color(0xFF128C7E),
                  actions: [
                    IconButton(
                      onPressed: () => setState(() {
                        isSearch = true;
                      }),
                      icon: const Icon(Icons.search, color: Colors.black),
                    ),
                    IconButton(
                      onPressed: () {
                        Get.to(const Settings());
                      },
                      icon: const Icon(Icons.settings, color: Colors.black),
                    ),
                  ],
                );
        case 1:
          return isSearch
              ? AppBar(
                  elevation: 0.0,
                  title: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0, top: 5),
                    child: SearchBar(
                      leading: const Icon(Icons.search),
                      trailing: [
                        IconButton(
                          onPressed: () => setState(() {
                            isSearch = false;
                          }),
                          icon: const Icon(Icons.cancel),
                        ),
                      ],
                      hintText: 'Search here',
                    ),
                  ),
                  automaticallyImplyLeading: false,
                  backgroundColor: const Color(0xFF128C7E),
                )
              : AppBar(
                  elevation: 0.0,
                  automaticallyImplyLeading: false,
                  title: Text(
                    'lane_dane'.tr,
                    style: defaultStyle.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.bgWhite,
                    ),
                  ),
                  backgroundColor: const Color(0xFF128C7E),
                  actions: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          isSearch = true;
                        });
                      },
                      icon: const Icon(Icons.search, color: Colors.black),
                    ),
                    IconButton(
                      onPressed: () {
                        Get.to(const Settings());
                      },
                      icon: const Icon(Icons.settings, color: Colors.black),
                    ),
                  ],
                );
        case 2:
        case 3:
        case 4:
          return AppBar(
            elevation: 0.0,
            automaticallyImplyLeading: false,
            title: Text(
              'lane_dane'.tr,
              style: defaultStyle.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.bgWhite,
              ),
            ),
            backgroundColor: const Color(0xFF128C7E),
            actions: [
              IconButton(
                onPressed: () {
                  Get.to(const Settings());
                },
                icon: const Icon(Icons.settings, color: Colors.black),
              ),
            ],
          );
        default:
          throw UnimplementedError();
      }
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF128C7E),
        onPressed: () {
          Get.to(() => SelectContact());
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
      appBar: buildAppBar(),
      body: pages[pageIndex],
      bottomNavigationBar: Container(
        height: size.height * 0.07,
        decoration: const BoxDecoration(
          color: Colors.white70,
        ),
        child: Stack(
          children: [
            Container(
              height: size.height * 0.07,
              decoration: BoxDecoration(
                color: Colors.white70,
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(0), topLeft: Radius.circular(0)),
                border: Border.all(
                  color: Colors.grey.shade300,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(top: size.height * 0.015),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          pageIndex = 0;
                          slider = size.width * 0.095;
                        });
                      },
                      child: Column(
                        children: [
                          pageIndex == 0
                              ? Icon(
                                  Icons.account_balance_wallet_rounded,
                                  color: const Color(0xFF128C7E),
                                  size: size.height * 0.03,
                                )
                              : Icon(
                                  Icons.account_balance_wallet_rounded,
                                  color: Colors.grey.shade800,
                                  size: size.height * 0.03,
                                ),
                        ],
                      ),
                    ),
                    InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () {
                        setState(() {
                          pageIndex = 1;
                          slider = size.width * 0.275;
                        });
                      },
                      child: Column(
                        children: [
                          pageIndex == 1
                              ? Icon(
                                  Icons.group,
                                  color: const Color(0xFF128C7E),
                                  size: size.height * 0.03,
                                )
                              : Icon(
                                  Icons.group,
                                  color: Colors.grey.shade800,
                                  size: size.height * 0.03,
                                ),
                        ],
                      ),
                    ),
                    InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () {
                        setState(() {
                          pageIndex = 2;
                          slider = size.width * 0.450;
                        });
                      },
                      child: Column(
                        children: [
                          pageIndex == 2
                              ? Icon(
                                  Icons.account_circle,
                                  color: const Color(0xFF128C7E),
                                  size: size.height * 0.03,
                                )
                              : Icon(
                                  Icons.account_circle_rounded,
                                  color: Colors.grey.shade800,
                                  size: size.height * 0.03,
                                ),
                        ],
                      ),
                    ),
                    InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () {
                        setState(() {
                          pageIndex = 3;
                          slider = size.width * 0.625;
                        });
                      },
                      child: Column(
                        children: [
                          pageIndex == 3
                              ? Icon(
                                  Icons.schedule,
                                  color: const Color(0xFF128C7E),
                                  size: size.height * 0.03,
                                )
                              : Icon(
                                  Icons.schedule_rounded,
                                  color: Colors.grey.shade800,
                                  size: size.height * 0.03,
                                ),
                        ],
                      ),
                    ),
                    InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () {
                        setState(() {
                          pageIndex = 4;
                          slider = size.width * 0.800;
                        });
                      },
                      child: Column(
                        children: [
                          pageIndex == 4
                              ? Icon(
                                  Icons.calculate_sharp,
                                  color: const Color(0xFF128C7E),
                                  size: size.height * 0.03,
                                )
                              : Icon(
                                  Icons.calculate_outlined,
                                  color: Colors.grey.shade800,
                                  size: size.height * 0.03,
                                ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            AnimatedPositioned(
              height: size.height * 0.055,
              left: slider,
              duration: const Duration(milliseconds: 300),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: size.width * 0.10,
                    height: size.height * 0.0055,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                      color: Color.fromRGBO(0, 130, 106, 1),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
