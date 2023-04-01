import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goal_lock/core/get_device_data.dart';
import 'package:goal_lock/domain/entities/user_entity.dart';
import 'package:goal_lock/domain/usecases/files/upload_files.dart';
import 'package:goal_lock/domain/usecases/user/update_user_field_usecase.dart';
import 'package:goal_lock/injection_container.dart';
import 'package:goal_lock/presentation/bloc/file_bloc/file_bloc.dart';
import 'package:goal_lock/presentation/bloc/user_entity_bloc/user_entity_bloc.dart';
import 'package:goal_lock/presentation/pages/authentication.dart';
import 'package:goal_lock/presentation/pages/home_screen.dart';
import 'package:goal_lock/presentation/pages/side_menu.dart';
import 'package:goal_lock/presentation/widgets/premium_and_space.dart';
import 'package:goal_lock/presentation/widgets/start_button.dart';

import '../../domain/entities/file_from_server_entity.dart';

class Mainpage extends StatefulWidget {
  final UserEntity userEntity;
  const Mainpage({Key? key, required this.userEntity}) : super(key: key);

  @override
  State<Mainpage> createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {
  String user = 'Mukund';

  List<FileFromServerEntity> files = [];
  // Future<void> doTask() async {
  //   var status = await Permission.phone.isRestricted;
  //   print(status);
  // }
  @override
  void initState() {
    print('Main init');

    context
        .read<UserEntityBloc>()
        .add(SubcribeToAuthTokenChangeEvent(userEntity: widget.userEntity));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UserEntity userEntity = widget.userEntity;
    // print(widget.userEntity.uid);
    // widget.userEntity.uid = 'jfjf';
    // print(widget.userEntity.uid);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Color(0xff17181F),
        systemNavigationBarColor: Color(0xff17181F),
      ),
      child: Scaffold(
          backgroundColor: const Color(0xff17181F),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              sl<UpdateUserFieldUsecase>().call('premium', false);
            },
          ),
          body: Stack(
            children: [
              SideMenu(
                userEntity: userEntity,
              ),
              HomeScreen(userEntity: userEntity)
            ],
          )),
    );
  }
}
