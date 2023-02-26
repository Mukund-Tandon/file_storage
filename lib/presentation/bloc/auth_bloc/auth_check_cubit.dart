import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../domain/entities/user_entity.dart';
import '../../../domain/usecases/authentication/auth_tokens_change_usecase.dart';
import '../../../domain/usecases/authentication/store_auth_tokens_usecase.dart';
import '../../../domain/usecases/user/get_locally_stored_user_details_usecase.dart';

part 'auth_check_state.dart';

class AuthCheckCubit extends Cubit<AuthCheckState> {
  final StoreAuthTokenUsecase storeAuthTokenUsecase;
  final AuthTokenChangeUseCase authTokenChangeUseCase;
  final GetLocalyStoredUserDetailsUsecase getLocalyStoredUserDetailsUsecase;
  AuthCheckCubit(
      {required this.storeAuthTokenUsecase,
      required this.authTokenChangeUseCase,
      required this.getLocalyStoredUserDetailsUsecase})
      : super(AuthCheckInitial());

  void checkIfAuthenticated() async {
    var user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      print('unauth');
      emit(UserUnAuthenticatedState());
    } else {
      print('unauth');
      emit(StoringAuthenticationDetailsState());
      String authToken = await user.getIdToken();
      await storeAuthTokenUsecase.call(authToken);
      authTokenChangeUseCase.call();
      var userentity = UserEntity(email: user.email!);
      userentity.authToken = authToken;
      userentity.uid = user.uid;
      UserEntity? curruser = getLocalyStoredUserDetailsUsecase.call(userentity);
      if (curruser == null) {
        print('unauth');
        emit(AuthenticationCheckErrorState());
      } else {
        print('unauth');
        print('UserEmail : ${user.email} Usertoken: ${userentity.authToken}');
        emit(UserAuthenticatedState(userEntity: curruser));
      }
    }
  }
}
