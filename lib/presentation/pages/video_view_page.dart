import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:goal_lock/domain/entities/file_from_server_entity.dart';
import 'package:goal_lock/domain/entities/user_entity.dart';

class VideoFileViewPage extends StatefulWidget {
  const VideoFileViewPage(
      {Key? key, required this.fileFromServerEntity, required this.userEntity})
      : super(key: key);
  final FileFromServerEntity fileFromServerEntity;
  final UserEntity userEntity;
  @override
  State<VideoFileViewPage> createState() => _VideoFileViewPageState();
}

class _VideoFileViewPageState extends State<VideoFileViewPage> {
  late BetterPlayerController _betterPlayerController;
  @override
  void initState() {
    super.initState();
    BetterPlayerDataSource betterPlayerDataSource = BetterPlayerDataSource(
        BetterPlayerDataSourceType.network, widget.fileFromServerEntity.url,
        headers: {'Authorization': 'Bearer ${widget.userEntity.authToken}'});
    _betterPlayerController = BetterPlayerController(
        BetterPlayerConfiguration(),
        betterPlayerDataSource: betterPlayerDataSource);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff17181F),
      appBar: AppBar(
        backgroundColor: const Color(0xff17181F),
        title: Text(widget.fileFromServerEntity.name),
      ),
      body: Center(
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: BetterPlayer(
            controller: _betterPlayerController,
          ),
        ),
      ),
    );
  }
}
