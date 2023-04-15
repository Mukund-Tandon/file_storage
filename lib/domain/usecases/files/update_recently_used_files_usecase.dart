import '../../../data/repositories/file_repository.dart';
import '../../entities/file_from_server_entity.dart';

class UpdateRecentlyAccessedFilesUsecase {
  UpdateRecentlyAccessedFilesUsecase({required this.fileRepository});
  final FileRepository fileRepository;

  Future<void> call(FileFromServerEntity recentlyUsedFilesEntity) async {
    await fileRepository.updateRecentlyUsedFiles(recentlyUsedFilesEntity);
  }
}
