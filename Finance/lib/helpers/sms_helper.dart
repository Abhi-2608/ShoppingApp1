import 'package:flutter/foundation.dart';
import 'package:lane_dane/helpers/local_store.dart';
import 'package:lane_dane/models/personal_transaction.dart';
import 'package:lane_dane/repository/personal_tnx_repo/personal_tnx_local.dart';
import 'package:lane_dane/services/sms_service.dart';
import 'package:lane_dane/utils/permission_manager.dart';
import 'package:lane_dane/utils/sms_parser_utils.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:telephony/telephony.dart';

class SmsHelper {
  late LocalStore localstore;
  late PermissionManager permissions;
  SmsHelper() {
    localstore = LocalStore();
    permissions = PermissionManager();
  }

  Future<void> parseAndStoreTransactionSms() async {
    if (!permissions.smsReadPermission.value) {
      await permissions.requestPermission(
          Permission.sms, permissions.smsReadPermission);
    }

    DateTime lastSmsTime = localstore.retrieveLastSmsTime();

    List<SmsMessage> smsList = await SmsService().getAllReceivedBetween(
      start: lastSmsTime,
      end: DateTime.now(),
    );

    List<PersonalTransaction> transactionList = await compute(
      parseSms,
      smsList,
    );
    if (transactionList.isNotEmpty) {
      localstore.updateLastSmsTime(transactionList.first.createdAt);
    }
    PersonalTransactionLocal().addMultiplePersonalTransaction(transactionList);
  }

  static List<PersonalTransaction> parseSms(List<SmsMessage> smsList) {
    List<PersonalTransaction> transactionList = [];

    for (SmsMessage message in smsList) {
      PersonalTransaction? transaction = parseSmsToTransaction(message);
      if (transaction != null) {
        transactionList.add(transaction);
      }
    }
    return transactionList;
  }
}
