import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthenticationRemoteDataSource {
  Stream<User?> authTokenChangesStream();
}

class AuthenticationRemoteDataSourceImpl
    implements AuthenticationRemoteDataSource {
  final _auth = FirebaseAuth.instance;
  final _userStremController = StreamController<User?>.broadcast();
  @override
  Stream<User?> authTokenChangesStream() {
    _startReceivingAuthTokenChanges();
    return _userStremController.stream;
  }

  _startReceivingAuthTokenChanges() {
    _auth.idTokenChanges().listen((event) {
      _userStremController.sink.add(event);
    });
  }
}
