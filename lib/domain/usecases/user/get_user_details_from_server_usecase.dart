import 'package:goal_lock/data/repositories/user_repository.dart';

import '../../entities/user_entity.dart';

class GetuserDetailsFromServerUsecase {
  final UserRepository userRepository;
  GetuserDetailsFromServerUsecase({required this.userRepository});

  Future<UserEntity?> call(UserEntity userEntity) {
    return userRepository.getUserDetails(userEntity);
  }
}
