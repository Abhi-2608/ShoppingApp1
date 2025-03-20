import 'package:lane_dane/data/local/objectbox.g.dart';
import 'package:lane_dane/main.dart';
import 'package:lane_dane/models/personal_transaction.dart';
import 'package:lane_dane/models/user_transaction.dart';

class PersonalTransactionLocal {
  static final personalTnxBox = OBJECTBOX.store.box<PersonalTransaction>();

  Box<PersonalTransaction> get box => personalTnxBox;

  void addMultiplePersonalTransaction(List<PersonalTransaction> allTnx) {
    personalTnxBox.putMany(allTnx);
  }

  List<PersonalTransaction> getByServerIdNull() {
    return personalTnxBox
        .query(PersonalTransaction_.serverId.isNull())
        .build()
        .find();
  }

  void addMultipleTransactions(List<PersonalTransaction> transactionList) {
    for (PersonalTransaction transaction in transactionList) {
      PersonalTransaction? instance =
          retrieveOnlyTransactionModelId(transaction);
      if (instance == null) {
        addPersonalTransaction(
          accNumber: transaction.accNumber,
          transactionType: transaction.transactionType,
          amount: transaction.amount,
          createdAt: transaction.createdAt.toString(),
          updatedAt: transaction.updatedAt?.toString(),
          transactionId: transaction.id,
        );
      }
    }
  }

  PersonalTransaction addPersonalTransaction({
    int? id,
    int? transactionId,
    int? groupTransactionId,
    String? smsBody,
    required String amount,
    required String transactionType,
    required String createdAt,
    required String accNumber,
    String? updatedAt,
  }) {
    PersonalTransaction object = PersonalTransaction(
      id: id ?? 0,
      smsBody: smsBody,
      transactionType: transactionType,
      amount: double.parse(amount).toInt().toString(),
      accNumber: accNumber,
      createdAt: DateTime.parse(createdAt),
      updatedAt: updatedAt != null ? DateTime.parse(updatedAt) : null,
      description: '',
    );
    object.transactionId.targetId = transactionId;
    object.groupTransaction.targetId = groupTransactionId;
    personalTnxBox.put(object);
    return object;
  }

  PersonalTransaction updateOrCreate({
    int? id,
    int? transactionId,
    int? groupTransactionId,
    String? smsBody,
    required String amount,
    required String accNumber,
    required String transactionType,
    required String createdAt,
    String? updatedAt,
  }) {
    QueryBuilder<PersonalTransaction> querybuilder = personalTnxBox.query(
        PersonalTransaction_.id.equals(id ?? 0).or(PersonalTransaction_
            .transactionId
            .equals(transactionId ?? -1)
            .or(PersonalTransaction_.groupTransaction
                .equals(groupTransactionId ?? -1))));
    Query<PersonalTransaction> query = querybuilder.build();

    PersonalTransaction? existingAllTransaction = query.findFirst();
    PersonalTransaction newAllTransaction;
    if (existingAllTransaction != null) {
      newAllTransaction = addPersonalTransaction(
        id: existingAllTransaction.id,
        transactionId:
            transactionId ?? existingAllTransaction.transactionId.targetId,
        smsBody: smsBody ?? existingAllTransaction.smsBody,
        amount: amount,
        transactionType: transactionType,
        createdAt: createdAt,
        accNumber: accNumber,
        updatedAt: updatedAt ?? DateTime.now().toString(),
      );
    } else {
      newAllTransaction = addPersonalTransaction(
        transactionId: transactionId,
        smsBody: smsBody,
        amount: amount,
        accNumber: accNumber,
        transactionType: transactionType,
        createdAt: createdAt,
        updatedAt: updatedAt ?? DateTime.now().toString(),
      );
    }
    return newAllTransaction;
  }

  PersonalTransaction? updateOrReturn({
    int? id,
    int? transactionId,
    int? groupTransactionId,
    String? smsBody,
    required String amount,
    required String accNumber,
    required String transactionType,
    required String createdAt,
    String? updatedAt,
  }) {
    if (id == 0 || id == null) {
      return null;
    }
    PersonalTransaction? existingAllTransaction = box.get(id);
    if (existingAllTransaction == null) {
      return null;
    }
    existingAllTransaction = addPersonalTransaction(
      id: existingAllTransaction.id,
      transactionId:
          transactionId ?? existingAllTransaction.transactionId.targetId,
      groupTransactionId: groupTransactionId ??
          existingAllTransaction.groupTransaction.targetId,
      smsBody: smsBody ?? existingAllTransaction.smsBody,
      amount: amount,
      accNumber: accNumber,
      transactionType: transactionType,
      createdAt: createdAt,
      updatedAt: updatedAt ?? DateTime.now().toString(),
    );
    return existingAllTransaction;
  }

  List<PersonalTransaction> getAllTransactions() {
    return personalTnxBox.getAll();
  }

  List<PersonalTransaction> retrieveAllNonRequestedTransactions({
    bool sorted = true,
  }) {
    QueryBuilder<PersonalTransaction> queryBuilder = box.query();

    /*
     * Need to somehow filter requested transactions below without losing the
     * list sms transactions. 
     */
    // queryBuilder.link<TransactionsModel>(
    //     PersonalTransaction_.transactionId,
    //     TransactionsModel_.confirmation
    //         .equals('requested', caseSensitive: false));

    queryBuilder.order(PersonalTransaction_.createdAt, flags: Order.descending);

    Query<PersonalTransaction> query = queryBuilder.build();
    List<PersonalTransaction> nonRequestedTransactionList = query.find();

    return nonRequestedTransactionList;
  }

