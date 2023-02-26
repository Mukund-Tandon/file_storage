part of 'file_bloc.dart';

abstract class FileEvent extends Equatable {
  const FileEvent();
}

class GetFilesEvent extends FileEvent {
  final UserEntity user;
  const GetFilesEvent({required this.user});
  @override
  List<Object?> get props => [user];
}
