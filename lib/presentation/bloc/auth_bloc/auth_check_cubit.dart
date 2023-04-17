import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../domain/entities/user_entity.dart';
import '../../../domain/usecases/authentication/auth_tokens_change_usecase.dart';
import '../../../domain/usecases/authentication/store_auth_tokens_usecase.dart';
import '../../../domain/usecases/premium/store_subcribtion_details.dart';
import '../../../domain/usecases/user/get_locally_stored_user_details_usecase.dart';

part 'auth_check_state.dart';

class AuthCheckCubit extends Cubit<AuthCheckState> {
  final StoreAuthTokenUsecase storeAuthTokenUsecase;
  final AuthTokenChangeUseCase authTokenChangeUseCase;
  final GetLocalyStoredUserDetailsUsecase getLocalyStoredUserDetailsUsecase;
  final StoreSubcribtionDetails storeSubcribtionDetails;
  AuthCheckCubit(
      {required this.storeAuthTokenUsecase,
      required this.authTokenChangeUseCase,
      required this.getLocalyStoredUserDetailsUsecase,
      required this.storeSubcribtionDetails})
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
      // authTokenChangeUseCase.call();
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

        if (curruser.premium &&
            DateTime.fromMillisecondsSinceEpoch(
                    int.parse(curruser.subcribtionDetailsEntity!.endTime) *
                        1000)
                .isBefore(DateTime.now())) {
          //this would be called when the endtime of premium is over
          await storeSubcribtionDetails.call(curruser);
          curruser = getLocalyStoredUserDetailsUsecase.call(userentity);
        }
        emit(UserAuthenticatedState(userEntity: curruser!));
      }
    }
  }
}
