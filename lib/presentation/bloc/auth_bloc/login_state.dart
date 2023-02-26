part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();
}

class LoginInitial extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginStartedState extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginDoneState extends LoginState {
  final UserEntity userEntity;
  LoginDoneState({required this.userEntity});
  @override
  List<Object> get props => [userEntity];
}

class LoginErrorState extends LoginState {
  int validator;
  LoginErrorState({required this.validator});
  @override
  List<Object> get props => [validator];
}
