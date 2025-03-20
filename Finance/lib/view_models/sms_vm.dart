import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:lane_dane/helpers/permission_manager.dart';
import 'package:lane_dane/utils/filter_sms_between.dart';
import 'package:telephony/telephony.dart';

class SmsVM extends GetxController {
  // retrieveAllSmsTransactions
  // resendFailedTransactions
  // resendFailedGroupTransactions

  late PermissionManager _permissionManager;

  SmsVM() {
    _permissionManager = PermissionManager();
    _permissionManager.loadPermissions();
  }

  Future<bool> requestSmsPermission() async {
    return await _permissionManager.requestSmsReadPermission();
  }

  Future<bool> requestContactsPermission() async {
    return await _permissionManager.requestContactsReadPermission();
  }

  Future<void> handleSmsPermission() async {
    bool granted = await requestSmsPermission();
    if (granted) {
      fetchSmsData();
    } else {
      showPermissionDeniedMessage();
    }
  }

  Future<void> handleContactsPermission() async {
    bool granted = await requestContactsPermission();
    if (granted) {
      fetchContactData();
    } else {
      showPermissionDeniedMessage();
    }
  }

  Future<List<SmsMessage>> getAll() async {
    // return await smsquery.getAllSms;
    return await Telephony.instance.getInboxSms();
  }

  Future<List<SmsMessage>> getAllReceived() async {
    return await getAll();
  }

  Future<List<SmsMessage>> getAllReceivedBetween({
    required DateTime start,
    required DateTime end,
  }) async {
    List<SmsMessage> allSms = await getAllReceived();
    // List<Map> allSmsMap = allSms.map<Map>((SmsMessage sms) {
    //   return sms.toMap;
    // }).toList();
    List<SmsMessage> smsBetween =
        await compute<Map<String, dynamic>, List<SmsMessage>>(
      filterSmsOnIsolate,
      {
        'sms_list': allSms,
        'start': start,
        'end': end,
      },
    );
    return smsBetween;
  }
}

Future<List<SmsMessage>> filterSmsOnIsolate(Map<String, dynamic> params) async {
  List<SmsMessage> allSms = params['sms_list'];
  DateTime start = params['start'];
  DateTime end = params['end'];

  List<SmsMessage> filteredSmsList = filterSmsBetween(allSms, start, end);
  return filteredSmsList;
}

Future<void> fetchSmsData() async {
  //todo logic
}

Future<void> fetchContactData() async {}

void showPermissionDeniedMessage() {}
