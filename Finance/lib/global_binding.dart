import 'package:get/get.dart';
import 'package:lane_dane/view_models/personal_tx_vm.dart';
import 'package:lane_dane/view_models/auth_vm.dart';
import 'package:lane_dane/view_models/sms_vm.dart';

class GlobalBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(AuthVM());
    Get.put(SmsVM());
    Get.put(PersonalTransactionVM());
    // Get.put(TransactionVM());
  }
}
