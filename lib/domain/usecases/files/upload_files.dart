import 'package:file_picker/file_picker.dart';
import 'package:goal_lock/data/repositories/file_repository.dart';
import 'dart:io';

import 'package:goal_lock/domain/entities/upload_file_entity.dart';
import 'package:goal_lock/domain/entities/user_entity.dart';

import '../../entities/file_uploading_details_stream_entity.dart';

class UploadFilesUsecase {
  final FileRepository fileRepository;
  UploadFilesUsecase({required this.fileRepository});
  Stream<FileUploadingFetailStreamEntity>? call(
      UploadFileEntity uploadFileEntity) {
    return fileRepository.uploadFilesToServer(uploadFileEntity);
  }
}
