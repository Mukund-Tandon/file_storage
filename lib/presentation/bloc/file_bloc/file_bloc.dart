import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/file_from_server_entity.dart';
import '../../../domain/entities/user_entity.dart';
import '../../../domain/usecases/authentication/get_stored_auth_tokens_usecase.dart';
import '../../../domain/usecases/files/get_files_usecase.dart';
import '../../../domain/usecases/files/upload_files.dart';

part 'file_event.dart';
part 'file_state.dart';

class FileBloc extends Bloc<FileEvent, FileState> {
  final GetFilesUsecase getFilesUsecase;
  final UploadFilesUsecase uploadFilesUsecase;
  final GetStoredAuthTokenUsecase getStoredAuthTokenUsecase;
  FileBloc(
      {required this.uploadFilesUsecase,
      required this.getFilesUsecase,
      required this.getStoredAuthTokenUsecase})
      : super(FileInitial()) {
    on<GetFilesEvent>((event, emit) async {
      emit(FilesLoadingState());
      List<FileFromServerEntity> list = [];
      String? authToken = await getStoredAuthTokenUsecase.call();
      if (authToken != null) {
        event.user.authToken = authToken;
        list = await getFilesUsecase.call(event.user);
        print('List == $list');
        emit(FilesLoadedState(files: list));
      } else {
        emit(FilesLoadingErrorState());
      }
    });
  }
}
