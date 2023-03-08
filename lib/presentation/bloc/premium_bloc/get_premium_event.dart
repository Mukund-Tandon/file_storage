part of 'get_premium_bloc.dart';

abstract class GetPremiumEvent extends Equatable {
  const GetPremiumEvent();
}

class StartPaymentEvent extends GetPremiumEvent {
  UserEntity userEntity;
  StartPaymentEvent({required this.userEntity});
  @override
  List<Object?> get props => [userEntity];
}

class PaymentErrorEvent extends GetPremiumEvent {
  @override
  List<Object?> get props => [];
}

class PaymentCompleteEvent extends GetPremiumEvent {
  @override
  List<Object?> get props => [];
}

class PaymentDisplayLoadingEvent extends GetPremiumEvent {
  @override
  List<Object?> get props => [];
}

class PaymentDisplayWebViewEvent extends GetPremiumEvent {
  String url;
  PaymentDisplayWebViewEvent({required this.url});
  @override
  List<Object?> get props => [url];
}
