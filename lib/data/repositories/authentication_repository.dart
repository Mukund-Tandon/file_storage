import 'package:firebase_auth/firebase_auth.dart';
import 'package:goal_lock/data/datasources/localDataSource/authenticatiion/authentication_local_data_source.dart';

import '../datasources/remoteDataSource/authentication/authentication_remote_data_source.dart';

abstract class AuthenticationRepository {
  Future<void> storeAuthToken(String authToken);
  Future<String?> getAuthToken();
  Stream<User?> authTokenChangesStream();
}

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final AuthenticationLocalDataSource authenticationLocalDataSource;
  final AuthenticationRemoteDataSource authenticationRemoteDataSource;
  AuthenticationRepositoryImpl(
      {required this.authenticationLocalDataSource,
      required this.authenticationRemoteDataSource});
  @override
  Future<String?> getAuthToken() async {
    return await authenticationLocalDataSource.getAuthToken();
  }

  @override
  Future<void> storeAuthToken(String authToken) async {
    await authenticationLocalDataSource.storeAuthToken(authToken);
  }

  @override
  Stream<User?> authTokenChangesStream() {
    return authenticationRemoteDataSource.authTokenChangesStream();
  }
}
