import 'package:goal_lock/data/repositories/authentication_repository.dart';

class GetStoredAuthTokenUsecase {
  final AuthenticationRepository authenticationRepository;
  GetStoredAuthTokenUsecase({required this.authenticationRepository});

  Future<String?> call() async {
    return await authenticationRepository.getAuthToken();
  }
}
