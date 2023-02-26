import 'package:firebase_auth/firebase_auth.dart';
import 'package:goal_lock/data/repositories/user_repository.dart';

class UserLoginUsecase {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserCredential> call(String email, String password) async {
    return await _auth.signInWithEmailAndPassword(
      email: email,
      password: email,
    );
  }
}
