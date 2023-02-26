import 'package:goal_lock/data/repositories/user_repository.dart';

import '../../entities/user_entity.dart';

class GetLocalyStoredUserDetailsUsecase {
  final UserRepository userRepository;
  GetLocalyStoredUserDetailsUsecase({required this.userRepository});
  UserEntity? call(UserEntity userEntity) {
    return userRepository.getLocalyStoredUserDetails(userEntity);
  }
}
