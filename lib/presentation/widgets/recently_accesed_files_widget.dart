import 'package:flutter/material.dart';
import 'package:goal_lock/presentation/widgets/popup_menu_button_for_files.dart';

import '../../domain/entities/file_from_server_entity.dart';

class RecentlyAccessdFilesWidget extends StatefulWidget {
  final FileFromServerEntity file;
  const RecentlyAccessdFilesWidget({Key? key, required this.file})
      : super(key: key);

  @override
  State<RecentlyAccessdFilesWidget> createState() =>
      _RecentlyAccessdFilesWidgetState();
}

class _RecentlyAccessdFilesWidgetState
    extends State<RecentlyAccessdFilesWidget> {
  bool isImage = true;

  @override
  Widget build(BuildContext context) {
    print(widget.file.url);
    return Container(
      width: 100,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.blueGrey.withOpacity(0.3),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                spreadRadius: 5)
          ]),
      child: Column(
        children: [
          Expanded(
            child: widget.file.fileType == FileType.notImage
                ? const Center(
                    child: Icon(
                      Icons.video_file_outlined,
                      color: Colors.white,
                      size: 30,
                    ),
                  )
                : Container(
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          image: NetworkImage(widget.file.url),
                          fit: BoxFit.fitWidth),
                    ),
                  ),
          ),
          Container(
            padding: const EdgeInsets.all(5),
            child: Row(
              children: [
                Expanded(
                  flex: 5,
                  child: Container(
                    child: Text(
                      widget.file.name,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),

                // GestureDetector(
                //   onTap: () {},
                //   child: Container(
                //     padding: EdgeInsets.all(3.0),
                //     child: const Icon(
                //       Icons.more_vert,
                //       color: Colors.white70,
                //     ),
                //   ),
                // )
              ],
            ),
          )
        ],
      ),
    );
  }
}
