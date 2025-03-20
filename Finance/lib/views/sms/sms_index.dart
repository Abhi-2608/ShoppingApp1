//first tab
//logic to whether to load sms_permission or sms_list
//TODO convert to getview

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lane_dane/view_models/sms_vm.dart';
// import 'home_view_model.dart';

class SmsIndex extends GetView<SmsVM> {
  const SmsIndex({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: controller.handleSmsPermission,
              child: const Text('Request SMS Permission'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: controller.handleContactsPermission,
              child: const Text('Request Contacts Permission'),
            ),
          ],
        ),
      ),
    );
  }
}
