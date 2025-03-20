//sync user transactions on server with local on fetch,create,update,delete
import 'package:lane_dane/main.dart';
import 'package:lane_dane/repository/user_tnx_repo/user_tnx_api.dart';
import 'package:lane_dane/repository/user_tnx_repo/user_tnx_local.dart';

class UserTrxService {

  UserTrxService() {
    createUserTransactions();
    retriveUserTransactions();
    updateUserTransactions();
    deleteUserTransactions();
  }

  Future<void> createUserTransactions() async {

    // final unSynchronizedPersonalTransactions =
        // UserTransactionLocal().getByServerIdNull();

    // talker.info(
    //     "@ApiService : synchronizePersonalTransactions() -> There are ${unSynchronizedPersonalTransactions.length} UnSycned Tnx... Syncing Now");

    // for (var eachTnx in unSynchronizedPersonalTransactions) {
    //   Map<String, dynamic> personalTnx =
    //       await UserTransactionApi().create(eachTnx.toMap());

    //   talker.info(
    //       "@ApiService : synchronizePersonalTransactions() -> recieved personal_tnxponse as $personalTnx");

    //   eachTnx.serverId = personalTnx['id'];

    //   UserTransactionLocal.userTnxBox.put(eachTnx);
    // }
  }

  Future<void> retriveUserTransactions() async {}
  Future<void> updateUserTransactions() async {}
  Future<void> deleteUserTransactions() async {}

}