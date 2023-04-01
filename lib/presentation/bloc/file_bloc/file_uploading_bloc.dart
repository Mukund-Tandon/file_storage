import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';

import '../../../domain/entities/file_uploading_details_stream_entity.dart';
import '../../../domain/entities/upload_file_entity.dart';
import '../../../domain/entities/user_entity.dart';
import '../../../domain/usecases/authentication/get_stored_auth_tokens_usecase.dart';
import '../../../domain/usecases/files/upload_files.dart';

part 'file_uploading_event.dart';
part 'file_uploading_state.dart';

class FileUploadingBloc extends Bloc<FileUploadingEvent, FileUploadingState> {
  final UploadFilesUsecase uploadFilesUsecase;
  final GetStoredAuthTokenUsecase getStoredAuthTokenUsecase;
  FileUploadingBloc(
      {required this.uploadFilesUsecase,
      required this.getStoredAuthTokenUsecase})
      : super(FileUploadingInitial()) {
    on<UploadingCompletedEvent>((event, emit) async {
      emit(UploadingFilesCompletedState());
    });
    on<UploadingStartingEvent>((event, emit) async {
      emit(FilesUploadingStartingState());
    });
    on<UploadingStartedEvent>((event, emit) async {
      emit(UploadingFilesStartedState(percentage: event.percentage));
    });
    on<UploadFilesEvent>((event, emit) async {
      add(UploadingStartingEvent());
      print('Upload file usecase');
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result != null) {
        print('file found');
        File file = File(result.files.single.path!);
        final UploadFileEntity uploadFileEntity = UploadFileEntity(
            file: file,
            filename: result.files.single.name,
            uploadedBy: event.user);
        Stream? uploadingFilestatusStream =
            uploadFilesUsecase.call(uploadFileEntity);
        if (uploadingFilestatusStream != null) {
          print('File upload started');
          uploadingFilestatusStream.listen((event) {
            print('Event == ${event.percentage}');

            if (event.fileUploadStatus == FileUploadStatus.completed) {
              add(UploadingCompletedEvent());
            } else {
              print('doing');
              add(UploadingStartedEvent(percentage: event.percentage!));
            }
          });
        } else {
          print('File upload error');
          emit(FilesUploadingErrorState());
        }
      } else {
        print('File upload error');
        emit(FilesUploadingErrorState());
      }
    });
  }
}
