import 'package:goal_lock/data/repositories/authentication_repository.dart';

class StoreAuthTokenUsecase {
  final AuthenticationRepository authenticationRepository;
  StoreAuthTokenUsecase({required this.authenticationRepository});

  Future<void> call(String authToken) async {
    await authenticationRepository.storeAuthToken(authToken);
  }
}
