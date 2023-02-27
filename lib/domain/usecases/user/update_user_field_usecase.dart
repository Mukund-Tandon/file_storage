import 'package:goal_lock/data/repositories/user_repository.dart';

import '../../entities/user_entity.dart';

class UpdateUserFieldUsecase {
  final UserRepository userRepository;
  UpdateUserFieldUsecase({required this.userRepository});
  Future<UserEntity?> call(String field, dynamic value) async {
    return await userRepository.updateField(field, value);
  }
}
