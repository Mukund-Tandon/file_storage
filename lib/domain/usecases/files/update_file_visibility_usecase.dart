import '../../../data/repositories/file_repository.dart';

class UpdateFileVisibiityusecase {
  final FileRepository fileRepository;
  UpdateFileVisibiityusecase({required this.fileRepository});

  void call(
      {required String email,
      required String fileName,
      required String value}) {
    fileRepository.updateFileVisibility(email, fileName, value);
  }
}
