import 'package:flutter/material.dart';
import 'package:goal_lock/domain/entities/user_entity.dart';

import 'cancel_subcribtion_dialog.dart';

class PremiumUserSubcribtion extends StatelessWidget {
  PremiumUserSubcribtion({Key? key, required this.userEntity})
      : super(key: key);
  final UserEntity userEntity;

  @override
  Widget build(BuildContext context) {
    DateTime givenDateTime = DateTime.fromMillisecondsSinceEpoch(
        int.parse(userEntity.subcribtionDetailsEntity!.endTime) * 1000);
    DateTime currentDateTime = DateTime.now();

    Duration difference = givenDateTime.difference(currentDateTime);
    int daysLeft = difference.inDays;
    return SafeArea(
        child: Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 20),
          child: Text(
              userEntity.subcribtionDetailsEntity!.cancelled
                  ? 'Cancelled Subscription'
                  : 'Premium User',
              style: const TextStyle(
                color: Color(0xffFFD700),
                fontSize: 25,
                fontWeight: FontWeight.w500,
              )),
        ),
        const SizedBox(
          height: 100,
        ),
        Text(
            userEntity.subcribtionDetailsEntity!.cancelled
                ? 'You can enjoy premium benefits for'
                : 'You will be charged again after',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w400,
            )),
        Text('$daysLeft days',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w400,
            )),
        const SizedBox(
          height: 70,
        ),
        Row(children: [
          if (!userEntity.subcribtionDetailsEntity!.cancelled) const Spacer(),
          if (!userEntity.subcribtionDetailsEntity!.cancelled)
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) =>
                      CancelSubscriptionDialog(userEntity: userEntity),
                );
              },
              child: Container(
                  width: 150,
                  height: 70,
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.redAccent),
                  ),
                  child: const Center(
                    child: Text(
                      'Cancel Subcribtion',
                      style: TextStyle(color: Colors.redAccent),
                    ),
                  )),
            ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
                width: 150,
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.greenAccent),
                ),
                child: const Center(
                  child: Text(
                    'Back To Home',
                    style: TextStyle(color: Colors.white),
                  ),
                )),
          ),
          const Spacer(),
        ])
      ],
    ));
  }
}
