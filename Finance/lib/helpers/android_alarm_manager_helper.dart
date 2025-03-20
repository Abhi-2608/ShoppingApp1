import 'package:lane_dane/helpers/notification_service_helper.dart';
import 'package:lane_dane/models/personal_transaction.dart';
import 'package:lane_dane/services/sms_service.dart';
import 'package:lane_dane/utils/init.dart';
import 'package:lane_dane/utils/sms_parser_utils.dart';
import 'package:telephony/telephony.dart';
import 'package:timezone/timezone.dart' as tz;

class AndroidAlarmManagerHelper {
  static const int dailySpendingAlarmId = 0;

  static const Duration dailySpendingAlarmInterval = Duration(
    days: 1,
  );

  AndroidAlarmManagerHelper() {
    // AndroidAlarmManager.initialize();
  }

  Future<void> setupDailySmsAlarm() async {
    await setupFirebase();
    // FirebaseLogger.info('Setting up daily SMS alarm');

    DateTime now = DateTime.now();
    DateTime midnight = DateTime(now.year, now.month, now.day, 23, 59, 59);

    // await AndroidAlarmManager.cancel(dailySpendingAlarmId);

    // await AndroidAlarmManager.periodic(
    //   AndroidAlarmManagerHelper.dailySpendingAlarmInterval,
    //   AndroidAlarmManagerHelper.dailySpendingAlarmId,
    //   _parseAndShowDailySpending,
    //   allowWhileIdle: true,
    //   exact: true,
    //   rescheduleOnReboot: true,
    //   startAt: midnight,
    //   wakeup: true,
    // );
    // FirebaseLogger.info('Daily SMS alarm setup complete');
    // FirebaseLogger.sendReport();
  }
}

@pragma('vm:entry-point')
Future<void> _parseAndShowDailySpending() async {
  tz.Location india = setupTimeZone();
  await setupGetStorage();

  SmsService smsService = SmsService();
  DateTime now = DateTime.now().toLocal();

  DateTime start = DateTime(
    now.year,
    now.month,
    now.day - 1,
    now.hour,
    now.minute,
    now.second,
  );

  final List<SmsMessage> smsListBetween =
      await smsService.getAllReceivedBetween(
    start: start,
    end: now,
  );

  int totalSpentAmount = 0;
  int totalRecievedAmount = 0;

  for (SmsMessage message in smsListBetween) {
    PersonalTransaction? personalTnx = parseSmsToTransaction(message);
    if (personalTnx == null) {
      continue;
    }
    if (personalTnx.transactionType == 'credit') {
      totalRecievedAmount += int.parse(personalTnx.amount);
    }
    if (personalTnx.transactionType == 'debit') {
      totalSpentAmount += int.parse(personalTnx.amount);
    }
  }

  if (totalSpentAmount == 0) {
    return;
  }

  tz.TZDateTime tznow = tz.TZDateTime.now(india);
  tz.TZDateTime tzwhenToShow = tznow.add(const Duration(hours: 10));

  NotificationService notificationservice = NotificationService();
  notificationservice.scheduleDailyDebit(
    amount: totalSpentAmount,
    whenToShow: tzwhenToShow,
  );
}
