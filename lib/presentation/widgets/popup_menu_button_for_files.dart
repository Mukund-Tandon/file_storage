import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goal_lock/domain/entities/user_entity.dart';
import 'package:goal_lock/domain/usecases/files/dowload_file_from_url_usecase.dart';
import 'package:goal_lock/presentation/widgets/share_file_dialog.dart';

import '../../domain/entities/file_from_server_entity.dart';
import 'package:flutter/material.dart';

import '../../injection_container.dart';
import '../bloc/file_bloc/recently_accessed_files_bloc.dart';

class PopupMenuButtonForFiles extends StatelessWidget {
  const PopupMenuButtonForFiles({
    super.key,
    required this.file,
    required this.userEntity,
  });

  final FileFromServerEntity file;
  final UserEntity userEntity;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (context) {
        return [
          // PopupMenuItem(
          //   onTap: () {},
          //   child: PopUpmenuItemButton(
          //     title: 'Delete',
          //   ),
          // ),
          // PopupMenuItem(
          //   onTap: () {},
          //   child: PopUpmenuItemButton(
          //     title: 'Rename',
          //   ),
          // ),
          PopupMenuItem(
            value: 'Share',
            child: PopUpmenuItemButton(
              title: 'Share',
            ),
          ),
          PopupMenuItem(
            value: 'Download',
            child: PopUpmenuItemButton(
              title: 'Download',
            ),
          ),
        ];
      },
      onSelected: (value) {
        print(value);
        if (value == 'Share') {
          context.read<RecentlyAccessedFilesBloc>().add(
              UpdateRecentlyAccessedFilesEvent(recentlyAccessedFile: file));
          showDialog(
              context: context,
              builder: (context) {
                return ShareFileDialog(
                  file: file,
                  userEntity: userEntity,
                );
              });
        } else if (value == 'Download') {
          print('Download');
          context.read<RecentlyAccessedFilesBloc>().add(
              UpdateRecentlyAccessedFilesEvent(recentlyAccessedFile: file));
          sl<DownloadFileFromurlUsecase>().call(file.url, file.name);
        }
      },
      icon: const Icon(
        Icons.more_vert,
        color: Colors.white70,
      ),
      color: Colors.grey.withOpacity(0.8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}

class PopUpmenuItemButton extends StatelessWidget {
  String title;
  PopUpmenuItemButton({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 100,
      padding: EdgeInsets.all(8),
      alignment: Alignment.center,
      child: Text(
        title,
        style: TextStyle(
          color: Colors.white70,
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
