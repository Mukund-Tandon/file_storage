import 'dart:ui';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class AuthenticationLocalDataSource {
  Future<void> storeAuthToken(String authToken);
  Future<String?> getAuthToken();
}

class AuthenticationLocalDataSourceImpl
    implements AuthenticationLocalDataSource {
  final FlutterSecureStorage storage;
  AuthenticationLocalDataSourceImpl({required this.storage});

  @override
  Future<String?> getAuthToken() async {
    String? authToken = await storage.read(key: 'authToken');
    return authToken;
  }

  @override
  Future<void> storeAuthToken(String authToken) async {
    await storage.write(key: 'authToken', value: authToken);
  }
}
