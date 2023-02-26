import 'dart:io';
import 'user_entity.dart';

class UploadFileEntity {
  File file;
  String filename;
  final UserEntity uploadedBy;
  UploadFileEntity(
      {required this.file, required this.filename, required this.uploadedBy});
}
