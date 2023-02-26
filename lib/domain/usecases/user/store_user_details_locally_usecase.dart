import 'package:goal_lock/data/repositories/user_repository.dart';
import 'package:goal_lock/domain/entities/user_entity.dart';

class StoreUserDetailsLocallyUsecase {
  final UserRepository userRepository;
  StoreUserDetailsLocallyUsecase({required this.userRepository});

  Future<void> call(UserEntity userEntity) async {
    await userRepository.storeUserDetailsLocally(userEntity);
  }
}
