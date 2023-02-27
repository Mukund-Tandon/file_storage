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
    context.read<FileBloc>().add(GetFilesEvent(user: widget.userEntity));
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
        body: SafeArea(
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
              return Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  PremiumAndSpace(userEntity: userEntity, prevContext: context),
                  Container(
                    height: 90,
                    width: displayWidth(context),
                    child: Container(
                      width: displayWidth(context) / 1.5,
                      height: 120,
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              final _auth = FirebaseAuth.instance;
                              _auth.signOut();
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const AuthenticationScreen()),
                                  (route) => false);
                            },
                            child: Container(
                              margin: const EdgeInsets.only(left: 10, top: 10),
                              alignment: Alignment.centerLeft,
                              child: const Text(
                                '----',
                                style: TextStyle(
                                    color: Color(0xff7A7C7F), fontSize: 21),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                margin:
                                    const EdgeInsets.only(left: 10, top: 10),
                                alignment: Alignment.centerLeft,
                                child: const Text(
                                  'Uploads',
                                  style: TextStyle(
                                      color: Color(0xffEEEDF0), fontSize: 18),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.only(left: 10, top: 10),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Shared',
                                  style: TextStyle(
                                      color: Color(0xffEEEDF0).withOpacity(0.5),
                                      fontSize: 18),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      print('tap');
                      sl<UploadFilesUsecase>().call(userEntity);
                    },
                    child: const StartButton(),
                  ),
                  Expanded(child: BlocBuilder<FileBloc, FileState>(
                      builder: (context, state) {
                    if (state is FilesLoadedState) {
                      files = state.files;
                      return _gridListOfFiles();
                    } else if (state is FilesLoadingErrorState) {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const AuthenticationScreen()),
                          (route) => false);

                      return Container();
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }))
                  // Container(
                  //   color: Colors.yellow,
                  //   height: 200,
                  //   width: 200,
                  //   child: Image.network(
                  //     'http://159.65.151.168/media/email@gmail.com/download_kLnDmi7.jpeg',
                  //     loadingBuilder: (BuildContext context, Widget child,
                  //         ImageChunkEvent? loadingProgress) {
                  //       if (loadingProgress == null) {
                  //         return child;
                  //       }
                  //       return Container(
                  //         color: Colors.red,
                  //       );
                  //     },
                  //     // errorBuilder: (BuildContext context, Object exception,
                  //     //     StackTrace? stackTrace) {
                  //     //   // Appropriate logging or analytics, e.g.
                  //     //   // myAnalytics.recordError(
                  //     //   //   'An error occurred loading "https://example.does.not.exist/image.jpg"',
                  //     //   //   exception,
                  //     //   //   stackTrace,
                  //     //   // );
                  //     //   return Container(
                  //     //     color: Colors.red,
                  //     //   );
                  //     // },
                  //   ),
                  // )
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  _gridListOfFiles() => GridView.builder(
        itemCount: files.length,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return Image.network(files[index].location);
        },
      );
}
