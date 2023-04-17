import 'package:goal_lock/data/datasources/remoteDataSource/premium/premium_remote_data_source.dart';
import 'package:goal_lock/domain/entities/payment_websocket_entity.dart';
import 'package:goal_lock/domain/entities/subscribtion_details_entity.dart';
import 'package:goal_lock/domain/entities/user_entity.dart';

import '../datasources/localDataSource/user/user_local_datasource.dart';

//TODO Change spelling of subsciption
abstract class PremiumSubscribtionRepository {
  Stream<PaymentWebSocketEntity>? connectToPaymentWebsocket();
  Future<void> storeSubcribtionDetails(UserEntity userEntity);
  Future<SubcribtionDetailEntity?> cancelSubcribtion(UserEntity userEntity);
}

class PremiumSubcribtionRepositoryImpl
    implements PremiumSubscribtionRepository {
  final PremiumRemoteDataSource premiumRemoteDataSource;
  final UserLocalDataSource userLocalDataSource;
  PremiumSubcribtionRepositoryImpl(
      {required this.premiumRemoteDataSource,
      required this.userLocalDataSource});
  @override
  Stream<PaymentWebSocketEntity>? connectToPaymentWebsocket() {
    return premiumRemoteDataSource.connectToPaymentWebsocket();
  }

  @override
  Future<void> storeSubcribtionDetails(UserEntity userEntity) async {
    SubcribtionDetailEntity? subcribtionDetailEntity =
        await premiumRemoteDataSource.getSubcribtionDetails(userEntity);
    if (subcribtionDetailEntity != null) {
      await userLocalDataSource
          .storeSubcribtionDetailsLocally(subcribtionDetailEntity);
    } else {
      print('setting premium false');
      await userLocalDataSource.updateField('premium', false);
    }
  }

  @override
  Future<SubcribtionDetailEntity?> cancelSubcribtion(
      UserEntity userEntity) async {
    return await premiumRemoteDataSource.cancelSubcribtion(userEntity);
  }
}
