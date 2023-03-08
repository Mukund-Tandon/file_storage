import 'package:goal_lock/data/repositories/premium_subcribtion_repository.dart';

import '../../entities/subscribtion_details_entity.dart';
import '../../entities/user_entity.dart';

class CancelSubcribtionUsecase {
  final PremiumSubscribtionRepository premiumSubscribtionRepository;
  CancelSubcribtionUsecase({required this.premiumSubscribtionRepository});

  Future<SubcribtionDetailEntity?> call(UserEntity userEntity) async {
    return await premiumSubscribtionRepository.cancelSubcribtion(userEntity);
  }
}
