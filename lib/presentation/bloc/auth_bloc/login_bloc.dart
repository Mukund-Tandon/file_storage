import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:goal_lock/domain/entities/user_entity.dart';
import 'package:goal_lock/domain/usecases/user/get_user_details_from_server_usecase.dart';
import 'package:goal_lock/domain/usecases/user/store_user_details_locally_usecase.dart';

import '../../../domain/usecases/authentication/auth_tokens_change_usecase.dart';
import '../../../domain/usecases/authentication/store_auth_tokens_usecase.dart';
import '../../pages/mainpage.dart';
part 'login_event.dart';
part 'login_state.dart';

//TODO: make register bloc
//TODO when user who has premium logins it donot get premium data from server so get it from ser
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final StoreAuthTokenUsecase storeAuthTokenUsecase;
  final AuthTokenChangeUseCase authTokenChangeUseCase;
  final GetuserDetailsFromServerUsecase getuserDetailsFromServerUsecase;
  final StoreUserDetailsLocallyUsecase storeUserDetailsLocallyUsecase;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  LoginBloc(
      {required this.authTokenChangeUseCase,
      required this.storeAuthTokenUsecase,
      required this.getuserDetailsFromServerUsecase,
      required this.storeUserDetailsLocallyUsecase})
      : super(LoginInitial()) {
    on<StartLoginEvent>((event, emit) async {
      emit(LoginStartedState());
      print('ooo');
      try {
        if (event.password != '' && event.email != '') {
          print('${event.email}');
          final credential = await _auth.signInWithEmailAndPassword(
            email: event.email,
            password: event.password,
          );
          print('ooo');
          print('done auth $credential');
          var userEntity = UserEntity(email: credential.user!.email!);
          String authToken = await _auth.currentUser!.getIdToken();
          userEntity.uid = credential.user!.uid;
          //TODO Figure how auth token will hange user Entity
          userEntity.authToken = authToken;
          // await storeAuthTokenUsecase.call(authToken);
          // authTokenChangeUseCase.call();
          print('Auth token sorted');
          //TODO: gfet user details retutning incomplete value for authtoken so use user entity
          UserEntity? user =
              await getuserDetailsFromServerUsecase.call(userEntity);
          print(user?.premium);
          authToken = await _auth.currentUser!.getIdToken();
          user?.authToken = authToken;
          user?.uid = credential.user!.uid;
          if (user != null) {
            print('Got user details ${user}');

            await storeUserDetailsLocallyUsecase.call(user);
            print('User details stored');
            emit(LoginInitial());
            Navigator.pushAndRemoveUntil(
                event.context,
                MaterialPageRoute(
                    builder: (context) => Mainpage(
                          userEntity: user,
                        )),
                (route) => false);
          }
        } else {
          //TODO Fix validator error for failsed to get details of user from user
          emit(LoginErrorState(validator: 3));
        }
      } on FirebaseAuthException catch (e) {
        // setState(() {
        //   loading = false;
        //   validator = 0;
        // });
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
          emit(LoginErrorState(validator: 1));
        } else if (e.code == 'invalid-email') {
          emit(LoginErrorState(validator: 2));
        } else if (e.code == 'user-not-found') {
          emit(LoginErrorState(validator: 3));
        }
      } catch (e) {
        print(e);
      }
    });
  }
}
