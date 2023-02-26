part of 'space_bloc.dart';

abstract class SpaceState extends Equatable {
  const SpaceState();
}

class SpaceInitial extends SpaceState {
  @override
  List<Object> get props => [];
}

class DataLoading extends SpaceState {
  @override
  List<Object> get props => [];
}

class DataLoaded extends SpaceState {
  @override
  List<Object> get props => [];
}
