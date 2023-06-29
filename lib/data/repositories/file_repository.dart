import 'dart:ui';

import 'package:goal_lock/data/datasources/remoteDataSource/files/file_remote_data_source.dart';
import 'package:goal_lock/domain/entities/file_from_server_entity.dart';
import 'package:goal_lock/domain/entities/file_uploading_details_stream_entity.dart';
import 'package:goal_lock/domain/entities/user_entity.dart';

import '../../domain/entities/upload_file_entity.dart';
import '../datasources/localDataSource/files/files_local_data_source.dart';

abstract class FileRepository {
  Stream<FileUploadingFetailStreamEntity>? uploadFilesToServer(
      UploadFileEntity uploadFileEntity);
  Future<List<FileFromServerEntity>> getFiles(UserEntity userEntity);
  Future<void> updateRecentlyUsedFiles(
      FileFromServerEntity recentlyUsedFilesEntity);
  List<FileFromServerEntity> getRecentlyUsedFiles();
  Future<void> updateFileVisibility(
      String email, String fileName, String value);
}

class FileRepositoryImpl implements FileRepository {
  final FileRemoteDataSourceSource fileRemoteDataSourceSource;
  final FilesLocalDataSource filesLocalDataSource;
  FileRepositoryImpl(
      {required this.fileRemoteDataSourceSource,
      required this.filesLocalDataSource});
  @override
  Stream<FileUploadingFetailStreamEntity>? uploadFilesToServer(
      UploadFileEntity uploadFileEntity) {
    return fileRemoteDataSourceSource.uploadFile(uploadFileEntity);
  }

  @override
  Future<List<FileFromServerEntity>> getFiles(UserEntity userEntity) {
    return fileRemoteDataSourceSource.getFilesFromServer(userEntity);
  }

  @override
  Future<void> updateRecentlyUsedFiles(
      FileFromServerEntity recentlyUsedFilesEntity) async {
    List recentlyaccessedFiles =
        filesLocalDataSource.getRecentlyAccessed()?['files'] ?? [];

    Map<String, List> updatedRecentlyAccessedFiles = {'files': []};

    recentlyaccessedFiles.removeWhere(
        (element) => element['name'] == recentlyUsedFilesEntity.name);
    if (recentlyaccessedFiles.length >= 10) {
      recentlyaccessedFiles.removeLast();
    }
    recentlyaccessedFiles.insert(0, recentlyUsedFilesEntity.toJson());

    updatedRecentlyAccessedFiles['files'] = recentlyaccessedFiles;
    await filesLocalDataSource
        .updateRecentlyAccessed(updatedRecentlyAccessedFiles);
  }

  @override
  List<FileFromServerEntity> getRecentlyUsedFiles() {
    List recentlyaccessedFiles =
        filesLocalDataSource.getRecentlyAccessed()?['files'] ?? [];
    List<FileFromServerEntity> files = [];
    for (var file in recentlyaccessedFiles) {
      files.add(FileFromServerEntity.fromJson(file));
    }
    return files;
  }

  @override
  Future<void> updateFileVisibility(
      String email, String fileName, String value) {
    return fileRemoteDataSourceSource.updateFileVisibility(
        email, fileName, value);
  }
}
