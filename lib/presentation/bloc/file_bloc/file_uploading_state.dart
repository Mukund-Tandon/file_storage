part of 'file_uploading_bloc.dart';

abstract class FileUploadingState extends Equatable {
  const FileUploadingState();
}

class FileUploadingInitial extends FileUploadingState {
  @override
  List<Object> get props => [];
}

class FilesUploadingErrorState extends FileUploadingState {
  FilesUploadingErrorState();
  @override
  List<Object?> get props => [];
}

class UploadingFilesStartedState extends FileUploadingState {
  String percentage;
  UploadingFilesStartedState({required this.percentage});
  @override
  List<Object?> get props => [percentage];
}

class UploadingFilesCompletedState extends FileUploadingState {
  UploadingFilesCompletedState();
  @override
  List<Object?> get props => [];
}

class FilesUploadingStartingState extends FileUploadingState {
  FilesUploadingStartingState();
  @override
  List<Object?> get props => [];
}
