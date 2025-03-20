import 'package:get_storage/get_storage.dart';
import 'package:lane_dane/data/local/objectbox.g.dart';
import 'package:lane_dane/models/user_transaction.dart';

import '/main.dart';

/*
  This file is responsible for managing transactions in the local database using ObjectBox.
  It provides methods to CRUD transactions. also provides methods to retrieve transactions based on different criteria such as user ID and group transaction ID. 
  The class uses ObjectBox's Box and QueryBuilder classes to interact with the local db
  The Box class provides methods to perform CRUD operations .
  The StreamProvider provide a method to watch for changes in the transactions of a specific user .
*/

class UserTransactionLocal {
  GetStorage getStorage = GetStorage();
  static final userTnxBox = OBJECTBOX.store.box<UserTransaction>();

  final String lastUpdateKey = 'last-update';
  Box<UserTransaction> get box => userTnxBox;

  // final UserLocal userLocal = UserLocal();
  // final CategoryLocal categoryLocal = CategoryLocal();

//   TransactionsModel addSingleTransaction({
//     int? id,
//     int? serverId,
//     int? groupTransactionId,
//     required int trUserId,
//     required int laneUserId,
//     required int daneUserId,
//     required String amount,
//     required String paymentStatus,
//     required String confirmation,
//     required Users targetUser,
//     CategoriesModel? category,
//     required String description,
//     required DateTime createdAt,
//     DateTime? updatedAt,
//     DateTime? dueDate,
//     int? settleTransactionId,
//   }) {
//     TransactionsModel transactionsModel = TransactionsModel(
//       trUserId: trUserId,
//       laneUserId: laneUserId,
//       daneUserId: daneUserId,
//       amount: amount,
//       paymentStatus: paymentStatus,
//       confirmation: confirmation,
//       createdAt: createdAt,
//       updatedAt: updatedAt,
//       dueDate: dueDate,
//       settleTransactionId: settleTransactionId,
//     );

//     transactionsModel.groupTransaction.targetId = groupTransactionId;
//     transactionsModel.user.target = targetUser;
//     transactionsModel.category.target = category;

//     int newId = transactionModelBox.put(transactionsModel);
//     if (serverId == null) {
//       transactionsModel.serverId = (newId * -1);
//       transactionModelBox.put(transactionsModel);
//     }
//     return transactionsModel;
//   }

//   TransactionsModel updateOrCreate({
//     int? id,
//     int? serverId,
//     int? groupTransactionId,
//     required int trUserId,
//     required int laneUserId,
//     required int daneUserId,
//     required int amount,
//     required String paymentStatus,
//     required Users user,
//     required String description,
//     String? confirmation,
//     CategoriesModel? category,
//     required DateTime createdAt,
//     DateTime? updatedAt,
//     DateTime? dueDate,
//     int? settleTransactionId,
//   }) {
//     QueryBuilder<TransactionsModel> querybuilder = transactionModelBox.query(
//         TransactionsModel_.id
//             .equals(id ?? 0)
//             .or(TransactionsModel_.serverId.equals(serverId ?? 0)));
//     Query<TransactionsModel> query = querybuilder.build();

//     TransactionsModel? existingTransaction = query.findFirst();
//     TransactionsModel newTransaction;
//     if (existingTransaction != null) {
//       newTransaction = addSingleTransaction(
//         id: existingTransaction.id,
//         description: description,
//         serverId: serverId ?? existingTransaction.serverId,
//         groupTransactionId: groupTransactionId ??
//             existingTransaction.groupTransaction.target?.id,
//         trUserId: trUserId,
//         laneUserId: laneUserId,
//         daneUserId: daneUserId,
//         amount: amount.toString(),
//         paymentStatus: paymentStatus,
//         confirmation: confirmation ??
//             (existingTransaction.confirmation ?? Confirmation.requested.name),
//         targetUser: user,
//         category: category ?? existingTransaction.category.target!,
//         createdAt: createdAt ?? existingTransaction.createdAt,
//         updatedAt: updatedAt ?? DateTime.now(),
//         dueDate: dueDate ?? existingTransaction.dueDate,
//         settleTransactionId:
//             settleTransactionId ?? existingTransaction.settleTransactionId,
//       );
//     } else {
//       newTransaction = addSingleTransaction(
//         serverId: serverId,
//         groupTransactionId: groupTransactionId,
//         trUserId: trUserId,
//         laneUserId: laneUserId,
//         daneUserId: daneUserId,
//         description: description,
//         amount: amount.toString(),
//         paymentStatus: paymentStatus,
//         confirmation: confirmation ?? Confirmation.requested.name,
//         targetUser: user,
//         category: category,
//         createdAt: createdAt,
//         updatedAt: updatedAt,
//         dueDate: dueDate,
//         settleTransactionId: settleTransactionId,
//       );
//     }

//     return newTransaction;
//   }

//   List<PersonalTransaction> retrieveAllSmsTransactions() {
//     QueryBuilder<PersonalTransaction> querybuilder = allTransactionBox.query(
//         // Use allTransactionBox here
//         PersonalTransaction_.transactionId
//             .equals(0)
//             .and(PersonalTransaction_.groupTransaction.equals(0)));
//     querybuilder.order(PersonalTransaction_.createdAt, flags: Order.descending);
//     Query<PersonalTransaction> query = querybuilder.build();
//     List<PersonalTransaction> smsTransactionList = query.find();
//     return smsTransactionList;
//   }

//   // List<TransactionsModel> getAllTransactions() {
//   //   return transactionModelBox.getAll();
//   // }

//   TransactionsModel? retrieveOnly(int id) {
//     TransactionsModel? t = box.get(id);
//     return t;
//   }

//   TransactionsModel? retrieveServerIdTransaction(int? serverId) {
//     if (serverId == null) {
//       return null;
//     }
//     QueryBuilder<TransactionsModel> query =
//         transactionModelBox.query(TransactionsModel_.serverId.equals(serverId));
//     TransactionsModel? transactionList = query.build().findFirst();

//     return transactionList;
//   }

//   /// Take Users.id as an argument
//   ///
//   /// Returns a list of transactions associated with the given Users.id
//   List<TransactionsModel> retrieveUserTransaction(int id) {
//     QueryBuilder<TransactionsModel> query =
//         transactionModelBox.query(TransactionsModel_.user.equals(id));
//     query.order(TransactionsModel_.createdAt, flags: Order.descending);
//     List<TransactionsModel> transactionList = query.build().find();

//     return transactionList;
//   }

//   TransactionsModel transactionFromServerResponse(
//     Map<String, dynamic> transactionMap,
//   ) {
//     talker.debug(
//         "@TransactionLocal : transactionFromServerResponse : user ID -> ${getStorage.read('auth_user')['id']}");
//     Users contact =
//         getStorage.read('auth_user')['id'] == transactionMap['lane_user_id']
//             ? Users.fromMap(transactionMap['dane_user'])
//             : Users.fromMap(transactionMap['lane_user']);
//     TransactionsModel transaction = TransactionsModel.fromMap(transactionMap);

//     Map<String, dynamic> laneUser = transactionMap['lane_user'];
//     Map<String, dynamic> daneUser = transactionMap['dane_user'];
//     Map<String, dynamic>? categoryMap = transactionMap['category'];
//     talker.debug(
//         "@TransactionLocal : transactionFromServerResponse : categoryMap $categoryMap");

//     Users targetUser = userLocal.updateOrCreate(
//         serverId: contact.id,
//         fullName: contact.full_name ??
//             transactionMap[
//                 'fallback_name'], // todo : There is not 'fallback_name' fr transactionMAP, figure out why is this like this from main branch and eithe remove it or add it
//         phoneNumber: contact.phoneNumber.toString().phoneNumber,
//         onBoardedAt: contact.onBoardedAt);

//     CategoriesModel? category;
//     if (categoryMap != null) {
//       category = categoryLocal.updateOrCreate(
//         id: transaction.category.target?.id,
//         serverId: categoryMap['id'],
//         message: categoryMap['name'],
//       );
//     }

//     // todo: Un-comment and fix this later, do no delete this code
//     // GroupTransaction? groupTransaction;
//     // if (transactionMap['group_transaction_id'] != null) {
//     //   groupTransaction =
//     //       groupTransactionController.retrieveGroupTransactionFromServerId(
//     //     serverId: transactionMap['group_transaction_id'],
//     //   );
//     // }

//     String fallbackDate = DateTime.now().toString();
//     var description =
//         'Being Set by develope in TRANSACTION_LOCAL transactionFromServerResponse';

//     // todo: THis function required category to not be null, but since my transactionMap holds category as null, I had to modify the funciton to get category as non-required parameter
//     TransactionsModel updatedTransaction = updateOrCreate(
//       id: transaction.id,
//       serverId: transactionMap['id'],
//       trUserId: transactionMap['user_id'],
//       laneUserId: laneUser['id'],
//       daneUserId: daneUser['id'],
//       description: description,
//       amount: double.parse(transactionMap['amount'].toString()).toInt(),
//       paymentStatus: transactionMap['payment_status'],
//       confirmation: transactionMap['confirmation'],
//       user: targetUser,
//       category: category,
//       createdAt: DateTime.parse(transactionMap['created_at'] ?? fallbackDate),
//       updatedAt: DateTime.parse(transactionMap['updated_at'] ?? fallbackDate),
//       dueDate: transactionMap['due_date'] != null
//           ? DateTime.parse(transactionMap['due_date'])
//           : null,
//       settleTransactionId: transactionMap['settle_transaction_id'] ?? 0,
//       groupTransactionId: null,
//     );
//     talker.info(
//         "@TransactionLocal : transactionFromServerResponse : $updatedTransaction");
//     return updatedTransaction;
//   }

//   List<TransactionsModel> retrieveForGroupTransactionId(
//       int groupTransactionId) {
//     QueryBuilder<TransactionsModel> query = transactionModelBox
//         .query(TransactionsModel_.groupTransaction.equals(groupTransactionId));
//     query.order(TransactionsModel_.createdAt, flags: Order.descending);
//     List<TransactionsModel> transactionList = query.build().find();

//     return transactionList;
//   }

//   TransactionsModel acceptTransaction(TransactionsModel transaction) {
//     transaction.confirmation = 'Accepted';
//     box.put(transaction);
//     return transaction;
//   }

//   TransactionsModel declineTransaction(TransactionsModel transaction) {
//     transaction.confirmation = 'Declined';
//     box.put(transaction);
//     return transaction;
//   }

//   void resetConfirmationStatus(TransactionsModel transaction) {
//     transaction.confirmation = Confirmation.requested.name;
//     box.put(transaction);
//   }

//   List<TransactionsModel> getUnsentTransactions() {
//     QueryBuilder<TransactionsModel> querybuilder = box.query(TransactionsModel_
//         .serverId
//         .lessOrEqual(0)
//         .and(TransactionsModel_.groupTransaction.equals(0)));
//     Query<TransactionsModel> query = querybuilder.build();
//     return query.find();
//   }

//   bool deleteTransaction(int id) {
//     return box.remove(id);
//   }

//   /// Returns a non 0 id if an object was removed. If it was not present,
//   /// or could not be removed, returns 0 instead.
//   int deleteTransactionWithServerId(int serverId) {
//     QueryBuilder<TransactionsModel> querybuilder =
//         box.query(TransactionsModel_.serverId.equals(serverId));
//     Query<TransactionsModel> query = querybuilder.build();
//     TransactionsModel? transaction = query.findFirst();

//     if (transaction == null) {
//       return 0;
//     } else {
//       box.remove(transaction.id!);
//       return transaction.id!;
//     }
//   }

//   bool remove(int id) {
//     return box.remove(id);
//   }

//   void clear() {
//     box.removeAll();
//   }
// }

// extension StreamProviders on UserTransactionLocal {
//   Stream<Query<TransactionsModel>> streamAllForUserIdSortByServerId(
//       int userId) {
//     QueryBuilder<TransactionsModel> querybuilder =
//         box.query(TransactionsModel_.user.equals(userId));
//     querybuilder.order(TransactionsModel_.createdAt, flags: Order.descending);
//     Stream<Query<TransactionsModel>> stream = querybuilder.watch();
//     return stream;
//   }
// }
}
