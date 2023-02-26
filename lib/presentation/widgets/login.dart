import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goal_lock/domain/entities/user_entity.dart';
import 'package:goal_lock/presentation/bloc/auth_bloc/login_bloc.dart';
import 'package:goal_lock/presentation/pages/mainpage.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({Key? key}) : super(key: key);

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  String _email = '';
  String _password = '';
  int validator = 0;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        if (state is LoginStartedState) {
          loading = true;
          validator = 0;
        } else if (state is LoginErrorState) {
          loading = false;
          validator = state.validator;
        }

        return Container(
          height: 350,
          width: 300,
          decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: const BorderRadius.all(
                Radius.circular(25),
              ),
              border: Border.all(color: const Color(0xffEEEDF0))),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(),
                const Text(
                  'Sign In',
                  style: TextStyle(
                      color: Color(0xffEEEDF0),
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
                Spacer(),
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Color(0xffEEEDF0)),
                  onChanged: (value) {
                    _email = value;
                    //Do something with the user input.
                  },
                  decoration: InputDecoration(
                    hintText: 'Enter your Email.',
                    labelText: 'Email',
                    labelStyle: const TextStyle(color: Color(0xffEEEDF0)),
                    hintStyle: TextStyle(color: Colors.grey.withOpacity(0.4)),
                    errorText: validator == 0
                        ? null
                        : validator == 1
                            ? 'Email Already in Use'
                            : validator == 2
                                ? 'Invalid Email'
                                : "User with this email doesn't exist",
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 20.0),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xff8B8B8B), width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xffEEEDF0), width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 18.0,
                ),
                TextField(
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  style: TextStyle(color: Color(0xffEEEDF0)),
                  onChanged: (value) {
                    _password = value;
                    // //Do something with the user input.
                  },
                  decoration: InputDecoration(
                    hintText: 'Enter your password.',
                    labelText: 'Password',
                    labelStyle: const TextStyle(color: Color(0xffEEEDF0)),
                    hintStyle: TextStyle(color: Colors.grey.withOpacity(0.4)),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 20.0),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xff8B8B8B), width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xffEEEDF0), width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextButton(
                  onPressed: () async {
                    // await _doLoginWork(context);
                    //TODO Fix Login errror by trying to call it using usecase
                    // context.read<LoginBloc>().emit(LoginStartedState());

                    context.read<LoginBloc>().add(StartLoginEvent(
                        email: _email, password: _password, context: context));
                  },
                  child: Container(
                    height: 40,
                    width: 100,
                    decoration: BoxDecoration(
                        color: const Color(0xffEEEDF0).withOpacity(0.15),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(20),
                        ),
                        border: Border.all(color: const Color(0xffEEEDF0))),
                    child: Center(
                      child: loading
                          ? CircularProgressIndicator(
                              color: Color(0xffEEEDF0),
                            )
                          : Text(
                              'Continue',
                              style: TextStyle(color: Color(0xffEEEDF0)),
                            ),
                    ),
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
        );
      },
    );
  }

  _doLoginWork(BuildContext context) async {
    try {
      setState(() {
        loading = true;
        validator = 0;
      });
      if (_password != '' && _email != '') {
        final credential = await _auth.signInWithEmailAndPassword(
          email: _email,
          password: _password,
        );
        var userEntity = UserEntity(email: credential.user!.email!);
        userEntity.authToken = await credential.user!.getIdToken();
        //TODO save auth tokens andsubsribe to authtokenvhanges stream DO THIS USING BLOC

        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => Mainpage(
                      userEntity: userEntity,
                    )),
            (route) => false);
      }
      //TODO: use state management for animation
      setState(() {
        loading = false;
        validator = 0;
      });
    } on FirebaseAuthException catch (e) {
      setState(() {
        loading = false;
        validator = 0;
      });
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        setState(() {
          loading = false;
          validator = 1;
        });
      } else if (e.code == 'invalid-email') {
        setState(() {
          loading = false;
          validator = 2;
        });
      } else if (e.code == 'user-not-found') {
        setState(() {
          loading = false;
          validator = 3;
        });
      }
    } catch (e) {
      print(e);
    }
  }
}
