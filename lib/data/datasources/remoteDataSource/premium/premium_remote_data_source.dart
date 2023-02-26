import 'dart:async';
import 'dart:convert';

import 'package:web_socket_channel/web_socket_channel.dart';

import '../../../../core/constants.dart';
import '../../../../domain/entities/payment_websocket_entity.dart';

abstract class PremiumRemoteDataSource {
  Stream<PaymentWebSocketEntity>? connectToPaymentWebsocket();
}

class PremiumRemoteDataSourceImpl implements PremiumRemoteDataSource {
  final _controller = StreamController<PaymentWebSocketEntity>.broadcast();
  @override
  Stream<PaymentWebSocketEntity>? connectToPaymentWebsocket() {
    try {
      listenToWebSocket();
      return _controller.stream;
    } catch (e) {
      print(e);
      return null;
    }
  }

  listenToWebSocket() {
    final channel = WebSocketChannel.connect(
      Uri.parse('ws://$ip:8000/ws/checkout/'),
    ).stream.listen((event) {
      print(event);
      var paymentEvent = PaymentWebSocketEntity.fromJson(jsonDecode(event));
      _controller.sink.add(paymentEvent);
    });
  }
}
