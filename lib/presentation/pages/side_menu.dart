import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goal_lock/domain/entities/user_entity.dart';
import 'package:goal_lock/presentation/widgets/premium_and_space.dart';

import '../bloc/file_bloc/recently_accessed_files_bloc.dart';
import '../bloc/user_entity_bloc/user_entity_bloc.dart';
import '../widgets/recently_acccessed_widget.dart';
import 'authentication.dart';
import 'get_premium.dart';

class SideMenu extends StatefulWidget {
  final UserEntity userEntity;
  const SideMenu({Key? key, required this.userEntity}) : super(key: key);

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context
        .read<RecentlyAccessedFilesBloc>()
        .add(LoadRecentlyAccessedFilesEvent());
  }

  @override
  Widget build(BuildContext context) {
    UserEntity userEntity = widget.userEntity;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(children: [
            SizedBox(
              height: 130,
              width: width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 20,
                    margin: const EdgeInsets.only(left: 20),
                    child: const Text(
                      'Recent',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  RecentlyAccesedWidget(
                    width: width,
                    userEntity: userEntity,
                  ),
                ],
              ),
            ),
          ]),
          Container(
            margin: const EdgeInsets.only(left: 20, top: 25),
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 190,
                maxHeight: 150,
              ),
              child: Container(
                // color: Colors.yellow,
                child: PremiumAndSpace(userEntity: userEntity),
              ),
            ),
          ),
          SideMenuButton(
            buttonTitle: 'Subscription',
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => GetPremium(
                            userEntity: userEntity,
                          )));
            },
          ),
          Spacer(),
          Container(
            margin: const EdgeInsets.only(bottom: 15),
            child: SideMenuButton(
              buttonTitle: 'LogOut',
              onTap: () {
                final _auth = FirebaseAuth.instance;
                _auth.signOut();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AuthenticationScreen()),
                    (route) => false);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class SideMenuButton extends StatelessWidget {
  const SideMenuButton({
    super.key,
    required this.buttonTitle,
    required this.onTap,
  });
  final String buttonTitle;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 160,
      margin: EdgeInsets.only(left: 20, top: 25),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          splashColor: Colors.grey.withOpacity(0.4),
          canRequestFocus: false,
          borderRadius: BorderRadius.circular(20),
          onTap: onTap,
          child: Center(
            child: Text(
              buttonTitle,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
