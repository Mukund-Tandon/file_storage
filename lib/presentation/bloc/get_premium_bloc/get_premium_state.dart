part of 'get_premium_bloc.dart';

abstract class GetPremiumState extends Equatable {
  const GetPremiumState();
}

class GetPremiumInitialState extends GetPremiumState {
  @override
  List<Object> get props => [];
}

class PaymentStartedState extends GetPremiumState {
  String url;
  PaymentStartedState({required this.url});
  @override
  List<Object> get props => [url];
}

class PaymentCompletedState extends GetPremiumState {
  @override
  List<Object> get props => [];
}

class ErrorInPaymentState extends GetPremiumState {
  @override
  List<Object> get props => [];
}

class GetPremiumLoadingState extends GetPremiumState {
  @override
  List<Object> get props => [];
}
