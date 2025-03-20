import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:get/get.dart';
import 'package:lane_dane/helpers/aggregate_record.dart';
import 'package:lane_dane/models/user_transaction.dart';
import 'package:lane_dane/models/user_group_entity_model.dart';
import 'package:lane_dane/res/colors.dart';

class UserGroupListTile extends StatefulWidget {
  final UserGroupEntityModel entity;
  const UserGroupListTile({
    Key? key,
    required this.entity,
  }) : super(key: key);

  @override
  State<UserGroupListTile> createState() => _UserGroupListTileState();
}

class _UserGroupListTileState extends State<UserGroupListTile>
    with SingleTickerProviderStateMixin {
  int calculatePending(List<UserTransaction> transactionList) {
    AggregateRecord record =
        AggregateRecord.fromTransactionList(list: transactionList);
    int laneAmount = record.lanePending;
    int daneAmount = record.danePending;

    return (laneAmount - daneAmount);
  }

  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

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
    if (widget.entity.type == UserGroupEntityType.user) {
      // Handle navigation for user entity type
      // Example: Navigator.pushNamed(context, '/user_transaction_screen');
    } else if (widget.entity.type == UserGroupEntityType.group) {
      // Handle navigation for group entity type
      // Example: Navigator.pushNamed(context, '/group_transaction_screen');
    }
  }

  @override
  Widget build(BuildContext context) {
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
          leading: ProfilePicture(
            count: 1, // to limit how many prefix names are displayed.
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
