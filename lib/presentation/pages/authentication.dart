import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../widgets/login.dart';
import '../widgets/registration.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({Key? key}) : super(key: key);

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  int screen = 1;
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
          statusBarColor: Color(0xff17181F),
          systemNavigationBarColor: Color(0xff17181F)),
      child: Scaffold(
        backgroundColor: const Color(0xff17181F),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            Center(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child:
                    screen == 1 ? const LoginWidget() : const RegisterWidget(),
              ),
            ),
            Expanded(
              child: Align(
                alignment: FractionalOffset.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Row(
                    children: [
                      Text(
                        screen == 1
                            ? "Dont't have a account?"
                            : "Have a account?",
                        style:
                            TextStyle(color: Color(0xffEEEDF0), fontSize: 15),
                      ),
                      TextButton(
                        onPressed: () {
                          print(screen);
                          if (screen == 1) {
                            //TODO: use state management for animation
                            setState(() {
                              screen = 2;
                            });
                          } else {
                            setState(() {
                              screen = 1;
                            });
                          }
                          print(screen);
                        },
                        child: Container(
                          height: 40,
                          width: 80,
                          decoration: BoxDecoration(
                              color: const Color(0xffEEEDF0).withOpacity(0.15),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10),
                              ),
                              border:
                                  Border.all(color: const Color(0xffEEEDF0))),
                          child: Center(
                            child: Text(
                              screen == 2 ? 'Login' : 'Register',
                              style: TextStyle(color: Color(0xffEEEDF0)),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
