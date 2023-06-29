import 'package:flutter/material.dart';

import '../../domain/entities/file_from_server_entity.dart';
import '../../domain/entities/user_entity.dart';

class ImageFIleViewPage extends StatefulWidget {
  const ImageFIleViewPage(
      {Key? key, required this.fileFromServerEntity, required this.userEntity})
      : super(key: key);
  final FileFromServerEntity fileFromServerEntity;
  final UserEntity userEntity;
  @override
  State<ImageFIleViewPage> createState() => _ImageFIleViewPageState();
}

class _ImageFIleViewPageState extends State<ImageFIleViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff17181F),
      appBar: AppBar(
        backgroundColor: const Color(0xff17181F),
        title: Text(widget.fileFromServerEntity.name),
      ),
      body: Center(
        child: Image.network(
          widget.fileFromServerEntity.url,
          headers: {'Authorization': 'Bearer ${widget.userEntity.authToken}'},
        ),
      ),
    );
  }
}
