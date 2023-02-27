import 'package:firebase_auth/firebase_auth.dart';
import 'package:goal_lock/data/repositories/authentication_repository.dart';

class AuthTokenChangeUseCase {
  final AuthenticationRepository authenticationRepository;

  AuthTokenChangeUseCase({required this.authenticationRepository});

  Stream<User?> call() {
    return authenticationRepository.authTokenChangesStream();
    // authenticationRepository.authTokenChangesStream().listen((user) async {
    //   if (user != null) {
    //     String newAuthToken = await user.getIdToken();
    //     await authenticationRepository.storeAuthToken(newAuthToken);
    //   }
    // });
  }
}
