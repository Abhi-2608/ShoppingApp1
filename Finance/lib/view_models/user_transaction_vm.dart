import 'dart:async';
import 'dart:core';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lane_dane/data/local/objectbox.g.dart';
import 'package:lane_dane/main.dart';
import 'package:lane_dane/models/user_group_entity_model.dart';
import 'package:lane_dane/repository/user_repo/user_group_entity_local.dart';
import 'package:lane_dane/res/colors.dart';

class UserTransactionVM extends GetxController {
  late List<UserGroupEntityModel> entityList;
  UserGroupEntityLocal userGroupEntityLocal = UserGroupEntityLocal();
  late StreamSubscription<Query<UserGroupEntityModel>> subscription;
  RxInt indx = 0.obs;
  RxList dummyTransactions = [].obs;

  void onInit() {
    setDummy();
    addUserGroupEntityList();
    super.onInit();
  }

  void setDummy() {
    dummyTransactions.assignAll([
      {
        'amount': '₹10000',
        'timestamp': DateTime.now(),
        'type': 'received',
        'acceptButtonColor': const Color.fromRGBO(
            0, 128, 105, 1), // Set accept button color to rgba(0, 128, 105, 1)
        'declineButtonColor': AppColors.bgWhite, // Set decline button color to white
        'status': 'Pending',
      },
      {
        'amount': '₹5000',
        'timestamp': DateTime.now(),
        'type': 'sent',
        'acceptButtonColor': const Color.fromRGBO(
            0, 128, 105, 1), // Set accept button color to rgba(0, 128, 105, 1)
        'declineButtonColor': AppColors.bgWhite, // Set decline button color to white
        'status': 'Pending',
      },
      {
        'amount': '₹15000',
        'timestamp': DateTime.now(),
        'type': 'received',
        'acceptButtonColor': const Color.fromRGBO(
            0, 128, 105, 1), // Set accept button color to rgba(0, 128, 105, 1)
        'declineButtonColor': AppColors.bgWhite, // Set decline button color to white
        'status': 'Pending',
      },
      {
        'amount': '₹3000',
        'timestamp': DateTime.now(),
        'type': 'received',
        'acceptButtonColor': const Color.fromRGBO(
            0, 128, 105, 1), // Set accept button color to rgba(0, 128, 105, 1)
        'declineButtonColor': AppColors.bgWhite, // Set decline button color to white
        'status': 'Pending',
      },
      {
        'amount': '₹2000',
        'timestamp': DateTime.now(),
        'type': 'received',
        'acceptButtonColor': const Color.fromRGBO(
            0, 128, 105, 1), // Set accept button color to rgba(0, 128, 105, 1)
        'declineButtonColor': AppColors.bgWhite, // Set decline button color to white
        'status': 'Pending',
      },
      {
        'amount': '₹7000',
        'timestamp': DateTime.now(),
        'type': 'sent',
        'acceptButtonColor': const Color.fromRGBO(
            0, 128, 105, 1), // Set accept button color to rgba(0, 128, 105, 1)
        'declineButtonColor': AppColors.bgWhite, // Set decline button color to white
        'status': 'Pending',
      },
    ]);
  }

  void updateUserGroupEntityList(Query<UserGroupEntityModel> query) {
    entityList = query.find();
  }

  void addUserGroupEntityList() {
    entityList = userGroupEntityLocal.retrieveAllOrderByLastActivityTime();
    subscription = userGroupEntityLocal
        .streamAllOrderByLastActivityTime()
        .listen(updateUserGroupEntityList);
  }

  acceptTransaction(int index) {
    if (dummyTransactions[index]['acceptButtonColor'] != Colors.green) {
      dummyTransactions[index]['acceptButtonColor'] = Colors.green;
      dummyTransactions[index]['status'] = 'Accepted';
      talker.debug(
          "@userTransactionVM -> accept transaction ${dummyTransactions[index]['status']} and ${dummyTransactions[index]['acceptButtonColor']}");
      dummyTransactions.refresh();
    }
  }

  declineTransaction(int index) {
    if (dummyTransactions[index]['declineButtonColor'] != Colors.red) {
      dummyTransactions[index]['declineButtonColor'] = Colors.red;
      dummyTransactions[index]['status'] = 'Declined';
      dummyTransactions.refresh();
    }
  }
}
