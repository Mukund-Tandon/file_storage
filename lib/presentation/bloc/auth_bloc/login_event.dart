part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class StartLoginEvent implements LoginEvent {
  String email;
  String password;
  BuildContext context;
  StartLoginEvent(
      {required this.email, required this.password, required this.context});
  @override
  List<Object?> get props => [email, password, context];

  @override
  bool? get stringify => false;
}
