import 'package:dio/dio.dart';
import 'package:goal_lock/domain/entities/file_from_server_entity.dart';
import 'package:goal_lock/domain/entities/upload_file_entity.dart';
import 'package:goal_lock/domain/entities/user_entity.dart';

import '../../../../core/constants.dart';

abstract class FileRemoteDataSourceSource {
  Future<void> uploadFile(UploadFileEntity uploadFileEntity);
  Future<List<FileFromServerEntity>> getFilesFromServer(UserEntity userEntity);
}

class FileRemoteDataSourceImpl implements FileRemoteDataSourceSource {
  final Dio dio;
  FileRemoteDataSourceImpl({required this.dio});
  @override
  Future<void> uploadFile(UploadFileEntity uploadFileEntity) async {
    var formData = FormData.fromMap({
      'uploaded_by': uploadFileEntity.uploadedBy.email,
      'files': await MultipartFile.fromFile(uploadFileEntity.file.path,
          filename: uploadFileEntity.filename)
    });
    final response = await dio.post('http://$ip:8000/upload_files/',
        data: formData,
        options: Options(headers: {
          'Authorization': 'Bearer ${uploadFileEntity.uploadedBy.authToken}'
        }));

    print(response.data);
  }

  @override
  Future<List<FileFromServerEntity>> getFilesFromServer(
      UserEntity userEntity) async {
    List<FileFromServerEntity> list = [];
    String url = 'http://$ip:8000/get_files/${userEntity.email}';
    print(userEntity.authToken);

    try {
      var response = await dio.get(url,
          options: Options(
              headers: {'Authorization': 'Bearer ${userEntity.authToken}'}));
      print(response.data);
      List<dynamic> listOfLocations = response.data['goood'];
      listOfLocations.forEach((element) {
        list.add(FileFromServerEntity(location: element));
      });
      return list;
    } catch (e) {
      print('error');
      return list;
    }
  }
}
