import 'dart:io';

import 'package:goal_lock/domain/entities/user_entity.dart';

class CheckAndReturnFileSizeUsecase {
  double? call(UserEntity userEntity, File file) {
    if (userEntity.premium) {
      if (userEntity.space + file.lengthSync() / 1e9 > 1000) {
        return null;
      }
    } else {
      if (userEntity.space + file.lengthSync() / 1e9 > 15) {
        return null;
      }
    }
    //The File space saved in the database is in GB
    return file.lengthSync() / 1e9;
  }
}
