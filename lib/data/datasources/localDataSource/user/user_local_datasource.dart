import 'package:goal_lock/domain/entities/user_entity.dart';
import 'package:goal_lock/hive_objects.dart';
import 'package:hive/hive.dart';

abstract class UserLocalDataSource {
  Future<void> storeUserDetailsLocally(UserEntity userEntity);
  UserEntity? getLocalyStoredUserDetails(UserEntity userEntity);
}

class UserLocalDataSourceImpl implements UserLocalDataSource {
  final Box box;
  UserLocalDataSourceImpl({required this.box});
  @override
  Future<void> storeUserDetailsLocally(UserEntity userEntity) async {
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
      return userEntity;
    } on StackTrace {
      return null;
    }
  }
}
