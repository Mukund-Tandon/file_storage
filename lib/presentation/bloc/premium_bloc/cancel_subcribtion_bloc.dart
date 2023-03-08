import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:goal_lock/domain/entities/subscribtion_details_entity.dart';
import 'package:goal_lock/domain/entities/user_entity.dart';
import 'package:goal_lock/domain/usecases/premium/cancel_subcribtion_usecase.dart';
import 'package:goal_lock/domain/usecases/user/update_user_field_usecase.dart';

part 'cancel_subcribtion_event.dart';
part 'cancel_subcribtion_state.dart';

class CancelSubcribtionBloc
    extends Bloc<CancelSubcribtionEvent, CancelSubcribtionState> {
  final CancelSubcribtionUsecase cancelSubcribtionUsecase;
  final UpdateUserFieldUsecase updateUserFieldUsecase;
  CancelSubcribtionBloc(
      {required this.updateUserFieldUsecase,
      required this.cancelSubcribtionUsecase})
      : super(CancelSubcribtionInitial()) {
    //TODO handel error state if subcriptionDetail entity is empty
    on<CancelSubcribtionloadingEvent>((event, emit) {
      emit(CancelSubcribtionLoadingState());
    });
    on<CancelSubcribtionFinishedEvent>((event, emit) {
      emit(CancelSubcribtionFinishedState(userEntity: event.userEntity));
    });
    on<CancelSubcribtionStartEvent>((event, emit) async {
      add(CancelSubcribtionloadingEvent());
      SubcribtionDetailEntity? subcribtionDetailEntityAfterCancellation =
          await cancelSubcribtionUsecase.call(event.userEntity);
      if (subcribtionDetailEntityAfterCancellation == null) {
        //TODO handel error state if subcriptionDetail entity is empty
      } else {
        await updateUserFieldUsecase.call('cancelled', true);
        add(CancelSubcribtionFinishedEvent(userEntity: event.userEntity));
      }
    });
  }
}
