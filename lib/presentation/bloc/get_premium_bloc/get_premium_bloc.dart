import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:goal_lock/core/constants.dart';
import 'package:goal_lock/domain/entities/payment_websocket_entity.dart';
import 'package:goal_lock/domain/entities/user_entity.dart';

import '../../../domain/usecases/premium/connect_to_payment_websocket.dart';

part 'get_premium_event.dart';
part 'get_premium_state.dart';

class GetPremiumBloc extends Bloc<GetPremiumEvent, GetPremiumState> {
  final ConnectToPaymtWebsocket connectToPaymtWebsocket;
  GetPremiumBloc({required this.connectToPaymtWebsocket})
      : super(GetPremiumInitialState()) {
    on<PaymentDisplayLoadingEvent>((event, emit) {
      emit(GetPremiumLoadingState());
    });
    on<PaymentCompleteEvent>((event, emit) {
      emit(PaymentCompletedState());
    });
    on<PaymentErrorEvent>((event, emit) {
      emit(GetPremiumInitialState());
    });
    on<PaymentDisplayWebViewEvent>((event, emit) {
      emit(PaymentStartedState(url: event.url));
    });
    on<StartPaymentEvent>((event, emit) async {
      print('done');
      add(PaymentDisplayLoadingEvent());
      print('done');
      Stream<PaymentWebSocketEntity>? stream =
          await connectToPaymtWebsocket.call();
      print('done');
      if (stream == null) {
        print('done');
        add(PaymentErrorEvent());
        print('done');
      } else {
        print('done');
        String url = 'http://$ip:8000/stripe_home/';
        url = url + event.userEntity.uid;
        stream.listen((event) {
          print('event ====== ${event.paymentStatus}');
          if (event.paymentStatus == PaymentStatus.connected) {
            add(PaymentDisplayWebViewEvent(url: url));
          } else if (event.paymentStatus == PaymentStatus.completed) {
            add(PaymentCompleteEvent());
          } else {
            add(PaymentErrorEvent());
          }
        });
      }
    });
  }
}
