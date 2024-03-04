import 'dart:io';

import 'package:autiscope_app/core/network/network_info.dart';
import 'package:autiscope_app/injection_container/login_injection.dart';
import 'package:autiscope_app/injection_container/sign_up_injection.dart';
import 'package:autiscope_app/injection_container/splash_injection.dart';
import 'package:autiscope_app/injection_container/watch_video_injection.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //Injections
  signUpInjection();
  loginInjection();
  watchVideoInjection();
  splashInjection();
  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(
        connectivity: sl(),
        internetConnectionChecker: sl(),
      ));
  //! External
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => Connectivity());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
