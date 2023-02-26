import 'package:goal_lock/data/datasources/remoteDataSource/premium/premium_remote_data_source.dart';
import 'package:goal_lock/domain/entities/payment_websocket_entity.dart';

abstract class PremiumSubscribtionRepository {
  Stream<PaymentWebSocketEntity>? connectToPaymentWebsocket();
}

class PremiumSubcribtionRepositoryImpl
    implements PremiumSubscribtionRepository {
  final PremiumRemoteDataSource premiumRemoteDataSource;
  PremiumSubcribtionRepositoryImpl({required this.premiumRemoteDataSource});
  @override
  Stream<PaymentWebSocketEntity>? connectToPaymentWebsocket() {
    return premiumRemoteDataSource.connectToPaymentWebsocket();
  }
}
