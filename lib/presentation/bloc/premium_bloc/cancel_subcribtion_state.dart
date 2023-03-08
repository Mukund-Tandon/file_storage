part of 'cancel_subcribtion_bloc.dart';

abstract class CancelSubcribtionState extends Equatable {
  const CancelSubcribtionState();
}

class CancelSubcribtionInitial extends CancelSubcribtionState {
  @override
  List<Object> get props => [];
}

class CancelSubcribtionLoadingState extends CancelSubcribtionState {
  @override
  List<Object> get props => [];
}

class CancelSubcribtionFinishedState extends CancelSubcribtionState {
  UserEntity userEntity;
  CancelSubcribtionFinishedState({required this.userEntity});
  @override
  List<Object> get props => [userEntity];
}
