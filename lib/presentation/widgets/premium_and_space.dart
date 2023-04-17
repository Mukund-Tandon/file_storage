import 'package:flutter/material.dart';
import 'package:goal_lock/domain/entities/user_entity.dart';
import 'package:goal_lock/presentation/pages/get_premium.dart';

import 'cancel_subcribtion_dialog.dart';

class PremiumAndSpace extends StatelessWidget {
  final UserEntity userEntity;
  PremiumAndSpace({Key? key, required this.userEntity}) : super(key: key);

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
          GestureDetector(
            onTap: () {},
            child: Container(
              height: 60,
              child: Icon(Icons.star),
            ),
          ),
          Container(
            height: 20,
            margin: EdgeInsets.only(left: 20),
            child: Text(
              'Recent',
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          // Container(
          //   color: Colors.green,
          //   height: 10,
          // ),
          // Row(
          //   mainAxisSize: MainAxisSize.max,
          //   children: [
          //     Container(
          //       height: 60,
          //       color: Colors.pink,
          //     ),
          //     Container(
          //       height: 60,
          //       color: Colors.pink,
          //     )
          //   ],
          // ),
          Container(
            child: Row(
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: 150,
                  ),
                  child: Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: LinearProgressIndicator(
                        value: userEntity.premium
                            ? (userEntity.space / 100)
                            : (userEntity.space / 100) + 0.2,
                        color: Colors.blueGrey.shade500,
                        backgroundColor: Colors.grey.withOpacity(0.7),
                        minHeight: 7,
                      ),
                    ),
                  ),
                ),
                Container(
                  child: Text(
                    '${(userEntity.space / 100) * 100}%',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )
              ],
            ),
          ),
          userEntity.premium && !userEntity.subcribtionDetailsEntity!.cancelled
              ? GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return CancelSubscriptionDialog(
                            userEntity: userEntity,
                          );
                        },
                        barrierDismissible: true,
                        barrierColor: Color(0x0fEEEDF0));
                  },
                  child: Container(
                    height: 20,
                    width: 100,
                    child: Icon(Icons.cancel),
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}
