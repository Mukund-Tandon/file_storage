import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/user_entity.dart';
import '../pages/mainpage.dart';

class RegisterWidget extends StatefulWidget {
  const RegisterWidget({Key? key}) : super(key: key);

  @override
  State<RegisterWidget> createState() => _RegisterWidgetState();
}

class _RegisterWidgetState extends State<RegisterWidget> {
  String _email = '';
  String _password = '';
  String _confirmPassword = '';
  int validator = 0;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 450,
      width: 300,
      decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: const BorderRadius.all(
            Radius.circular(25),
          ),
          border: Border.all(color: const Color(0xffEEEDF0))),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            const Text(
              'Register',
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
                            : null,
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 20.0),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff8B8B8B), width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xffEEEDF0), width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                ),
              ),
            ),
            const SizedBox(
              height: 18.0,
            ),
            TextField(
              style: TextStyle(color: Color(0xffEEEDF0)),
              textAlign: TextAlign.center,
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
              onChanged: (value) {
                _password = value;
                // //Do something with the user input.
              },
              decoration: InputDecoration(
                hintText: 'Enter your password.',
                labelText: 'Password',
                errorText: validator == 3 ? 'Weak password' : null,
                labelStyle: const TextStyle(color: Color(0xffEEEDF0)),
                hintStyle: TextStyle(color: Colors.grey.withOpacity(0.4)),
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 20.0),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff8B8B8B), width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xffEEEDF0), width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            TextField(
              style: TextStyle(color: Color(0xffEEEDF0)),
              textAlign: TextAlign.center,
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
              onChanged: (value) {
                _confirmPassword = value;
                // //Do something with the user input.
              },
              decoration: InputDecoration(
                hintText: 'Re-Enter your password.',
                labelText: 'Confirm Password',
                errorText: validator == 4 ? 'Password Not matching' : null,
                labelStyle: const TextStyle(color: Color(0xffEEEDF0)),
                hintStyle: TextStyle(color: Colors.grey.withOpacity(0.4)),
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 20.0),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff8B8B8B), width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xffEEEDF0), width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                ),
              ),
            ),
            TextButton(
              onPressed: () async {
                try {
                  setState(() {
                    loading = true;
                    validator = 0;
                  });
                  if (_password == _confirmPassword &&
                      _password != '' &&
                      _email != '') {
                    final credential =
                        await _auth.createUserWithEmailAndPassword(
                      email: _email,
                      password: _password,
                    );
                    var userEntity = UserEntity(email: credential.user!.email!);
                    userEntity.uid = credential.user!.uid;
                    userEntity.authToken = await credential.user!.getIdToken();

                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Mainpage(
                                  userEntity: userEntity,
                                )),
                        (route) => false);
                    setState(() {
                      loading = false;
                      validator = 0;
                    });
                  } else {
                    if (_password != _confirmPassword) {
                      setState(() {
                        loading = false;
                        validator = 4;
                      });
                    } else {
                      setState(() {
                        loading = false;
                        validator = 0;
                      });
                    }
                  }
                } on FirebaseAuthException catch (e) {
                  setState(() {
                    loading = false;
                    validator = 0;
                  });
                  if (e.code == 'weak-password') {
                    print('The password provided is too weak.');
                    setState(() {
                      loading = false;

                      validator = 3;
                    });
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
                  }
                } catch (e) {
                  print(e);
                }
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
                      ? const CircularProgressIndicator(
                          color: Color(0xffEEEDF0),
                        )
                      : const Text(
                          'Continue',
                          style: TextStyle(color: Color(0xffEEEDF0)),
                        ),
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
