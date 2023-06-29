import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goal_lock/domain/entities/user_entity.dart';

import '../bloc/premium_bloc/cancel_subcribtion_bloc.dart';
import '../bloc/user_entity_bloc/user_entity_bloc.dart';

class CancelSubscriptionDialog extends StatelessWidget {
  CancelSubscriptionDialog({Key? key, required this.userEntity})
      : super(key: key);
  final UserEntity userEntity;
  bool finished = false;
  bool cancellingInProgress = false;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Color(0xff17181F),
      elevation: 20,
      child: Container(
        height: 250,
        width: 300,
        child: BlocBuilder<CancelSubcribtionBloc, CancelSubcribtionState>(
          builder: (context, state) {
            if (state is CancelSubcribtionLoadingState) {
              cancellingInProgress = true;
            }
            if (state is CancelSubcribtionFinishedState) {
              print('CancelSubcribtionFinishedState');
              context
                  .read<UserEntityBloc>()
                  .add(UserEntityChangeEvent(userEntity: state.userEntity));
              finished = true;
            }
            return Column(
              children: [
                Spacer(),
                finished
                    ? TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Back To home',
                            style:
                                TextStyle(color: Colors.yellow, fontSize: 10)))
                    : Text(
                        'Do you Want to cancel your subcribtion?',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                Spacer(),
                Row(
                  children: [
                    Spacer(),
                    TextButton(
                        onPressed: () {
                          context.read<CancelSubcribtionBloc>().add(
                              CancelSubcribtionStartEvent(
                                  userEntity: userEntity));
                        },
                        child: cancellingInProgress
                            ? CircularProgressIndicator()
                            : Text('Yes',
                                style: TextStyle(
                                    color: Colors.red, fontSize: 10))),
                    Spacer(),
                    TextButton(
                        onPressed: cancellingInProgress
                            ? null
                            : () {
                                Navigator.pop(context);
                              },
                        child: Text('Cancel',
                            style:
                                TextStyle(color: Colors.green, fontSize: 10))),
                    Spacer(),
                  ],
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
