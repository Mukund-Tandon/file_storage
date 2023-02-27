import 'package:goal_lock/domain/entities/subscribtion_details_entity.dart';

class UserEntity {
  String email;
  late String authToken;
  late String uid;
  late bool premium;
  late double space;
  SubcribtionDetailEntity? subcribtionDetailsEntity;
  UserEntity({required this.email});
}
