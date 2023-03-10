import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goal_lock/domain/entities/user_entity.dart';

import 'package:goal_lock/presentation/bloc/user_entity_bloc/user_entity_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../bloc/premium_bloc/get_premium_bloc.dart';

class GetPremium extends StatelessWidget {
  GetPremium({Key? key, required this.userEntity, required this.pevcontext})
      : super(key: key);
  UserEntity userEntity;
  BuildContext pevcontext;
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
        body: SafeArea(child: BlocBuilder<GetPremiumBloc, GetPremiumState>(
          builder: (context, state) {
            if (state is PaymentStartedState) {
              print(state.url);
              controller.loadRequest(Uri.parse(state.url));

              return WebViewWidget(controller: controller);
            } else if (state is GetPremiumLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is PaymentCompletedState) {
              return Center(
                //TODO remove prevcontext
                child: Column(
                  children: [
                    Text('Payment Completed'),
                    TextButton(
                        onPressed: () {
                          context.read<UserEntityBloc>().add(
                              UserEntityChangeEvent(userEntity: userEntity));
                          Navigator.pop(context);
                          // context.read<UserEntityBloc>().add(
                          //     UserEntityChangeEvent(userEntity: userEntity));
                          // Navigator.pop(context);
                        },
                        child: Text('Back To Home'))
                  ],
                ),
              );
            } else {
              return Center(
                //TODO:Add Handle Error State
                child: TextButton(
                  onPressed: () {
                    context
                        .read<GetPremiumBloc>()
                        .add(StartPaymentEvent(userEntity: userEntity));
                  },
                  child: Text('Get Premium'),
                ),
              );
            }
          },
        )),
      ),
    );
  }
}
//TODO:check for error while subscribing and also implement the logic of canceling subscribtion