  List<PersonalTransaction> retrieveAllNonDeclinedTransactions({
    bool sorted = true,
  }) {
    QueryBuilder<PersonalTransaction> queryBuilder = box.query();

    /*
     * Need to somehow filter requested transactions below without losing the
     * list sms transactions. 
     */
    // queryBuilder.link<TransactionsModel>(
    //     PersonalTransaction_.transactionId,
    //     TransactionsModel_.confirmation
    //         .equals('requested', caseSensitive: false));

    queryBuilder.order(PersonalTransaction_.createdAt, flags: Order.descending);

    Query<PersonalTransaction> query = queryBuilder.build();
    List<PersonalTransaction> nonRequestedTransactionList = query.find();

    return nonRequestedTransactionList
        .where((PersonalTransaction alltransaction) {
      if (!alltransaction.transactionId.hasValue) {
        return true;
      } else {
        return alltransaction.transactionId.target!.confirmation!
                .toLowerCase() !=
            Confirmation.declined.name.toLowerCase();
      }
    }).toList();
  }

  PersonalTransaction? retrieveOnly(int id) {
    PersonalTransaction? transaction = box.get(id);
    return transaction;
  }

  PersonalTransaction? retrieveLatestSmsTransaction() {
    QueryBuilder<PersonalTransaction> querybuilder = box.query(
        PersonalTransaction_.transactionId
            .equals(0)
            .and(PersonalTransaction_.groupTransaction.equals(0)));
    querybuilder.order(PersonalTransaction_.createdAt);
    Query<PersonalTransaction> query = querybuilder.build();
    List<PersonalTransaction> personalTnxList = query.find();
    if (personalTnxList.isEmpty) {
      return null;
    } else {
      return personalTnxList.last;
    }
  }

  /// Returns an PersonalTransaction? for a given id
  /// If an equivalent PersonalTransaction exists for a supplied TransactionsModel,
  /// then an PersonalTransaction is returned
  /// If no PersonalTransaction exists for a supplied TransactionsModel,
  /// then null is returned
  PersonalTransaction? retrieveOnlyTransactionModelId(PersonalTransaction t) {
    QueryBuilder<PersonalTransaction> queryBuilder =
        box.query(PersonalTransaction_.transactionId.equals(t.id!));
    PersonalTransaction? allTransactionInstance =
        queryBuilder.build().findFirst();
    return allTransactionInstance;
  }

  // PersonalTransaction updateTransaction(
  //   PersonalTransaction transaction, {
  //   int? transactionId,
  //   String? name,
  //   TransactionTypeEnum? transactionType,
  // }) {
  //   // update with arguments provided and commit
  //   // return object with updated values
  //   if (transactionId != null) {
  //     transaction.transactionId = transactionId;
  //   }
  //   if (name != null) {
  //     transaction.name = name;
  //   }
  //   if (transactionType != null) {
  //     transaction.transactionType = transactionType;
  //   }
  //   transaction.updatedAt = DateTime.now();
  //   box.put(transaction);
  //   return transaction;
  // }

  /// Returns a non 0 id if an object was removed. If it was not present,
  /// or could not be removed, returns 0 instead.
  int deleteAllTransactionWithTransactionId(int id) {
    QueryBuilder<PersonalTransaction> querybuilder =
        box.query(PersonalTransaction_.transactionId.equals(id));
    Query<PersonalTransaction> query = querybuilder.build();
    PersonalTransaction? personalTnx = query.findFirst();

    if (personalTnx == null) {
      return 0;
    } else {
      box.remove(personalTnx.id!);
      return personalTnx.id!;
    }
  }

  List<PersonalTransaction> retrieveAllSmsTransactions() {
    QueryBuilder<PersonalTransaction> querybuilder = box.query(
        PersonalTransaction_.transactionId
            .equals(0)
            .and(PersonalTransaction_.groupTransaction.equals(0)));
    querybuilder.order(PersonalTransaction_.createdAt, flags: Order.descending);
    Query<PersonalTransaction> query = querybuilder.build();
    List<PersonalTransaction> personalTnxList = query.find();
    talker.debug(
        "@PersonalTransactionLocal : retrieveAllSmsTransactions() -> We got ${personalTnxList.length} Personal Transactions");
    return personalTnxList;
  }

  void remove(int id) {
    box.remove(id);
  }

  void clear() {
    box.removeAll();
  }
}

// extension StreamProviders on AllTransactionController {
//   Stream<Query<PersonalTransaction>> streamAllSmsTransactions() {
//     QueryBuilder<PersonalTransaction> querybuilder = box.query(
//         PersonalTransaction_.transactionId
//             .equals(0)
//             .and(PersonalTransaction_.groupTransaction.equals(0)));
//     querybuilder.order(PersonalTransaction_.createdAt,
//         flags: Order.descending);
//     Stream<Query<PersonalTransaction>> stream = querybuilder.watch();
    
//     return stream;
//   }
// }
