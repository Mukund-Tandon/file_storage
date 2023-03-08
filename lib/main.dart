import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goal_lock/hive_objects.dart';
import 'package:goal_lock/presentation/bloc/auth_bloc/auth_check_cubit.dart';
import 'package:goal_lock/presentation/bloc/auth_bloc/login_bloc.dart';
import 'package:goal_lock/presentation/bloc/file_bloc/file_bloc.dart';
import 'package:goal_lock/presentation/bloc/premium_bloc/cancel_subcribtion_bloc.dart';
import 'package:goal_lock/presentation/bloc/premium_bloc/get_premium_bloc.dart';
import 'package:goal_lock/presentation/bloc/user_entity_bloc/user_entity_bloc.dart';
import 'package:goal_lock/presentation/pages/authentication.dart';
import 'package:goal_lock/presentation/pages/mainpage.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'injection_container.dart' as di;
import 'injection_container.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await Hive.initFlutter();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<FileBloc>()),
        BlocProvider(
            create: (context) => sl<AuthCheckCubit>()..checkIfAuthenticated()),
        BlocProvider(create: (context) => sl<LoginBloc>()),
        BlocProvider(create: (context) => sl<GetPremiumBloc>()),
        BlocProvider(create: (context) => sl<UserEntityBloc>()),
        BlocProvider(create: (context) => sl<CancelSubcribtionBloc>()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home: BlocBuilder<AuthCheckCubit, AuthCheckState>(
          builder: (context, state) {
            if (state is UserAuthenticatedState) {
              var user = state.userEntity;
              return Mainpage(userEntity: user);
            } else if (state is StoringAuthenticationDetailsState) {
              return Scaffold(
                backgroundColor: Colors.yellow,
              );
            } else {
              return const AuthenticationScreen();
            }
          },
        ),
      ),
    );
  }
}
