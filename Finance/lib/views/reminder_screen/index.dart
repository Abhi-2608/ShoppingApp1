import 'package:flutter/material.dart';
import 'package:lane_dane/models/personal_transaction.dart';
import 'package:lane_dane/views/personal_transaction/index.dart';
import 'package:lane_dane/views/sms/widgets/ReminderTitleListView.dart';

class ReminderList extends StatefulWidget {
  const ReminderList({super.key});

  @override
  State<ReminderList> createState() => _ReminderListState();
}

class _ReminderListState extends State<ReminderList> {
  @override
  @override
  Widget build(BuildContext context) {
    PersonalTransaction txn1 = PersonalTransaction(
        transactionType: 'dane',
        smsBody: 'outgoing',
        amount: '20',
        accNumber: 'ICICX52',
        createdAt: DateTime(2024, 2, 1, 13, 01, 34),
        description: '');
    PersonalTransaction txn2 = PersonalTransaction(
        smsBody: 'incoming',
        transactionType: 'lane',
        amount: '100',
        accNumber: 'ICICX51',
        createdAt: DateTime(2024, 3, 1, 12, 01, 34),
        description: '');

    List<PersonalTransaction> allTransactionList = [txn1, txn2];

    return Scaffold(body: Builder(
      builder: (BuildContext context) {
        if (allTransactionList.isNotEmpty) {
          return AllTransactionLoader(
            alltransactionList: allTransactionList,
          );
        } else {
          return const PersonalTnxLoading();
        }
      },
    ));
  }
}

class AllTransactionLoader extends StatelessWidget {
  final List<PersonalTransaction> alltransactionList;
  const AllTransactionLoader({
    super.key,
    required this.alltransactionList,
  });

  @override
  Widget build(BuildContext context) {
    DateTime prev = DateTime(-1);

    return ListView.builder(
      itemCount: alltransactionList.length,
      itemBuilder: (context, index) {
        final transaction = alltransactionList[index];
        bool showTitle = prev == transaction.createdAt ? false : true;
        String? smsbody = transaction.smsBody;
        return ReminderTitleListView(
            index: index,
            showTitle: showTitle,
            smsTransaction: transaction,
            alltransaction: alltransactionList,
            smsBody: smsbody);
      },
    );
  }
}
