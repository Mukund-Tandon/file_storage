part of 'user_entity_bloc.dart';

abstract class UserEntityState extends Equatable {
  const UserEntityState();
}

class UserEntityInitial extends UserEntityState {
  @override
  List<Object> get props => [];
}

class UserEntityChangedState extends UserEntityState {
  UserEntity userEntity;
  UserEntityChangedState({required this.userEntity});
  @override
  List<Object> get props => [userEntity];
}

class UserEntityLoadingState extends UserEntityState {
  @override
  List<Object> get props => [];
}
