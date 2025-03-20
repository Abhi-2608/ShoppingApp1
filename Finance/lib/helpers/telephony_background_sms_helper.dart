import 'package:lane_dane/helpers/notification_service_helper.dart';
import 'package:lane_dane/models/personal_transaction.dart';
import 'package:lane_dane/utils/sms_parser_utils.dart';
import 'package:telephony/telephony.dart';

void setupTelephony() {
  Telephony.instance.listenIncomingSms(
    onNewMessage: foregroundSmsHandler,
    onBackgroundMessage: backgroundSmsHandler,
    listenInBackground: true,
  );
  Telephony.backgroundInstance.listenIncomingSms(
    onNewMessage: foregroundSmsHandler,
    onBackgroundMessage: backgroundSmsHandler,
    listenInBackground: true,
  );
}

Future<void> foregroundSmsHandler(SmsMessage message) async {
  PersonalTransaction? personalTransaction = parseSmsToTransaction(message);
  // todo: un-comment and fix the issues with the NotificationService
  NotificationService notifications = NotificationService();

  notifications.showIncomingTransactionSmsNotification(
    personalTransaction: personalTransaction!,
  );
}

@pragma('vm:entry-point')
Future<void> backgroundSmsHandler(SmsMessage message) async {
  PersonalTransaction? personalTransaction = parseSmsToTransaction(message);

  // todo: un-comment and fix the issues with the NotificationService
  // NotificationService notifications = NotificationService();

  // notifications.showIncomingTransactionSmsNotification(
  //   allTransaction: allTransaction,
  // );
}
