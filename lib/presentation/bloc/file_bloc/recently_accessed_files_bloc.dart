import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/file_from_server_entity.dart';
import '../../../domain/usecases/files/get_recently_accessed_files_usecase.dart';
import '../../../domain/usecases/files/update_recently_used_files_usecase.dart';

part 'recently_accessed_files_event.dart';
part 'recently_accessed_files_state.dart';

class RecentlyAccessedFilesBloc
    extends Bloc<RecentlyAccessedFilesEvent, RecentlyAccessedFilesState> {
  final GetRecentlyAccessedFilesUseCase getRecentlyAccessedFilesUseCase;
  final UpdateRecentlyAccessedFilesUsecase updateRecentlyAccessedFilesUsecase;

  RecentlyAccessedFilesBloc(
      {required this.updateRecentlyAccessedFilesUsecase,
      required this.getRecentlyAccessedFilesUseCase})
      : super(RecentlyAccessedFilesInitial()) {
    on<LoadRecentlyAccessedFilesEvent>((event, emit) {
      emit(RecentlyAccessedFilesLoaded(
          files: getRecentlyAccessedFilesUseCase.call()));
    });
    on<UpdateRecentlyAccessedFilesEvent>((event, emit) async {
      await updateRecentlyAccessedFilesUsecase.call(event.recentlyAccessedFile);
      add(LoadRecentlyAccessedFilesEvent());
    });
  }
}
