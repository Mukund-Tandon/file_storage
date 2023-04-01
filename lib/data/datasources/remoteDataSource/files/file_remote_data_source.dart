import 'dart:async';

import 'package:dio/dio.dart';
import 'package:goal_lock/domain/entities/file_from_server_entity.dart';
import 'package:goal_lock/domain/entities/file_uploading_details_stream_entity.dart';
import 'package:goal_lock/domain/entities/upload_file_entity.dart';
import 'package:goal_lock/domain/entities/user_entity.dart';

import '../../../../core/constants.dart';

abstract class FileRemoteDataSourceSource {
  Stream<FileUploadingFetailStreamEntity>? uploadFile(
      UploadFileEntity uploadFileEntity);
  Future<List<FileFromServerEntity>> getFilesFromServer(UserEntity userEntity);
}

class FileRemoteDataSourceImpl implements FileRemoteDataSourceSource {
  final Dio dio;
  final _controller =
      StreamController<FileUploadingFetailStreamEntity>.broadcast();
  FileRemoteDataSourceImpl({required this.dio});
  @override
  Stream<FileUploadingFetailStreamEntity>? uploadFile(
      UploadFileEntity uploadFileEntity) {
    //show notification while uploading file
    try {
      _uploadFile(uploadFileEntity);
      return _controller.stream;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<FileFromServerEntity>> getFilesFromServer(
      UserEntity userEntity) async {
    List<FileFromServerEntity> list = [];
    String url = 'http://$ip:8000/get_files/${userEntity.email}';
    print(userEntity.authToken);

    try {
      print('trying to det files ');
      var response = await dio.get(url,
          options: Options(
              headers: {'Authorization': 'Bearer ${userEntity.authToken}'}));
      print('got the files');
      print(response.data);
      List<dynamic> listOfLocations = response.data['good'];
      listOfLocations.forEach((element) {
        list.add(FileFromServerEntity.fromJson(element));
      });
      return list;
    } catch (e) {
      print('error');
      return list;
    }
  }

  _uploadFile(UploadFileEntity uploadFileEntity) async {
    var formData = FormData.fromMap({
      'uploaded_by': uploadFileEntity.uploadedBy.email,
      'files': await MultipartFile.fromFile(uploadFileEntity.file.path,
          filename: uploadFileEntity.filename)
    });
    final response = await dio.post(
      'http://$ip:8000/upload_files/',
      data: formData,
      options: Options(
        headers: {
          'Authorization': 'Bearer ${uploadFileEntity.uploadedBy.authToken}'
        },
      ),
      onSendProgress: (int sent, int total) {
        int percentage = ((sent / total) * 100).toInt();
        _controller.add(FileUploadingFetailStreamEntity(
            fileUploadStatus: FileUploadStatus.started,
            percentage: percentage.toString()));
      },
    );
    _controller.add(FileUploadingFetailStreamEntity(
        fileUploadStatus: FileUploadStatus.completed, percentage: '100'));
    print('done uploaded to server');
  }
}
