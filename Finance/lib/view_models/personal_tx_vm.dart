import 'package:get/get.dart';
import 'package:lane_dane/models/personal_transaction.dart';
import 'package:lane_dane/repository/personal_tnx_repo/personal_tnx_local.dart';
import 'package:lane_dane/utils/permission_manager.dart';

class PersonalTransactionVM extends GetxController {
  final PersonalTransactionLocal _personalTransactionLocal =
      PersonalTransactionLocal();
  PermissionManager permissions = PermissionManager();
  RxList personalTnxRecordList = [].obs;
  var stream = ''.obs;
  RxBool showTitle = true.obs;
  RxInt indx = 0.obs;
  // single TNX
  late PersonalTransaction showTnx;

  //RxInt index = 0.obs;

  void getSmsTransactions() {
    if (personalTnxRecordList.isEmpty) {
      personalTnxRecordList =
          _personalTransactionLocal.retrieveAllSmsTransactions().obs;
    }
  }
  // streamSmsTransactions()  {
  //   return controller.streamAllSmsTransactions();
  // }

  bool haveTitle(int idx) {
    if (idx == 0) {
      return true;
    }
    if (personalTnxRecordList[idx].createdAt.day ==
            personalTnxRecordList[idx - 1].createdAt.day &&
        personalTnxRecordList[idx].createdAt.month ==
            personalTnxRecordList[idx - 1].createdAt.month &&
        personalTnxRecordList[idx].createdAt.year ==
            personalTnxRecordList[idx - 1].createdAt.year) {
      return false;
    }

    return true;
  }
}
