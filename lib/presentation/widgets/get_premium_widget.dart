import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../domain/entities/user_entity.dart';
import '../bloc/premium_bloc/get_premium_bloc.dart';
import '../bloc/user_entity_bloc/user_entity_bloc.dart';

class GetPremiumWidget extends StatelessWidget {
  const GetPremiumWidget({
    super.key,
    required this.controller,
    required this.userEntity,
  });

  final WebViewController controller;
  final UserEntity userEntity;

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: BlocBuilder<GetPremiumBloc, GetPremiumState>(
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
                      context
                          .read<UserEntityBloc>()
                          .add(UserEntityChangeEvent(userEntity: userEntity));
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
          return GetPremiumSubcriptionScreen(userEntity: userEntity);
        }
      },
    ));
  }
}

class GetPremiumSubcriptionScreen extends StatelessWidget {
  const GetPremiumSubcriptionScreen({
    super.key,
    required this.userEntity,
  });

  final UserEntity userEntity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff17181F),
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 30),
          decoration: BoxDecoration(
            color: Colors.blueGrey.withOpacity(0.3),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 20,
              ),
              Text(
                'Get Premium',
                style: TextStyle(
                  color: Colors.yellowAccent.shade200,
                  fontSize: 30,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                margin: const EdgeInsets.all(10),
                child: const Text(
                  'Get Storage upto 1 TB for 50Rs/month with Premium',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Center(
                //TODO:Add Handle Error State
                child: GestureDetector(
                  onTap: () {
                    context
                        .read<GetPremiumBloc>()
                        .add(StartPaymentEvent(userEntity: userEntity));
                  },
                  child: Container(
                    width: 150,
                    height: 70,
                    decoration: BoxDecoration(
                      color: const Color(0xffFFD700).withOpacity(0.3),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.yellowAccent),
                    ),
                    child: const Center(
                      child: Text(
                        'Subscribe',
                        style: TextStyle(color: Colors.yellow),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              )
            ],
          ),
        ),
      ),
    );
  }
}
