part of 'drawer_animation_bloc.dart';

@immutable
abstract class DrawerAnimationEvent {}
class DrawerOpenCloseEvent extends DrawerAnimationEvent{
  OpenClose openClose;
  DrawerOpenCloseEvent({required this.openClose});
}