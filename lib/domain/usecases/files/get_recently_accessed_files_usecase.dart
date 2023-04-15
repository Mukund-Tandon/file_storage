import 'package:goal_lock/domain/entities/file_from_server_entity.dart';

import '../../../data/repositories/file_repository.dart';

class GetRecentlyAccessedFilesUseCase {
  final FileRepository fileRepository;

  GetRecentlyAccessedFilesUseCase({required this.fileRepository});

  List<FileFromServerEntity> call() {
    return fileRepository.getRecentlyUsedFiles();
  }
}
