import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'space_event.dart';
part 'space_state.dart';

class SpaceBloc extends Bloc<SpaceEvent, SpaceState> {
  SpaceBloc() : super(SpaceInitial()) {
    on<SpaceEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
