import 'package:goal_lock/data/datasources/remoteDataSource/user/user_remote_datasource.dart';
import 'package:goal_lock/domain/entities/subscribtion_details_entity.dart';
import 'package:goal_lock/domain/entities/user_entity.dart';

import '../datasources/localDataSource/user/user_local_datasource.dart';
import '../datasources/remoteDataSource/premium/premium_remote_data_source.dart';

//TODO Fix storing Auth Tokens in Flutter Seure Storage and Store Instead in HIVE
abstract class UserRepository {
  Future<UserEntity?> getUserDetails(UserEntity userEntity);
  Future<void> storeUserDetailsLocally(UserEntity userEntity);
  UserEntity? getLocalyStoredUserDetails(UserEntity userEntity);
  Future<UserEntity?> updateField(String field, dynamic data);
}

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource userRemoteDataSource;
  final UserLocalDataSource userLocalDataSource;
  final PremiumRemoteDataSource premiumRemoteDataSource;
  UserRepositoryImpl(
      {required this.userRemoteDataSource,
      required this.userLocalDataSource,
      required this.premiumRemoteDataSource});
  @override
  Future<UserEntity?> getUserDetails(UserEntity userEntity) async {
    UserEntity? user = await userRemoteDataSource.getUserDetails(userEntity);
    if (user != null) {
      SubcribtionDetailEntity? subcribtionDetailEntity =
          await premiumRemoteDataSource.getSubcribtionDetails(userEntity);
      user.subcribtionDetailsEntity = subcribtionDetailEntity;
      return user;
    }
    return null;
  }

  @override
  Future<void> storeUserDetailsLocally(UserEntity userEntity) {
    return userLocalDataSource.storeUserDetailsLocally(userEntity);
  }

  @override
  UserEntity? getLocalyStoredUserDetails(UserEntity userEntity) {
    return userLocalDataSource.getLocalyStoredUserDetails(userEntity);
  }

  @override
  Future<UserEntity?> updateField(String field, data) async {
    return await userLocalDataSource.updateField(field, data);
  }
}
