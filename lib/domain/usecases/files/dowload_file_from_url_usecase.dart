import 'dart:io';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class DownloadFileFromurlUsecase {
  Future<void> call(String url, String fileName) async {
    final status = await Permission.storage.request();

    if (status.isGranted) {
      Directory? downloadsDir;

      if (Platform.isIOS) {
        downloadsDir = await getApplicationDocumentsDirectory();
      } else {
        downloadsDir = Directory('/storage/emulated/0/Download');
        // Put file in global download folder, if for an unknown reason it didn't exist, we fallback
        // ignore: avoid_slow_async_io
        if (!await downloadsDir.exists())
          downloadsDir = await getExternalStorageDirectory();
      }

      if (downloadsDir != null) {
        final taskId = await FlutterDownloader.enqueue(
          url: url,
          savedDir: downloadsDir.path,
          showNotification: true,
          openFileFromNotification: true,
        );
      } else {
        print('Downloads directory not found');
      }
    } else {
      print('Permission Denied');
    }
  }
}
