part of 'file_uploading_bloc.dart';

abstract class FileUploadingEvent extends Equatable {
  const FileUploadingEvent();
}

class UploadFilesEvent extends FileUploadingEvent {
  final UserEntity user;
  const UploadFilesEvent({required this.user});
  @override
  List<Object?> get props => [user];
}

class UploadFilesErrorEvent extends FileUploadingEvent {
  @override
  List<Object?> get props => [];
}

class UploadingStartingEvent extends FileUploadingEvent {
  @override
  List<Object?> get props => [];
}

class UploadingStartedEvent extends FileUploadingEvent {
  String percentage;
  UploadingStartedEvent({required this.percentage});
  @override
  List<Object?> get props => [percentage];
}

class UploadingCompletedEvent extends FileUploadingEvent {
  @override
  List<Object?> get props => [];
}

class CompletedAllFileUploadingTaskEvent extends FileUploadingEvent {
  @override
  List<Object?> get props => [];
}

class UploadingFileSizeExceededEvent extends FileUploadingEvent {
  @override
  List<Object?> get props => [];
}
