/*

-> This is a widget that displays the listTile of the contacts
-> values are passed to it through the constructor...
-> No API Calls are done here,
-> OnTap takes you to addTransaction Screen
*/

import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:get/get.dart';
import 'package:lane_dane/controllers/app_controllers/app_controller.dart';
import 'package:lane_dane/helpers/aggregate_record.dart';
import 'package:lane_dane/models/group_model.dart';
import 'package:lane_dane/models/user_transaction.dart';
import 'package:lane_dane/models/user_group_entity_model.dart';
import 'package:lane_dane/models/users.dart';
import 'package:lane_dane/repository/group_repo/group_local.dart';
import 'package:lane_dane/repository/user_repo/user_group_entity_local.dart';
import 'package:lane_dane/repository/user_repo/user_local.dart';
import 'package:lane_dane/res/colors.dart';

class UserTransactionSingleChatsLIstTile extends StatefulWidget {
  final UserGroupEntityModel entity;
  const UserTransactionSingleChatsLIstTile({
    Key? key,
    required this.entity,
  }) : super(key: key);

  @override
  State<UserTransactionSingleChatsLIstTile> createState() =>
      _UserTransactionSingleChatsLIstTileState();
}

class _UserTransactionSingleChatsLIstTileState
    extends State<UserTransactionSingleChatsLIstTile>
    with SingleTickerProviderStateMixin {
  /// Send a list of transactions to this method to calculate the remainig
  /// lane/dane amount.
  ///
  /// If the return value is positive, then the pending amount is of type lane.
  /// If the return value is negative, then the pending amount is of type dane.
  int calculatePending(List<UserTransaction> transactionList) {
    AggregateRecord record =
        AggregateRecord.fromTransactionList(list: transactionList);
    int laneAmount = record.lanePending;
    int daneAmount = record.danePending;

    return (laneAmount - daneAmount);
  }

  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  UserLocal userLocal = UserLocal();
  UserGroupEntityLocal userGroupLocal = UserGroupEntityLocal();
  GroupLocal groupLocal = GroupLocal();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleTap() {
    _animationController.forward().then((value) {
      _animationController.reverse();
      toTransactionListScreen();
    });
  }

  void toTransactionListScreen() {
    AppController appController = Get.find();
    if (widget.entity.type == UserGroupEntityType.user) {
      Users user = userLocal.retrieveOnly(widget.entity.entityId)!;
      // todo: navigate to single user chat screen...
      Get.snackbar('TODO', "navigate to single user chat screen...");
      // Get.toNamed(
      //   PersonalTransactions.routeName,
      //   arguments: {
      //     'contact': user,
      //   },
      // );
    } else if (widget.entity.type == UserGroupEntityType.group) {
      Groups group = groupLocal.retrieveGroup(widget.entity.entityId)!;
      // todo: navigate to group transaction screen...
      Get.snackbar('TODO', "navigate to group transaction screen...");
      // Get.toNamed(
      //   GroupTransactionScreen.routeName,
      //   arguments: {
      //     'group': group,
      //   },
      // );
    }
  }

  @override
  Widget build(BuildContext context) {
    // int amount = calculatePending(
    //   TransactionController().retrieveUserTransaction(contact.user.targetId),
    // );
    int amount = widget.entity.amount;
    String pending =
        '\u{20B9}${amount.abs()} ${amount > 0 ? TransactionType.Lane.name.toLowerCase().tr : TransactionType.Dane.name.toLowerCase().tr} ${'pending'.tr}';
    if (amount == 0) {
      pending = 'no_pending_amount'.tr;
    }

    return InkWell(
      onTap: _handleTap,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: ListTile(
          // onTap: toTransactionListScreen,
          leading: ProfilePicture(
            name: widget.entity.name,
            radius: 21,
            fontsize: 21,
            random: true,
          ),
          title: Text(
            widget.entity.name,
            style: const TextStyle(
                color: AppColors.label,
                fontSize: 18,
                fontWeight: FontWeight.w500),
          ),
          subtitle: Text(pending),
        ),
      ),
    );
  }
}
