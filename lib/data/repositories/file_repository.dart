import 'dart:ui';

import 'package:goal_lock/data/datasources/remoteDataSource/files/file_remote_data_source.dart';
import 'package:goal_lock/domain/entities/file_from_server_entity.dart';
import 'package:goal_lock/domain/entities/file_uploading_details_stream_entity.dart';
import 'package:goal_lock/domain/entities/user_entity.dart';

import '../../domain/entities/upload_file_entity.dart';

abstract class FileRepository {
  Stream<FileUploadingFetailStreamEntity>? uploadFilesToServer(
      UploadFileEntity uploadFileEntity);
  Future<List<FileFromServerEntity>> getFiles(UserEntity userEntity);
}

class FileRepositoryImpl implements FileRepository {
  final FileRemoteDataSourceSource fileRemoteDataSourceSource;
  FileRepositoryImpl({required this.fileRemoteDataSourceSource});
  @override
  Stream<FileUploadingFetailStreamEntity>? uploadFilesToServer(
      UploadFileEntity uploadFileEntity) {
    return fileRemoteDataSourceSource.uploadFile(uploadFileEntity);
  }

  @override
  Future<List<FileFromServerEntity>> getFiles(UserEntity userEntity) {
    return fileRemoteDataSourceSource.getFilesFromServer(userEntity);
  }
}
