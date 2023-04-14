import 'package:flutter/material.dart';
import 'package:goal_lock/presentation/widgets/popup_menu_button_for_files.dart';

import '../../domain/entities/file_from_server_entity.dart';

class FileGridBoxWidget extends StatefulWidget {
  final FileFromServerEntity file;
  final BuildContext mainContext;
  FileGridBoxWidget({Key? key, required this.file, required this.mainContext})
      : super(key: key);

  @override
  State<FileGridBoxWidget> createState() => _FileGridBoxWidgetState();
}

class _FileGridBoxWidgetState extends State<FileGridBoxWidget> {
  bool isImage = true;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                ? Center(
                    child: Icon(
                      Icons.file_copy,
                      color: Colors.white,
                      size: 50,
                    ),
                  )
                : Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            image: NetworkImage(widget.file.url),
                            fit: BoxFit.cover)),
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
                Expanded(
                  flex: 1,
                  child: Container(
                    child: PopupMenuButtonForFiles(
                        file: widget.file, mainContext: widget.mainContext),
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
