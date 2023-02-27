import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:goal_lock/core/constants.dart';
import 'package:goal_lock/domain/entities/payment_websocket_entity.dart';
import 'package:goal_lock/domain/entities/user_entity.dart';

import '../../../domain/usecases/premium/connect_to_payment_websocket.dart';
import '../../../domain/usecases/premium/store_subcribtion_details.dart';
import '../../../domain/usecases/user/update_user_field_usecase.dart';

part 'get_premium_event.dart';
part 'get_premium_state.dart';

class GetPremiumBloc extends Bloc<GetPremiumEvent, GetPremiumState> {
  final ConnectToPaymtWebsocket connectToPaymtWebsocket;
  final StoreSubcribtionDetails storeSubcribtionDetails;
  final UpdateUserFieldUsecase updateUserFieldUsecase;
  GetPremiumBloc(
      {required this.connectToPaymtWebsocket,
      required this.storeSubcribtionDetails,
      required this.updateUserFieldUsecase})
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
        stream.listen((e) async {
          print('event ====== ${e.paymentStatus}');
          if (e.paymentStatus == PaymentStatus.connected) {
            add(PaymentDisplayWebViewEvent(url: url));
          } else if (e.paymentStatus == PaymentStatus.completed) {
            add(PaymentDisplayLoadingEvent());
            await storeSubcribtionDetails.call(event.userEntity);
            event.userEntity.premium = true;
            await updateUserFieldUsecase.call('premium', true);
            add(PaymentCompleteEvent());
          } else {
            add(PaymentErrorEvent());
          }
        });
      }
    });
  }
}
