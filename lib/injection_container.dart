import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:goal_lock/data/datasources/localDataSource/authenticatiion/authentication_local_data_source.dart';
import 'package:goal_lock/data/datasources/localDataSource/user/user_local_datasource.dart';
import 'package:goal_lock/data/datasources/remoteDataSource/authentication/authentication_remote_data_source.dart';
import 'package:goal_lock/data/datasources/remoteDataSource/files/file_remote_data_source.dart';
import 'package:goal_lock/data/datasources/remoteDataSource/premium/premium_remote_data_source.dart';
import 'package:goal_lock/data/datasources/remoteDataSource/user/user_remote_datasource.dart';
import 'package:goal_lock/data/repositories/authentication_repository.dart';
import 'package:goal_lock/data/repositories/file_repository.dart';
import 'package:goal_lock/data/repositories/premium_subcribtion_repository.dart';
import 'package:goal_lock/data/repositories/user_repository.dart';
import 'package:goal_lock/domain/usecases/authentication/auth_tokens_change_usecase.dart';
import 'package:goal_lock/domain/usecases/authentication/get_stored_auth_tokens_usecase.dart';
import 'package:goal_lock/domain/usecases/files/get_files_usecase.dart';
import 'package:goal_lock/domain/usecases/files/upload_files.dart';
import 'package:goal_lock/domain/usecases/premium/connect_to_payment_websocket.dart';
import 'package:goal_lock/domain/usecases/user/get_locally_stored_user_details_usecase.dart';
import 'package:goal_lock/domain/usecases/user/get_user_details_from_server_usecase.dart';
import 'package:goal_lock/domain/usecases/user/store_user_details_locally_usecase.dart';
import 'package:goal_lock/presentation/bloc/auth_bloc/auth_check_cubit.dart';
import 'package:goal_lock/presentation/bloc/auth_bloc/login_bloc.dart';
import 'package:goal_lock/presentation/bloc/file_bloc/file_bloc.dart';
import 'package:goal_lock/presentation/bloc/get_premium_bloc/get_premium_bloc.dart';
import 'package:hive_flutter/adapters.dart';

import 'domain/usecases/authentication/store_auth_tokens_usecase.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //Bloc
  sl.registerFactory<FileBloc>(() => FileBloc(
      uploadFilesUsecase: sl(),
      getFilesUsecase: sl(),
      getStoredAuthTokenUsecase: sl()));
  sl.registerFactory<AuthCheckCubit>(() => AuthCheckCubit(
      storeAuthTokenUsecase: sl(),
      authTokenChangeUseCase: sl(),
      getLocalyStoredUserDetailsUsecase: sl()));
  sl.registerFactory<LoginBloc>(() => LoginBloc(
      authTokenChangeUseCase: sl(),
      storeAuthTokenUsecase: sl(),
      getuserDetailsFromServerUsecase: sl(),
      storeUserDetailsLocallyUsecase: sl()));
  sl.registerFactory<GetPremiumBloc>(
      () => GetPremiumBloc(connectToPaymtWebsocket: sl()));

  //Usecase
  sl.registerLazySingleton<ConnectToPaymtWebsocket>(
      () => ConnectToPaymtWebsocket(premiumSubscribtionRepository: sl()));

  //files
  sl.registerLazySingleton<UploadFilesUsecase>(
      () => UploadFilesUsecase(fileRepository: sl()));
  sl.registerLazySingleton<GetFilesUsecase>(
      () => GetFilesUsecase(fileRepository: sl()));
  //authentication
  sl.registerLazySingleton<AuthTokenChangeUseCase>(
      () => AuthTokenChangeUseCase(authenticationRepository: sl()));
  sl.registerLazySingleton<GetStoredAuthTokenUsecase>(
      () => GetStoredAuthTokenUsecase(authenticationRepository: sl()));
  sl.registerLazySingleton<StoreAuthTokenUsecase>(
      () => StoreAuthTokenUsecase(authenticationRepository: sl()));
  //user
  sl.registerLazySingleton<GetuserDetailsFromServerUsecase>(
      () => GetuserDetailsFromServerUsecase(userRepository: sl()));
  sl.registerLazySingleton<StoreUserDetailsLocallyUsecase>(
      () => StoreUserDetailsLocallyUsecase(userRepository: sl()));
  sl.registerLazySingleton(
      () => GetLocalyStoredUserDetailsUsecase(userRepository: sl()));

  //Repository
  sl.registerLazySingleton<FileRepository>(
      () => FileRepositoryImpl(fileRemoteDataSourceSource: sl()));
  sl.registerLazySingleton<AuthenticationRepository>(() =>
      AuthenticationRepositoryImpl(
          authenticationLocalDataSource: sl(),
          authenticationRemoteDataSource: sl()));
  sl.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(
      userRemoteDataSource: sl(), userLocalDataSource: sl()));
  sl.registerLazySingleton<PremiumSubscribtionRepository>(
      () => PremiumSubcribtionRepositoryImpl(premiumRemoteDataSource: sl()));

  //DataSources

  //GetPremium
  sl.registerLazySingleton<PremiumRemoteDataSource>(
      () => PremiumRemoteDataSourceImpl());

  //file
  sl.registerLazySingleton<FileRemoteDataSourceSource>(
      () => FileRemoteDataSourceImpl(dio: sl()));

  //Authentication
  sl.registerLazySingleton<AuthenticationLocalDataSource>(
      () => AuthenticationLocalDataSourceImpl(storage: sl()));
  sl.registerLazySingleton<AuthenticationRemoteDataSource>(
      () => AuthenticationRemoteDataSourceImpl());

  //user
  sl.registerLazySingleton<UserRemoteDataSource>(
      () => UserRemoteDataSourceImpl(dio: sl()));
  sl.registerLazySingleton<UserLocalDataSource>(
      () => UserLocalDataSourceImpl(box: sl()));

  //Dio
  final dio = Dio();
  sl.registerLazySingleton(() => dio);
  AndroidOptions _getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );

  //Flutter Secure Storage
  final storage = FlutterSecureStorage(aOptions: _getAndroidOptions());
  sl.registerLazySingleton<FlutterSecureStorage>(() => storage);

  //Hive
  final Box box = await Hive.openBox('UserDetails');
  sl.registerLazySingleton<Box>(() => box);
}
