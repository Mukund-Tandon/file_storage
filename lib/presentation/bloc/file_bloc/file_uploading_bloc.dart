import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';

import '../../../domain/entities/file_uploading_details_stream_entity.dart';
import '../../../domain/entities/upload_file_entity.dart';
import '../../../domain/entities/user_entity.dart';
import '../../../domain/usecases/authentication/get_stored_auth_tokens_usecase.dart';
import '../../../domain/usecases/files/check_and_return_file_size_usecase.dart';
import '../../../domain/usecases/files/upload_files.dart';
import '../../../domain/usecases/user/update_user_field_usecase.dart';

part 'file_uploading_event.dart';
part 'file_uploading_state.dart';

class FileUploadingBloc extends Bloc<FileUploadingEvent, FileUploadingState> {
  final UploadFilesUsecase uploadFilesUsecase;
  final GetStoredAuthTokenUsecase getStoredAuthTokenUsecase;
  final CheckAndReturnFileSizeUsecase checkAndReturnFileSizeUsecase;
  final UpdateUserFieldUsecase updateUserFieldUsecase;
  FileUploadingBloc({
    required this.uploadFilesUsecase,
    required this.getStoredAuthTokenUsecase,
    required this.checkAndReturnFileSizeUsecase,
    required this.updateUserFieldUsecase,
  }) : super(FileUploadingInitial()) {
    on<UploadingCompletedEvent>((event, emit) async {
      emit(UploadingFilesCompletedState());
    });
    on<UploadingStartingEvent>((event, emit) async {
      emit(FilesUploadingStartingState());
    });
    on<UploadingStartedEvent>((event, emit) async {
      emit(UploadingFilesStartedState(percentage: event.percentage));
    });
    on<UploadingFileSizeExceededEvent>((event, emit) async {
      emit(UploadingFilesExceededState());
    });
    on<CompletedAllFileUploadingTaskEvent>((event, emit) async {
      emit(FileUploadingInitial());
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
          uploadingFilestatusStream.listen((Uploadevent) async {
            print('Event == ${Uploadevent.percentage}');

            if (Uploadevent.fileUploadStatus == FileUploadStatus.completed) {
              double? fileSize =
                  checkAndReturnFileSizeUsecase.call(event.user, file);
              print('File size == $fileSize');
              if (fileSize != null) {
                await updateUserFieldUsecase.call(
                    'space', fileSize + event.user.space);
                print('File upload completed');
                add(UploadingCompletedEvent());
              } else {
                add(UploadingFileSizeExceededEvent());
              }
            } else {
              print('doing');
              add(UploadingStartedEvent(percentage: Uploadevent.percentage!));
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
