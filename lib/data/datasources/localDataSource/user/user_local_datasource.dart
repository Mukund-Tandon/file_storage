import 'package:goal_lock/domain/entities/subscribtion_details_entity.dart';
import 'package:goal_lock/domain/entities/user_entity.dart';
import 'package:goal_lock/hive_objects.dart';
import 'package:hive/hive.dart';

abstract class UserLocalDataSource {
  Future<void> storeUserDetailsLocally(UserEntity userEntity);
  UserEntity? getLocalyStoredUserDetails(UserEntity userEntity);
  Future<void> storeSubcribtionDetailsLocally(
      SubcribtionDetailEntity subcribtionDetailEntity);
  Future<UserEntity?> updateField(String field, dynamic data);
}

class UserLocalDataSourceImpl implements UserLocalDataSource {
  final Box box;
  UserLocalDataSourceImpl({required this.box});
  @override
  Future<void> storeUserDetailsLocally(UserEntity userEntity) async {
    print(userEntity);
    await box.putAll({
      'email': userEntity.email,
      'premium': userEntity.premium,
      'uid': userEntity.uid,
      'space': userEntity.space
    });
  }

  @override
  UserEntity? getLocalyStoredUserDetails(UserEntity userEntity) {
    try {
      userEntity.space = box.get('space');
      userEntity.premium = box.get('premium');
      if (userEntity.premium) {
        var a = box.get('endTime');
        var b = box.get('cancelled');
        SubcribtionDetailEntity subcribtionDetailEntity =
            SubcribtionDetailEntity(cancelled: b, endTime: a);
        userEntity.subcribtionDetailsEntity = subcribtionDetailEntity;
        print('dfhhkjs');
        print(userEntity.subcribtionDetailsEntity?.cancelled);
        print(userEntity.subcribtionDetailsEntity?.endTime);
      }
      return userEntity;
    } on StackTrace {
      return null;
    }
  }

  @override
  Future<void> storeSubcribtionDetailsLocally(
      SubcribtionDetailEntity subcribtionDetailEntity) async {
    print(subcribtionDetailEntity.endTime);
    await box.put('cancelled', subcribtionDetailEntity.cancelled);
    await box.put('endTime', subcribtionDetailEntity.endTime);

    var a = box.get('endTime');
    print(a);
    print('added subcribtion detaisl');
  }

  @override
  Future<UserEntity?> updateField(String field, dynamic data) async {
    try {
      await box.put(field, data);
    } catch (e) {
      return null;
    }
  }
}
