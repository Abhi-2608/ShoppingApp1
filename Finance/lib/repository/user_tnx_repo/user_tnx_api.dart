import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:lane_dane/data/remote/network/base.api.service.dart';
import 'package:lane_dane/data/remote/network/network.api.service.dart';
import 'package:lane_dane/helpers/local_store.dart';
import 'package:lane_dane/main.dart';
import 'package:lane_dane/models/auth_user.dart';
import 'package:lane_dane/models/user_transaction.dart';
import 'package:lane_dane/models/users.dart';

class UserTransactionApi {
  GetStorage box = GetStorage();
  late final NetworkApiService _apiService;
  late final LocalStore localstore;

  UserTransactionApi() {
    final token = box.read('token');
    localstore = LocalStore();
    _apiService = NetworkApiService(
      host: BaseApiService.kBaseUrl,
      defaultHeader: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      defaultToHTTPS: BaseApiService.defaultToHttps,
    );
  }
// getRemoteTransactions
  Future<List<dynamic>> get(DateTime after) async {
    try {
      Map<String, dynamic> responseBody = await _apiService.post(
        '/api/user-transactions',
        query: {
          'last_transaction_fetch': DateFormat('y-M-d H:m:s').format(after),
        },
      );

      if (!responseBody.containsKey('success')) {
        // throw (
        //   message:
        //       'Failed to fetch transactions. The server responded with invalid data',
        //   missingData: 'success',
        //   object: responseBody,
        // );
      }
      Map<String, dynamic> responseSuccess = responseBody['success'];
      if (!responseSuccess.containsKey('transactions')) {
        // throw (
        //   message:
        //       'Failed to fetch transactions. The server responded with invalid data',
        //   missingData: 'transactions',
        //   object: responseBody,
        // );
      }
      List<dynamic> responseTransactions = responseSuccess['transactions'];
      talker.debug(
          "@TransactionApi : getRemoteTransactions : ${responseTransactions.length}");
      return responseTransactions;
    } catch (err) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> post(
      UserTransaction transaction, Users user) async {
    GetStorage shared = GetStorage();
    //can create issue
    AuthUser authUser = shared.read('auth_user');

    int creatorId = authUser.id;
    String creatorPhoneNumber = authUser.phoneNumberWithCode.toString();
    String creatorName = authUser.fullName;
    DateTime after = DateTime.now();
    bool laneIsCreator =
        transaction.transactionType == TransactionTypeEnum.lane.name;

    try {
      Map<String, String> responseBody = await _apiService.post(
        '/api/user-transactions',
        query: jsonEncode({
          "transaction": {
            // "id": transaction.id,
            "amount": transaction.amount,
            "payment_status": transaction.paymentStatus,
            "due_date": transaction.dueDate != null
                ? DateFormat('yyyy-MM-dd').format(transaction.dueDate!)
                : null,
            "lane_user": transaction.laneUserId,
            "dane_user": transaction.daneUserId,
          },
          "category": transaction.category.target?.message == null
              ? null
              : {
                  "id": -1,
                  "name": transaction.category.target?.message,
                },
          "laneUser": {
            "id": laneIsCreator ? creatorId : user.serverId,
            "phone_no":
                laneIsCreator ? creatorPhoneNumber : user.phoneNumberWithCode,
            "full_name": laneIsCreator ? creatorName : user.full_name,
          },
          "daneUser": {
            "id": laneIsCreator ? user.serverId : creatorId,
            "phone_no":
                laneIsCreator ? user.phoneNumberWithCode : creatorPhoneNumber,
            "full_name": laneIsCreator ? user.full_name : creatorName,
          },
        }) as Map<String, String>,
      );

      return jsonDecode(responseBody as String);
    } catch (err) {
      rethrow;
    }
  }

  Future<bool> confirmTransaction(
      UserTransaction transaction, Confirmation confirmation) async {
    try {
      List<dynamic> responseBody = await _apiService.post(
        '/api/confirm-transaction',
        query: {
          "server_id": transaction.serverId.toString(),
          "confirmation": confirmation.name.toLowerCase(),
        },
      );

      bool responseSuccessStatus = responseBody[0] == 'success';
      return responseSuccessStatus;
    } catch (err) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> settleUpTransaction(
      UserTransaction transaction, int settledTransactionId) async {
    GetStorage shared = GetStorage();
    AuthUser authUser = shared.read('auth_user');

    int creatorId = authUser.id;
    String creatorPhoneNumber = authUser.phoneNumber;
    String creatorName = authUser.fullName;

    bool laneIsCreator =
        transaction.transactionType == TransactionTypeEnum.lane.name;

    Users user = transaction.user.target!;
    try {
      dynamic responseBody = await _apiService.post(
        '/api/settle-up',
        query: {
          'server_id': jsonEncode({'value': settledTransactionId}),
          "transaction": jsonEncode({
            "id": transaction.id,
            "amount": transaction.amount,
            "payment_status": transaction.paymentStatus,
            "due_date": transaction.dueDate != null
                ? DateFormat('yyyy-MM-dd').format(transaction.dueDate!)
                : null,
            "lane_user": transaction.laneUserId,
            "dane_user": transaction.daneUserId,
          }),
          "category": transaction.category.target?.message == null
              ? jsonEncode({"id": -1, "name": ''})
              : jsonEncode({
                  "id": -1,
                  "name": transaction.category.target?.message ?? '',
                }),
          "laneUser": jsonEncode({
            "id": laneIsCreator ? creatorId : user.serverId,
            "phone_no":
                laneIsCreator ? creatorPhoneNumber : user.phoneNumberWithCode,
            "full_name": laneIsCreator ? creatorName : user.full_name,
          }),
          "daneUser": jsonEncode({
            "id": laneIsCreator ? user.serverId : creatorId,
            "phone_no":
                laneIsCreator ? user.phoneNumberWithCode : creatorPhoneNumber,
            "full_name": laneIsCreator ? user.full_name : creatorName,
          }),
        },
      );
      return responseBody['success']['transaction'];
    } catch (err) {
      rethrow;
    }
  }
}
