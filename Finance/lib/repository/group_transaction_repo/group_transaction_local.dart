import 'package:lane_dane/data/local/objectbox.g.dart';
import 'package:lane_dane/main.dart';
import 'package:lane_dane/models/categories_model.dart';
import 'package:lane_dane/models/group_model.dart';
import 'package:lane_dane/models/group_transaction_model.dart';
import 'package:lane_dane/models/users.dart';

class GroupTransactionController {
  final Box<GroupTransactionModel> box =
      OBJECTBOX.store.box<GroupTransactionModel>();

  GroupTransactionModel create({
    int? id,
    int? serverId,
    required int creatorId,
    required int amount,
    required Groups group,
    required List<Users> participantsToAdd,
    CategoriesModel? category,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    GroupTransactionModel groupTransaction = GroupTransactionModel(
      id: id ?? 0,
      creatorId: creatorId,
      amount: amount,
      group: ToOne(targetId: group.id),
      category: ToOne(target: category),
      participantsToAdd: participantsToAdd,
      createdAt: createdAt ?? DateTime.now(),
      updatedAt: updatedAt ?? DateTime.now(),
    );

    int insertedId = box.put(groupTransaction);
    if (serverId != null) {
      groupTransaction.serverId = serverId;
    } else {
      groupTransaction.serverId = insertedId * -1;
    }
    box.put(groupTransaction);

    return groupTransaction;
  }

  GroupTransactionModel? retrieveGroupTransactionFromServerId({
    required int serverId,
  }) {
    QueryBuilder<GroupTransactionModel> querybuilder =
        box.query(GroupTransactionModel_.serverId.equals(serverId));
    querybuilder.order(GroupTransactionModel_.serverId,
        flags: Order.descending);
    Query<GroupTransactionModel> query = querybuilder.build();
    return query.findFirst();
  }

  List<GroupTransactionModel> retrieveForGroupOrderByServerId(
      {required int groupId}) {
    QueryBuilder<GroupTransactionModel> querybuilder =
        box.query(GroupTransactionModel_.group.equals(groupId));
    querybuilder.order(GroupTransactionModel_.createdAt,
        flags: Order.descending);
    Query<GroupTransactionModel> query = querybuilder.build();
    return query.find();
  }

  List<GroupTransactionModel> retrieveWithNegativeServerId() {
    QueryBuilder<GroupTransactionModel> querybuilder =
        box.query(GroupTransactionModel_.serverId.lessThan(0));
    Query<GroupTransactionModel> query = querybuilder.build();
    return query.find();
  }

  GroupTransactionModel updateOrCreate({
    int? id,
    int? serverId,
    required int creatorId,
    required int amount,
    required Groups group,
    required List<Users> participantsToAdd,
    CategoriesModel? category,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    QueryBuilder<GroupTransactionModel> querybuilder = box.query(
        GroupTransactionModel_.id
            .equals(id ?? 0)
            .or(GroupTransactionModel_.serverId.equals(serverId ?? 0)));
    Query<GroupTransactionModel> query = querybuilder.build();

    GroupTransactionModel? existingTransaction = query.findFirst();
    GroupTransactionModel updatedTransaction;
    if (existingTransaction != null) {
      updatedTransaction = create(
        id: id ?? existingTransaction.id,
        serverId: serverId ?? existingTransaction.serverId,
        amount: amount,
        creatorId: creatorId,
        group: group,
        participantsToAdd: participantsToAdd,
        category: category ?? existingTransaction.category.target,
        createdAt: createdAt ?? existingTransaction.createdAt,
        updatedAt: updatedAt ?? existingTransaction.updatedAt,
      );
    } else {
      updatedTransaction = create(
        serverId: serverId,
        amount: amount,
        creatorId: creatorId,
        group: group,
        participantsToAdd: participantsToAdd,
        category: category,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );
    }

    return updatedTransaction;
  }

  GroupTransactionModel updateGroupTransactionParticipants({
    int? groupId,
    int? groupServerId,
    required List<Users> userList,
  }) {
    assert(groupId != null || groupServerId != null);
    QueryBuilder<GroupTransactionModel> querybuilder = box.query(
        GroupTransactionModel_.id
            .equals(groupId ?? 0)
            .or(GroupTransactionModel_.serverId.equals(groupServerId ?? 0)));
    Query<GroupTransactionModel> query = querybuilder.build();
    GroupTransactionModel? groupTransaction = query.findFirst();
    if (groupTransaction == null) {
      throw 'Group transaction does not exist with the given id';
    }
    groupTransaction.transactionParticipants.addAll(userList);
    box.put(groupTransaction);
    return groupTransaction;
  }

  void clear() {
    box.removeAll();
  }
}

extension StreamProvider on GroupTransactionController {
  Stream<Query<GroupTransactionModel>> streamAllForGroupIdSortByServerId(
      int groupId) {
    QueryBuilder<GroupTransactionModel> querybuilder =
        box.query(GroupTransactionModel_.group.equals(groupId));
    querybuilder.order(GroupTransactionModel_.createdAt,
        flags: Order.descending);
    Stream<Query<GroupTransactionModel>> stream = querybuilder.watch();
    return stream;
  }
}
