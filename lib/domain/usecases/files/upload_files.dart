import 'package:file_picker/file_picker.dart';
import 'package:goal_lock/data/repositories/file_repository.dart';
import 'dart:io';

import 'package:goal_lock/domain/entities/upload_file_entity.dart';
import 'package:goal_lock/domain/entities/user_entity.dart';

class UploadFilesUsecase {
  final FileRepository fileRepository;
  UploadFilesUsecase({required this.fileRepository});
  Future<void> call(UserEntity uploadBy) async {
    print('Upload file usecase');
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File file = File(result.files.single.path!);
      final UploadFileEntity uploadFileEntity = UploadFileEntity(
          file: file, filename: result.files.single.name, uploadedBy: uploadBy);
      await fileRepository.uploadFilesToServer(uploadFileEntity);
    } else {
      print('Error');
    }
  }
}
