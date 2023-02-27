import 'package:goal_lock/data/repositories/premium_subcribtion_repository.dart';
import 'package:goal_lock/domain/entities/user_entity.dart';

class StoreSubcribtionDetails {
  final PremiumSubscribtionRepository premiumSubscribtionRepository;
  StoreSubcribtionDetails({required this.premiumSubscribtionRepository});
  Future<void> call(UserEntity userEntity) async {
    await premiumSubscribtionRepository.storeSubcribtionDetails(userEntity);
  }
}
