import 'package:goal_lock/data/repositories/premium_subcribtion_repository.dart';

import '../../entities/payment_websocket_entity.dart';

class ConnectToPaymtWebsocket {
  final PremiumSubscribtionRepository premiumSubscribtionRepository;
  ConnectToPaymtWebsocket({required this.premiumSubscribtionRepository});
  Stream<PaymentWebSocketEntity>? call() {
    return premiumSubscribtionRepository.connectToPaymentWebsocket();
  }
}
