import 'package:goal_lock/domain/entities/file_from_server_entity.dart';
import 'package:goal_lock/domain/entities/user_entity.dart';

import '../../../data/repositories/file_repository.dart';

class GetFilesUsecase {
  final FileRepository fileRepository;
  GetFilesUsecase({required this.fileRepository});

  Future<List<FileFromServerEntity>> call(UserEntity userEntity) async {
    return await fileRepository.getFiles(userEntity);
  }
}
