import 'package:lane_dane/models/user_group_entity_model.dart';

abstract class TransactionEntity {
  int entityId();
  String name();
  String details();
  bool isActive();
  UserGroupEntityType type();
}
