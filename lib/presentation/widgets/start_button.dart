import 'package:flutter/material.dart';

class StartButton extends StatelessWidget {
  const StartButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: 120,
      child: Stack(alignment: Alignment.center, children: [
        Container(
          height: 65,
          width: 105,
          decoration: const BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.all(Radius.circular(25)),
            gradient:
                LinearGradient(colors: [Color(0xffCB69C1), Color(0xff6C72CB)]),
          ),
        ),
        Container(
          height: 60,
          width: 97,
          decoration: const BoxDecoration(
              color: Color(0xff17181F),
              borderRadius: BorderRadius.all(Radius.circular(25)),
              boxShadow: [BoxShadow()]),
          alignment: Alignment.center,
          child: const Text(
            'Upload',
            style: TextStyle(color: Colors.white70),
          ),
        ),
      ]),
    );
  }
}

// Path: lib/presentation/widgets/progress_bar.dart
// Compare this snippet from lib/presentation/pages/mainpage.dart:
//           child: Column(
//             children: [
//               Container(
//                 height: 120,
