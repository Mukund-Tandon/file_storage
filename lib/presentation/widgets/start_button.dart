import 'dart:io';

import 'package:flutter/material.dart';
import 'package:goal_lock/domain/entities/file_uploading_details_stream_entity.dart';

class StartButton extends StatelessWidget {
  FileUploadStatus fileUploadStatus;
  String? percentage;
  StartButton({Key? key, required this.fileUploadStatus, this.percentage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('percentage $percentage');
    return SizedBox(
      height: 70,
      width: 120,
      child: Stack(alignment: Alignment.center, children: [
        Container(
          height: 65,
          width: 130,
          decoration: const BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.all(Radius.circular(25)),
            gradient:
                LinearGradient(colors: [Color(0xffCB69C1), Color(0xff6C72CB)]),
          ),
        ),
        Container(
          height: 60,
          width: 120,
          decoration: const BoxDecoration(
              color: Color(0xff17181F),
              borderRadius: BorderRadius.all(Radius.circular(25)),
              boxShadow: [BoxShadow()]),
          alignment: Alignment.center,
          child: fileUploadStatus == FileUploadStatus.starting
              ? const CircularProgressIndicator()
              : Text(
                  fileUploadStatus == FileUploadStatus.started
                      ? 'Uploading $percentage %'
                      : 'Upload',
                  style: const TextStyle(color: Colors.white70),
                ),
        ),
      ]),
    );
  }
}

// Path: lib/presentation/widgets/progress_bar.dart
// Compare this snippet from lib/presentation/pages/mainpage.dart:
//           child: Column(
//             children: [
//               Container(
//                 height: 120,
