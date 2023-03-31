part of 'drawer_animation_bloc.dart';

@immutable
abstract class DrawerAnimationState {}

class DrawerAnimationInitial extends DrawerAnimationState {}
class DrawerOpenState extends DrawerAnimationState{
double xOffset = 250;
double yoffset = 150;
double scalefactor = 0.7;
}
class DrawerCloseState extends DrawerAnimationState{
  double xOffset = 0;
  double yoffset = 0;
  double scalefactor = 1;

}