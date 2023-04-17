import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goal_lock/domain/entities/user_entity.dart';

import 'package:goal_lock/presentation/bloc/user_entity_bloc/user_entity_bloc.dart';
import 'package:goal_lock/presentation/widgets/premium_user_subcribtion_widget.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../bloc/premium_bloc/get_premium_bloc.dart';
import '../widgets/get_premium_widget.dart';

class GetPremium extends StatelessWidget {
  GetPremium({Key? key, required this.userEntity}) : super(key: key);
  UserEntity userEntity;
  var controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted);
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Color(0xff17181F),
        systemNavigationBarColor: Color(0xff17181F),
      ),
      child: Scaffold(
        backgroundColor: const Color(0xff17181F),
        body: userEntity.premium
            ? PremiumUserSubcribtion(userEntity: userEntity)
            : GetPremiumWidget(controller: controller, userEntity: userEntity),
      ),
    );
  }
}

//TODO:check for error while subscribing and also implement the logic of canceling subscribtion
