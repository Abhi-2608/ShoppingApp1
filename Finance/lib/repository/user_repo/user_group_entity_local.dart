import 'package:lane_dane/data/local/objectbox.g.dart';
import 'package:lane_dane/main.dart';
import 'package:lane_dane/models/user_group_entity_model.dart';

class UserGroupEntityLocal {
  final Box<UserGroupEntityModel> box =
      OBJECTBOX.store.box<UserGroupEntityModel>();

  UserGroupEntityModel create({
    int? id,
    required int entityId,
    required UserGroupEntityType type,
    required int amount,
    DateTime? lastActivityTime,
    required String name,
    String? profilePicture,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool commit = true,
  }) {
    final DateTime now = DateTime.now();

    UserGroupEntityModel usergroup = UserGroupEntityModel(
      id: id ?? 0,
      entityId: entityId,
      amount: amount,
      lastActivityTime: lastActivityTime ?? now,
      name: name,
      profilePicture: profilePicture,
      createdAt: createdAt ?? now,
      updatedAt: updatedAt ?? now,
    )..type = type;
    if (!commit) {
      return usergroup;
    }

    box.put(usergroup);
    return usergroup;
  }

  UserGroupEntityModel updateOrCreate({
    int? id,
    required int entityId,
    required UserGroupEntityType type,
    required int amount,
    DateTime? lastActivityTime,
    required String name,
    String? profilePicture,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    QueryBuilder<UserGroupEntityModel> querybuilder = box.query(
        (UserGroupEntityModel_.id.equals(id ?? 0)).or(UserGroupEntityModel_
            .entityId
            .equals(entityId)
            .and(UserGroupEntityModel_.dbType.equals(type.index))));
    Query<UserGroupEntityModel> query = querybuilder.build();

    UserGroupEntityModel? retrievedEntity = query.findFirst();
    UserGroupEntityModel entity;
    if (retrievedEntity != null) {
      entity = create(
        id: retrievedEntity.id,
        entityId: entityId,
        type: type,
        amount: retrievedEntity.amount + amount,
        lastActivityTime: lastActivityTime ?? retrievedEntity.lastActivityTime,
        name: name,
        profilePicture: profilePicture ?? retrievedEntity.profilePicture,
        createdAt: createdAt ?? retrievedEntity.createdAt,
        updatedAt: updatedAt ?? retrievedEntity.updatedAt,
      );
    } else {
      entity = create(
        id: id,
        entityId: entityId,
        type: type,
        amount: amount,
        lastActivityTime: lastActivityTime,
        name: name,
        profilePicture: profilePicture,
      );
    }

    return entity;
  }

  List<UserGroupEntityModel> retrieveAllOrderByLastActivityTime() {
    QueryBuilder<UserGroupEntityModel> querybuilder = box.query();
    querybuilder.order(UserGroupEntityModel_.lastActivityTime,
        flags: Order.descending);
    Query<UserGroupEntityModel> query = querybuilder.build();

    return query.find();
  }

  void clear() {
    box.removeAll();
  }
}

extension StreamProviders on UserGroupEntityLocal {
  Stream<Query<UserGroupEntityModel>> streamAllOrderByLastActivityTime() {
    QueryBuilder<UserGroupEntityModel> querybuilder = box.query();
    querybuilder.order(UserGroupEntityModel_.lastActivityTime,
        flags: Order.descending);
    Stream<Query<UserGroupEntityModel>> query =
        querybuilder.watch(triggerImmediately: false);

    return query;
  }
}
