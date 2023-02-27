part of 'user_entity_bloc.dart';

abstract class UserEntityEvent extends Equatable {
  const UserEntityEvent();
}

class SubcribeToAuthTokenChangeEvent extends UserEntityEvent {
  UserEntity userEntity;
  SubcribeToAuthTokenChangeEvent({required this.userEntity});
  @override
  // TODO: implement props
  List<Object?> get props => [userEntity];
}

class UserEntityChangeEvent extends UserEntityEvent {
  UserEntity userEntity;
  UserEntityChangeEvent({required this.userEntity});
  @override
  // TODO: implement props
  List<Object?> get props => [userEntity];
}

class UserEntityStateChangeEvent extends UserEntityEvent {
  UserEntity userEntity;
  UserEntityStateChangeEvent({required this.userEntity});
  @override
  // TODO: implement props
  List<Object?> get props => [userEntity];
}

class UserEntityLoadingStateEvent extends UserEntityEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
