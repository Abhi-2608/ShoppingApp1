import 'package:get/get.dart';
import 'package:lane_dane/models/personal_transaction.dart';
import 'package:lane_dane/repository/auth_repo/auth_local.dart';
import 'package:lane_dane/repository/personal_tnx_repo/personal_tnx_local.dart';

class ProfileVM extends GetxController {
  var currentUser;
  var cashInPersonalTx = 0.0.obs;
  var cashOutPersonalTx = 0.0.obs;
  var cashInUserTx = 0.0.obs;
  var cashOutUserTx = 0.0.obs;

  final reactiveVariable = ''.obs;
  final filterBy = ''.obs;

  ProfileVM() {
    currentUser = AuthLocal.getUser();
  }

  filterItems() {
    switch (filterBy.value) {
      case 'today':
        filterByToday();
        break;
      case 'last_week':
        filterByLastWeek();
        break;
      case 'last_month':
        filterByLastMonth();
        break;
    }
  }

  filterByToday() {
    var now = DateTime.now();
    cashInPersonalTx.value = PersonalTransaction.where((transaction) =>
            transaction.date.isAtSameMomentAs(now) &&
            transaction.type == 'lane')
        .fold(0.0, (sum, transaction) => sum + transaction.amount);

    cashOutPersonalTx.value = PersonalTransaction.where((transaction) =>
            transaction.date.isAtSameMomentAs(now) &&
            transaction.type == 'dane')
        .fold(0.0, (sum, transaction) => sum + transaction.amount);
  }

  filterByLastWeek() {
    var now = DateTime.now();
    var lastWeek = now.subtract(Duration(days: 7));
    cashInPersonalTx.value = PersonalTransaction.where((transaction) =>
            transaction.date.isAfter(lastWeek) &&
            transaction.date.isBefore(now) &&
            transaction.type == 'lane')
        .fold(0.0, (sum, transaction) => sum + transaction.amount);

    cashOutPersonalTx.value = PersonalTransaction.where((transaction) =>
            transaction.date.isAfter(lastWeek) &&
            transaction.date.isBefore(now) &&
            transaction.type == 'dane')
        .fold(0.0, (sum, transaction) => sum + transaction.amount);
  }

  filterByLastMonth() {
    var now = DateTime.now();
    var lastMonth = DateTime(now.year, now.month - 1, now.day);
    cashInPersonalTx.value = PersonalTransaction.where((transaction) =>
            transaction.date.isAfter(lastMonth) &&
            transaction.date.isBefore(now) &&
            transaction.type == 'lane')
        .fold(0.0, (sum, transaction) => sum + transaction.amount);

    cashOutPersonalTx.value = PersonalTransaction.where((transaction) =>
            transaction.date.isAfter(lastMonth) &&
            transaction.date.isBefore(now) &&
            transaction.type == 'dane')
        .fold(0.0, (sum, transaction) => sum + transaction.amount);
  }
}
