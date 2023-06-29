import 'package:flutter/material.dart';
import 'package:goal_lock/domain/entities/user_entity.dart';
import 'package:goal_lock/presentation/pages/get_premium.dart';

import 'cancel_subcribtion_dialog.dart';

class PremiumAndSpace extends StatelessWidget {
  final UserEntity userEntity;
  PremiumAndSpace({Key? key, required this.userEntity}) : super(key: key);

  _spaceDetails() {
    if (userEntity.space > 1) {
      return '${userEntity.space.toStringAsFixed(2)} GB';
    } else if (userEntity.space < 0.001) {
      return '${(userEntity.space * 1000000).toStringAsFixed(2)} KB';
    } else {
      return '${(userEntity.space * 1000).toStringAsFixed(2)} MB';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: userEntity.premium ? Colors.blueGrey : Colors.amberAccent,
      // height: 150,
      // width: 450,

      decoration: BoxDecoration(
        color: Colors.blueGrey.withOpacity(0.3),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          const SizedBox(
            height: 10,
          ),
          const Center(
            child: Text(
              'Space Used',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: Text(_spaceDetails(),
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                )),
          ),
          const SizedBox(height: 20),
          Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: 150,
              ),
              child: Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: LinearProgressIndicator(
                    value: userEntity.premium
                        ? (userEntity.space / 1000)
                        : (userEntity.space / 10),
                    color: Colors.blueGrey.shade500,
                    backgroundColor: Colors.grey.withOpacity(0.7),
                    minHeight: 7,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
