import 'dart:convert';

import 'package:lane_dane/models/group_transaction_model.dart';
import 'package:lane_dane/models/user_transaction.dart';
import 'package:objectbox/objectbox.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
@Entity()
class PersonalTransaction {
  @Id()
  int? id;
  int? serverId; // id from server
  String transactionType;
  String accNumber;
  String? smsBody;
  String amount;
  String description;
  DateTime createdAt;

  DateTime? updatedAt;

  ToOne<UserTransaction> transactionId = ToOne<UserTransaction>();
  ToOne<GroupTransactionModel> groupTransaction =
      ToOne<GroupTransactionModel>();

  PersonalTransaction({
    this.id,
    this.smsBody,
    this.serverId,
    required this.transactionType,
    required this.amount,
    required this.accNumber,
    required this.createdAt,
    required this.description,
    this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'serverId': serverId,
      'smsBody': smsBody,
      'transactionType': transactionType,
      'amount': amount,
      'accNumber': accNumber,
      'description': description,
      'transactionId': transactionId.target?.id ?? 0,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt?.millisecondsSinceEpoch,
    };
  }

  factory PersonalTransaction.fromMap(Map<String, dynamic> map) {
    return PersonalTransaction(
      id: map['id'],
      serverId: map['serverId'] != null ? map['serverId'] as int : null,
      smsBody: map['smsBody'],
      description:
          map['description'] != null ? map['description'] as String : '',
      transactionType: map['transactionType'] as String,
      amount: map['amount'] as String,
      accNumber: map['accNumber'] as String,
      createdAt: (map['createdAt'] is int
          ? DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int)
          : map['createdAt'] as DateTime),
      updatedAt: map['updatedAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] as int)
          : map['createdAt'] as DateTime,
    );
  }

  String toJson() => json.encode(toMap());

  factory PersonalTransaction.fromJson(String source) =>
      PersonalTransaction.fromMap(json.decode(source) as Map<String, dynamic>);

  static where(bool Function(dynamic transaction) param0) {}
}
