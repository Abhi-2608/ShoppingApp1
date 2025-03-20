import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lane_dane/models/personal_transaction.dart';
import 'package:lane_dane/views/reminder_screen/premium.dart';

class ReminderTitleListView extends StatefulWidget {
  final PersonalTransaction smsTransaction;
  final bool showTitle;
  final List<PersonalTransaction> alltransaction;
  final int index;
  final smsBody;
  const ReminderTitleListView(
      {super.key,
      required this.index,
      required this.smsTransaction,
      required this.showTitle,
      required this.alltransaction,
      required this.smsBody});
  get greenColor => null;

  @override
  State<ReminderTitleListView> createState() => _ReminderTitleListViewState();
}

class _ReminderTitleListViewState extends State<ReminderTitleListView> {
  @override
  Widget build(BuildContext context) {
    bool ispremium = false;

    const Color laneArrowColor = Color(0xFF55AA55);
    const Color daneArrowColor = Color(0xFFDD2222);
    final Color laneBackgroundColor = laneArrowColor.withOpacity(0.2);
    final Color daneBackgroundColor = daneArrowColor.withOpacity(0.2);

    return Column(
      children: [
        widget.showTitle
            ? Container(
                height: 32,
                color: const Color.fromRGBO(223, 228, 237, 1),
                width: double.infinity,
                child: Center(child: Text('${widget.smsTransaction.smsBody}')),
              )
            : Container(
                height: 1,
              ),
        ListTile(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return const Premium();
              },
            ));
          },
          leading: CircleAvatar(
            radius: 21,
            backgroundColor: widget.smsTransaction.transactionType == 'dane'
                ? daneBackgroundColor
                : laneBackgroundColor,
            child: Transform.rotate(
              angle: widget.smsTransaction.transactionType == 'dane'
                  ? math.pi / 4
                  : math.pi / -1.25,
              child: Icon(
                Icons.arrow_upward,
                color: widget.smsTransaction.transactionType == 'dane'
                    ? daneArrowColor
                    : laneArrowColor,
                size: 24,
              ),
            ),
          ),
          title: Text(
            widget.smsTransaction.amount,
            style: TextStyle(
                color: widget.smsTransaction.transactionType == 'dane'
                    ? Colors.red
                    : Colors.green,
                fontSize: 20,
                fontWeight: FontWeight.w600),
          ),
          subtitle: Text(
            widget.smsTransaction.accNumber,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
          trailing: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                DateFormat("d MMM").format(widget.smsTransaction.createdAt),
                style: GoogleFonts.roboto(
                  color: const Color(0xFF8F8F8F),
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                DateFormat("jm").format(widget.smsTransaction.createdAt),
                style: GoogleFonts.roboto(
                  color: const Color(0xFF8F8F8F),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
