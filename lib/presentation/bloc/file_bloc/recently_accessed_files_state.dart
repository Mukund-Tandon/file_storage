part of 'recently_accessed_files_bloc.dart';

abstract class RecentlyAccessedFilesState extends Equatable {
  const RecentlyAccessedFilesState();
}

class RecentlyAccessedFilesInitial extends RecentlyAccessedFilesState {
  @override
  List<Object> get props => [];
}

class RecentlyAccessedFilesLoaded extends RecentlyAccessedFilesState {
  List<FileFromServerEntity> files;
  RecentlyAccessedFilesLoaded({required this.files});
  @override
  List<Object> get props => [files];
}
