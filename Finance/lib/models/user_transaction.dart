import 'dart:convert';

import 'package:lane_dane/models/group_transaction_model.dart';
import 'package:lane_dane/models/users.dart';
import 'package:objectbox/objectbox.dart';

import 'categories_model.dart';

enum TransactionTypeEnum { lane, dane }

enum TransactionType {
  Lane,
  Dane,
}

enum PaymentStatus { cash, online, Due, Done }

enum Confirmation { requested, accepted, declined }

@Entity()
class UserTransaction {
  @Id()
  int? id;
  int trUserId;
  int? laneUserId;
  int? daneUserId;
  String amount;
  String paymentStatus;
  String? confirmation;
  DateTime createdAt;
  DateTime? updatedAt;
  DateTime? dueDate;
  @Unique()
  int? serverId;
  int? settleTransactionId;

  ToOne<Users> user = ToOne<Users>();
  ToOne<GroupTransactionModel> groupTransaction =
      ToOne<GroupTransactionModel>();
  ToOne<CategoriesModel> category = ToOne<CategoriesModel>();

  UserTransaction({
    this.id,
    this.serverId,
    required this.trUserId,
    this.laneUserId,
    this.daneUserId,
    required this.amount,
    required this.paymentStatus,
    this.confirmation = 'requested',
    required this.createdAt,
    this.dueDate,
    this.updatedAt,
    required this.settleTransactionId,
  });

  int? get contactId => trUserId != laneUserId ? laneUserId : daneUserId;

  Map<String, dynamic> toMap() => {
        'id': id,
        'trUserId': trUserId,
        'laneUserId': laneUserId,
        'daneUserId': daneUserId,
        'amount': amount,
        'paymentStatus': paymentStatus,
        'confirmation': confirmation,
        'createdAt': createdAt.millisecondsSinceEpoch,
        'updatedAt': updatedAt?.millisecondsSinceEpoch,
        'dueDate': dueDate,
      };

  factory UserTransaction.fromMap(Map<String, dynamic> map) => UserTransaction(
        serverId: map['id'] as int?,
        trUserId: map['user_id'] as int,
        laneUserId: map['lane_user_id'] as int?,
        daneUserId: map['dane_user_id'] as int?,
        amount: map['amount'].toString(),
        paymentStatus: map['payment_status'] as String,
        confirmation:
            map['confirmation'] as String? ?? Confirmation.requested.name,
        createdAt: DateTime.parse(map['created_at'] as String).toLocal(),
        updatedAt: map['updated_at'] != null
            ? DateTime.parse(map['updated_at'] as String).toLocal()
            : null,
        dueDate:
            map['due_date'] != null ? DateTime.parse(map['due_date']) : null,
        settleTransactionId: map['settle_transaction_id'] as int? ?? 0,
      );
  String toJson() => json.encode(toMap());
  String get transactionType {
    //TODO need to create Uservm then import will fix this (user vm for user id)
    // UserVM userVM = Get.find();
    // if (laneUserId == userVM.userId) {

    if (laneUserId == 1) {
      return TransactionTypeEnum.lane.name;
    } else {
      return TransactionTypeEnum.dane.name;
    }
  }

  factory UserTransaction.fromJson(String source) =>
      UserTransaction.fromMap(json.decode(source) as Map<String, dynamic>);
}
