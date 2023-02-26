part of 'auth_check_cubit.dart';

abstract class AuthCheckState extends Equatable {
  const AuthCheckState();
}

class AuthCheckInitial extends AuthCheckState {
  @override
  List<Object> get props => [];
}

class UserAuthenticatedState extends AuthCheckState {
  final UserEntity userEntity;
  UserAuthenticatedState({required this.userEntity});
  @override
  List<Object> get props => [userEntity];
}

class UserUnAuthenticatedState extends AuthCheckState {
  @override
  List<Object> get props => [];
}

class AuthenticationCheckErrorState extends AuthCheckState {
  @override
  List<Object> get props => [];
}

class StoringAuthenticationDetailsState extends AuthCheckState {
  @override
  List<Object> get props => [];
}
