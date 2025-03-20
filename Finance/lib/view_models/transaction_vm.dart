import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lane_dane/models/categories_model.dart';
import 'package:lane_dane/models/users.dart';
import 'package:lane_dane/repository/user_tnx_repo/user_tnx_api.dart';
import 'package:lane_dane/repository/user_tnx_repo/user_tnx_local.dart';
import 'package:lane_dane/utils/extensions/date_time_extension.dart';
import 'package:lane_dane/view_models/auth_vm.dart';

class TransactionVM extends GetxController {
  final authController = Get.put(AuthVM());
  UserTransactionLocal controller = UserTransactionLocal();
  UserTransactionApi api = UserTransactionApi();
  RxInt trUserId = 0.obs;
  RxInt laneUserId = 0.obs; //
  RxInt daneUserId = 0.obs; //
  var amount = TextEditingController().obs;
  RxString paymentStatus = ''.obs;
  RxString confirmation = ''.obs;
  RxString transactionType = ''.obs;
  late Users targetUser;
  late CategoriesModel category; //
  RxString description = ''.obs;
  DateTime createdAt = DateTime.now();
  late RxInt length;
  Rx<DateTime> date = DateTime.now().obs;
  RxBool showDate = false.obs;

  @override
  void onInit() {
    super.onInit();
    length = 0.obs;
    addTransactions();
  }

  void addTransactions() {
    targetUser = Users(
        phone_no: authController.phoneNumber.toString(),
        onBoardedAt: DateTime(2024, 3, 1, 14, 09),
        tapCount: 2);
    category = CategoriesModel(
        lastAccessed: DateTime(2024, 3, 2, 1, 40, 00), message: 'message');

    // controller.addSingleTransaction(
    //     trUserId: trUserId.value,
    //     laneUserId: laneUserId.toInt(),
    //     daneUserId: daneUserId.toInt(),
    //     amount: amount.value.toString(),
    //     paymentStatus: paymentStatus.toString(),
    //     confirmation: confirmation.toString(),
    //     targetUser: targetUser,
    //     category: category,
    //     description: description.toString(),
    //     createdAt: createdAt);

    // getTrasactions();
  }

  void updateLength(int newLength) {
    length.value = newLength;
  }

  void setAmount(String initialAmount) {
    amount = TextEditingController(text: initialAmount).obs;
    updateLength(initialAmount.length);
  }

  void settrUserId(int txnId) {
    trUserId.value = txnId;
  }

  String formatDate() {
    return date.value.digitOnlyDate();
  }
}
