import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:goal_lock/domain/entities/user_entity.dart';

import '../../../domain/usecases/authentication/auth_tokens_change_usecase.dart';
import '../../../domain/usecases/authentication/store_auth_tokens_usecase.dart';
import '../../../domain/usecases/user/get_locally_stored_user_details_usecase.dart';

part 'user_entity_event.dart';
part 'user_entity_state.dart';

class UserEntityBloc extends Bloc<UserEntityEvent, UserEntityState> {
  final StoreAuthTokenUsecase storeAuthTokenUsecase;
  final AuthTokenChangeUseCase authTokenChangeUseCase;
  final GetLocalyStoredUserDetailsUsecase getLocalyStoredUserDetailsUsecase;
  UserEntityBloc(
      {required this.authTokenChangeUseCase,
      required this.storeAuthTokenUsecase,
      required this.getLocalyStoredUserDetailsUsecase})
      : super(UserEntityInitial()) {
    on<UserEntityStateChangeEvent>((event, emit) {
      emit(UserEntityChangedState(userEntity: event.userEntity));
    });
    on<UserEntityLoadingStateEvent>((event, emit) {
      emit(UserEntityLoadingState());
    });
    on<SubcribeToAuthTokenChangeEvent>((event, emit) {
      authTokenChangeUseCase.call().listen((user) async {
        if (user != null) {
          String newAuthToken = await user.getIdToken();
          await storeAuthTokenUsecase.call(newAuthToken);
          event.userEntity.authToken = newAuthToken;
          add(UserEntityStateChangeEvent(userEntity: event.userEntity));
        }
      });
    });
    on<UserEntityChangeEvent>((event, emit) {
      print('user entity changes');
      add(UserEntityLoadingStateEvent());
      UserEntity? user =
          getLocalyStoredUserDetailsUsecase.call(event.userEntity);

      print(user?.premium);
      add(UserEntityStateChangeEvent(userEntity: user!));
    });
  }
}
