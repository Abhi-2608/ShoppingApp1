import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lane_dane/res/colors.dart';

import 'package:lane_dane/routes.dart';
import 'package:lane_dane/views/introscreens/introscreen1.dart';
import 'package:lane_dane/views/introscreens/introscreen2.dart';
import 'package:lane_dane/views/introscreens/introscreen3.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class IntroMain extends StatelessWidget {
  static const routeName = 'intro-main';

  final PageController _controller = PageController();

  int currentPageIndex = 0;

  IntroMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (int index) {
              currentPageIndex = index;
            },
            children: const [
              IntroScreen1(),
              IntroScreen2(),
              IntroScreen3(),
            ],
          ),
          Container(
            alignment: const Alignment(-0.82, 0.65),
            child: SmoothPageIndicator(
              controller: _controller,
              count: 3,
              effect: const ExpandingDotsEffect(
                dotColor: Color(0xff26D367),
                activeDotColor: Color(0xff26D367),
              ),
            ),
          ),
          Positioned(
            bottom: 40,
            right: 20,
            child: ElevatedButton(
              onPressed: () {
                if (currentPageIndex == 0) {
                  _controller.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.linear);
                } else if (currentPageIndex == 1) {
                  _controller.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.linear);
                } else if (currentPageIndex == 2) {
                  Get.toNamed(AppRoutes.enterPhoneNumber);
                  // Get.to(() => const EnterPhoneNumber());
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff00A884),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                fixedSize: const Size(119, 50),
              ),
              child: Text(
                "Next ->",
                style: TextStyle(
                  color: AppColors.bgWhite,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
