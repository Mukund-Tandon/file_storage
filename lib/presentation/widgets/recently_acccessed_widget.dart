import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goal_lock/presentation/bloc/file_bloc/recently_accessed_files_bloc.dart';
import 'package:goal_lock/presentation/widgets/recently_accesed_files_widget.dart';

import '../../domain/entities/file_from_server_entity.dart';

class RecentlyAccesedWidget extends StatelessWidget {
  RecentlyAccesedWidget({
    super.key,
    required this.width,
  });
  final List<FileFromServerEntity> files = [];
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: width,
      color: Colors.grey.withOpacity(0.2),
      child: BlocBuilder<RecentlyAccessedFilesBloc, RecentlyAccessedFilesState>(
        builder: (context, state) {
          if (state is RecentlyAccessedFilesInitial) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is RecentlyAccessedFilesLoaded) {
            print('loaded file length---${state.files.length}');
            if (state.files.isEmpty) {
              return const Center(
                child: Text('No files'),
              );
            } else {
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: state.files.length,
                itemBuilder: (context, index) {
                  return RecentlyAccessdFilesWidget(file: state.files[index]);
                },
              );
            }
          } else {
            return const Center(
              child: Text('Error'),
            );
          }
        },
      ),
    );
  }
}
