import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class IntroScreen3 extends StatefulWidget {
  const IntroScreen3({Key? key}) : super(key: key);

  @override
  State<IntroScreen3> createState() => _IntroScreen3State();
}

class _IntroScreen3State extends State<IntroScreen3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const SizedBox(height: 80),
              SvgPicture.asset("assets/images/intro 3.svg"),
              const SizedBox(height: 80),
              Row(
                children: [
                  Text(
                    'intro 3'.tr,
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Text(
                "intro 3 content".tr,
                style: const TextStyle(
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
