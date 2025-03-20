import 'package:intl/intl.dart';
import 'package:lane_dane/data/remote/network/network.api.service.dart';
import 'package:lane_dane/helpers/local_store.dart';
import 'package:lane_dane/main.dart';

class PersonalTransactionApi {
  LocalStore localStore = LocalStore();
  final NetworkApiService _apiService = NetworkApiService();
  final LocalStore localstore = LocalStore();

  PersonalTransactionApi() {
    /* 
      * This is probably handled by the NetworkProvider itself
     */
    // _apiService = NetworkApiService(
    //   host: BaseApiService.kBaseUrl,
    //   defaultHeader: {
    //     'Content-Type': 'application/json',
    //     'Accept': 'application/json',
    //     'Authorization': 'Bearer $token',
    //   },
    //   defaultToHTTPS: BaseApiService.defaultToHttps,
    // );
  }

  Future<List<dynamic>> get() async {
    Map<String, dynamic> responseBody = await _apiService.post(
      '/api/personal-transactions',
      query: {
        'last_transaction_fetch': DateFormat('y-M-d H:m:s')
            .format(localStore.retrieveLastTransactionTime()),
      },
    );

    talker.debug(
        "@PersonalTransactionApi : getRemoteTransactions : ${responseBody['transactions']}");

    localStore.updateLastTransactionTime(DateTime.now());

    return responseBody['personal_transactions'];
  }

  Future<Map<String, dynamic>> create(Map<String, dynamic> data) async {
    Map<String, dynamic> responseBody = await _apiService.post(
      '/api/personal-transactions',
      body: {
        'amount': data['amount'],
        'description': data['description'],
        'transaction_type': data['transactionType'],
        'acc_number': data['accNumber'],
        'bank': data['bank'],
      },
    );

    talker.debug(
        "@PersonalTransactionApi : createTransaction : ${responseBody['transactions']}");

    // todo: you will get "transaction_id" as serverID for your object
    return responseBody['personal_transaction'];
  }
}
