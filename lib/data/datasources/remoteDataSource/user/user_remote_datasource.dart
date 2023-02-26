import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:goal_lock/core/constants.dart';

import '../../../../domain/entities/user_entity.dart';

abstract class UserRemoteDataSource {
  Future<UserEntity?> getUserDetails(UserEntity userEntity);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final Dio dio;
  UserRemoteDataSourceImpl({required this.dio});
  @override
  Future<UserEntity?> getUserDetails(UserEntity userEntity) async {
    String url = "http://$ip:8000/get_user_data/${userEntity.email}";
    //TODO Implement When Live Server Is done
    try {
      var response = await dio.get(url,
          options: Options(
              headers: {'Authorization': 'Bearer ${userEntity.authToken}'}));
      print(response.data);
      print('done1');
      var responseData = response.data;
      print(responseData);
      Map data = responseData['user'];
      print('done2');
      userEntity.uid = data["uid"];
      print('done3');
      userEntity.premium = data["premium"];
      print('done4');
      userEntity.space = double.parse(data["used_space"]);
      print('done5');

      return userEntity;
    } catch (e) {
      print(e);
      return null;
    }
    // userEntity.uid = "udshdhuhdu12";
    // userEntity.premium = false;
    // userEntity.space = 0.000;
    // return userEntity;
  }
}
