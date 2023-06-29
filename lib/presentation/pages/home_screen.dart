import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goal_lock/domain/entities/file_uploading_details_stream_entity.dart';
import 'package:goal_lock/presentation/widgets/FilesGridBoxWidget.dart';

import '../../core/constants.dart';
import '../../core/get_device_data.dart';
import '../../domain/entities/file_from_server_entity.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/files/upload_files.dart';
import '../../injection_container.dart';
import '../bloc/drawer_animation_logic/bloc/drawer_animation_bloc.dart';
import '../bloc/file_bloc/file_bloc.dart';
import '../bloc/file_bloc/file_uploading_bloc.dart';
import '../bloc/user_entity_bloc/user_entity_bloc.dart';
import '../widgets/premium_and_space.dart';
import '../widgets/start_button.dart';
import 'authentication.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.userEntity}) : super(key: key);
  final UserEntity userEntity;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<FileFromServerEntity> files = [];
  double xOffset = 0;
  double yoffset = 0;
  double scalefactor = 1;
  FileUploadStatus fileUploadStatus = FileUploadStatus.completed;
  String uploadedFilePercentage = '0';
  bool drawerOpen = false;
  @override
  void initState() {
    print('djsfdkjsfds');
    context.read<FileBloc>().add(GetFilesEvent(user: widget.userEntity));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UserEntity userEntity = widget.userEntity;
    return SafeArea(
      child: BlocBuilder<DrawerAnimationBloc, DrawerAnimationState>(
        builder: (context, state) {
          if (state is DrawerOpenState) {
            drawerOpen = true;
            xOffset = state.xOffset;
            yoffset = state.yoffset;
            scalefactor = state.scalefactor;
          } else if (state is DrawerCloseState) {
            drawerOpen = false;
            xOffset = state.xOffset;
            yoffset = state.yoffset;
            scalefactor = state.scalefactor;
          }
          return GestureDetector(
            onTap: drawerOpen
                ? () {
                    BlocProvider.of<DrawerAnimationBloc>(context)
                        .add(DrawerOpenCloseEvent(openClose: OpenClose.close));
                  }
                : null,
            onHorizontalDragEnd: drawerOpen
                ? (details) {
                    if (details.primaryVelocity! < 0) {
                      BlocProvider.of<DrawerAnimationBloc>(context).add(
                          DrawerOpenCloseEvent(openClose: OpenClose.close));
                    }
                  }
                : null,
            child: AnimatedContainer(
              transform: Matrix4.translationValues(xOffset, yoffset, 0)
                ..scale(scalefactor),
              duration: const Duration(milliseconds: 200),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  color: const Color(0xff17181F),
                  boxShadow: [
                    BoxShadow(
                      color: drawerOpen ? Colors.white : Colors.transparent,
                      blurRadius: 20.0,
                    )
                  ]),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: TextButton(
                        onPressed: () {
                          BlocProvider.of<DrawerAnimationBloc>(context).add(
                              DrawerOpenCloseEvent(openClose: OpenClose.open));
                        },
                        child: const Icon(
                          Icons.menu,
                          color: Colors.white,
                        )),
                  ),
                  // PremiumAndSpace(userEntity: userEntity),

                  GestureDetector(
                    onTap: () async {
                      print('tap');
                      context
                          .read<FileUploadingBloc>()
                          .add(UploadFilesEvent(user: userEntity));
                    },
                    child: BlocBuilder<FileUploadingBloc, FileUploadingState>(
                        builder: (context, state) {
                      if (state is FilesUploadingStartingState) {
                        fileUploadStatus = FileUploadStatus.starting;
                      } else if (state is UploadingFilesStartedState) {
                        print('Uploading Files Started');
                        fileUploadStatus = FileUploadStatus.started;
                        uploadedFilePercentage = state.percentage;
                      } else if (state is UploadingFilesCompletedState) {
                        fileUploadStatus = FileUploadStatus.completed;
                        print('UploadingFilesCompletedState');
                        context
                            .read<FileBloc>()
                            .add(GetFilesEvent(user: userEntity));
                        context
                            .read<UserEntityBloc>()
                            .add(UserEntityChangeEvent(userEntity: userEntity));
                        context
                            .read<FileUploadingBloc>()
                            .add(CompletedAllFileUploadingTaskEvent());
                      } else if (state is UploadingFilesExceededState) {
                        fileUploadStatus = FileUploadStatus.error;
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Exceeded File Size')));
                      } else if (state is FilesUploadingErrorState) {
                        fileUploadStatus = FileUploadStatus.error;
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Error in Uploading')));
                      }
                      return StartButton(
                          fileUploadStatus: fileUploadStatus,
                          percentage: uploadedFilePercentage);
                    }),
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
              ),
            ),
          );
        },
      ),
    );
  }

  _gridListOfFiles() => GridView.builder(
        itemCount: files.length,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return FileGridBoxWidget(
            file: files[index],
            userEntity: widget.userEntity,
          );
        },
      );
}
