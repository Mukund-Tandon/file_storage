import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../core/constants.dart';

part 'drawer_animation_event.dart';
part 'drawer_animation_state.dart';

//TODO Fix this bloc just look at it It is Old
class DrawerAnimationBloc
    extends Bloc<DrawerAnimationEvent, DrawerAnimationState> {
  DrawerAnimationBloc() : super(DrawerAnimationInitial()) {
    on<DrawerOpenCloseEvent>(_OpenCloseDrawer);
  }
  void _OpenCloseDrawer(DrawerOpenCloseEvent drawerOpenCloseEvent,
      Emitter<DrawerAnimationState> emit) {
    if (drawerOpenCloseEvent.openClose == OpenClose.open) {
      emit(DrawerOpenState());
    } else {
      emit(DrawerCloseState());
    }
  }
}
