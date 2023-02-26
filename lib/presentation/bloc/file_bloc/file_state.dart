part of 'file_bloc.dart';

abstract class FileState extends Equatable {
  const FileState();
}

class FileInitial extends FileState {
  @override
  List<Object> get props => [];
}

class FilesLoadingState extends FileState {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class FilesLoadedState extends FileState {
  List<FileFromServerEntity> files;
  FilesLoadedState({required this.files});
  @override
  List<Object?> get props => [files];
}

class FilesLoadingErrorState extends FileState {
  FilesLoadingErrorState();
  @override
  List<Object?> get props => [];
}
