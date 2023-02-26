import 'package:flutter/material.dart';
import 'package:goal_lock/domain/entities/user_entity.dart';
import 'package:goal_lock/presentation/pages/get_premium.dart';

class PremiumAndSpace extends StatelessWidget {
  final UserEntity userEntity;
  const PremiumAndSpace({Key? key, required this.userEntity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amberAccent,
      height: 100,
      width: 450,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          GetPremium(userEntity: userEntity)));
            },
            child: Container(
              child: Icon(Icons.star),
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
                Container(
                  width: 300,
                  child: LinearProgressIndicator(
                    value: userEntity.premium
                        ? (userEntity.space / 100)
                        : (userEntity.space / 100),
                    color: Colors.green,
                    backgroundColor: Colors.pinkAccent,
                    minHeight: 20,
                  ),
                ),
                Container(
                  child: Text('${(userEntity.space / 100) * 100}%'),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
