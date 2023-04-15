part of 'recently_accessed_files_bloc.dart';

abstract class RecentlyAccessedFilesEvent extends Equatable {
  const RecentlyAccessedFilesEvent();
}

class LoadRecentlyAccessedFilesEvent extends RecentlyAccessedFilesEvent {
  @override
  List<Object?> get props => [];
}

class UpdateRecentlyAccessedFilesEvent extends RecentlyAccessedFilesEvent {
  final FileFromServerEntity recentlyAccessedFile;
  const UpdateRecentlyAccessedFilesEvent({required this.recentlyAccessedFile});
  @override
  List<Object?> get props => [recentlyAccessedFile];
}
