import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:goal_lock/domain/entities/user_entity.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../../../core/constants.dart';
import '../../../../domain/entities/payment_websocket_entity.dart';
import '../../../../domain/entities/subscribtion_details_entity.dart';

abstract class PremiumRemoteDataSource {
  Stream<PaymentWebSocketEntity>? connectToPaymentWebsocket();
  Future<SubcribtionDetailEntity?> getSubcribtionDetails(UserEntity userEntity);
  Future<SubcribtionDetailEntity?> cancelSubcribtion(UserEntity userEntity);
}

class PremiumRemoteDataSourceImpl implements PremiumRemoteDataSource {
  final Dio dio;
  final _controller = StreamController<PaymentWebSocketEntity>.broadcast();
  PremiumRemoteDataSourceImpl({required this.dio});
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

  @override
  Future<SubcribtionDetailEntity?> getSubcribtionDetails(
      UserEntity userEntity) async {
    String url = "http://$ip:8000/subcribtion_details/${userEntity.uid}";
    try {
      var response = await dio.get(url,
          options: Options(
              headers: {'Authorization': 'Bearer ${userEntity.authToken}'}));
      print(response.data);
      if (!response.data['subcribtion_status']) {
        return null;
      }
      return SubcribtionDetailEntity.fromJson(
          response.data['subcribtion_details']);
    } catch (e) {
      print('error');
      return null;
    }
  }

  @override
  Future<SubcribtionDetailEntity?> cancelSubcribtion(
      UserEntity userEntity) async {
    String url = "http://$ip:8000/cancel_subcribtion/${userEntity.uid}";

    try {
      var response = await dio.post(url,
          options: Options(
              headers: {'Authorization': 'Bearer ${userEntity.authToken}'}));
      print(response.data);
      if (!response.data['subcribtion_status']) {
        return null;
      }
      return SubcribtionDetailEntity.fromJson(
          response.data['subcribtion_details']);
    } catch (e) {
      print(e);
      return null;
    }
  }
}
