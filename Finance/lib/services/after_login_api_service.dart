import 'package:lane_dane/main.dart';
import 'package:lane_dane/repository/personal_tnx_repo/personal_tnx_api.dart';
import 'package:lane_dane/repository/personal_tnx_repo/personal_tnx_local.dart';

class ApiService {
  late List<dynamic Function()> postLoginCallbacks;

  ApiService() {
    postLoginCallbacks = [];
    synchronizePersonalTransactions();
  }

  Future<void> synchronizePersonalTransactions() async {
    final unSynchronizedPersonalTransactions =
        PersonalTransactionLocal().getByServerIdNull();

    talker.info(
        "@ApiService : synchronizePersonalTransactions() -> There are ${unSynchronizedPersonalTransactions.length} UnSycned Tnx... Syncing Now");

    for (var eachTnx in unSynchronizedPersonalTransactions) {
      Map<String, dynamic> personalTnx =
          await PersonalTransactionApi().create(eachTnx.toMap());

      talker.info(
          "@ApiService : synchronizePersonalTransactions() -> recieved personal_tnxponse as $personalTnx");

      eachTnx.serverId = personalTnx['id'];

      PersonalTransactionLocal.personalTnxBox.put(eachTnx);
    }
  }

  Future<void> addApiCallBack() async {
    talker.debug("@ApiService : addApiCallBack : Adding Callbacks");
    for (int i = 0; i < postLoginCallbacks.length; i++) {
      dynamic Function() callback = postLoginCallbacks[i];
      await callback();
    }
  }
}
