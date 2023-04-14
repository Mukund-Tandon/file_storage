import 'package:clipboard/clipboard.dart';

class CopyFileUrlToClipBoard {
  void call(String url) {
    FlutterClipboard.copy(url).then((value) => print('copied'));
  }
}
