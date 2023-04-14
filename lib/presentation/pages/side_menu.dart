import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goal_lock/domain/entities/user_entity.dart';
import 'package:goal_lock/presentation/widgets/premium_and_space.dart';

import '../bloc/user_entity_bloc/user_entity_bloc.dart';

class SideMenu extends StatefulWidget {
  final UserEntity userEntity;
  const SideMenu({Key? key, required this.userEntity}) : super(key: key);

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
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
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Container(
                      height: 100,
                      width: width,
                      color: Colors.grey.withOpacity(0.2),
                    ),
                  ],
                ))
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
                child: BlocBuilder<UserEntityBloc, UserEntityState>(
                  builder: (context, state) {
                    if (state is UserEntityLoadingState) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (state is UserEntityChangedState) {
                      userEntity = state.userEntity;
                      print('change is here');
                      print(userEntity.premium);
                    }
                    return PremiumAndSpace(userEntity: userEntity);
                  },
                ),
              ),
            ),
          ),
          SideMenuButton(),
          SideMenuButton(),
          SideMenuButton(),
        ],
      ),
    );
  }
}

class SideMenuButton extends StatelessWidget {
  const SideMenuButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 150,
      margin: EdgeInsets.only(left: 20, top: 25),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          splashColor: Colors.grey.withOpacity(0.4),
          canRequestFocus: false,
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            print('object');
          },
          child: const Center(
            child: Text(
              'Subcribtion',
              style: TextStyle(
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
