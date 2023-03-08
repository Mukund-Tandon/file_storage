part of 'cancel_subcribtion_bloc.dart';

abstract class CancelSubcribtionEvent extends Equatable {
  const CancelSubcribtionEvent();
}

class CancelSubcribtionStartEvent extends CancelSubcribtionEvent {
  UserEntity userEntity;
  CancelSubcribtionStartEvent({required this.userEntity});
  @override
  List<Object?> get props => [userEntity];
}

class CancelSubcribtionloadingEvent extends CancelSubcribtionEvent {
  @override
  List<Object?> get props => [];
}

class CancelSubcribtionFinishedEvent extends CancelSubcribtionEvent {
  UserEntity userEntity;
  CancelSubcribtionFinishedEvent({required this.userEntity});
  @override
  List<Object?> get props => [userEntity];
}
