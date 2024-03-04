import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool> checkConnection();
}

class NetworkInfoImpl implements NetworkInfo {
  final Connectivity connectivity;
  final InternetConnectionChecker internetConnectionChecker;

  NetworkInfoImpl(
      {required this.connectivity, required this.internetConnectionChecker});

  @override
  Future<bool> checkConnection() async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.mobile ||
        await connectivity.checkConnectivity() == ConnectivityResult.wifi) {
      return await internetConnectionChecker.hasConnection;
    } else {
      return false;
    }
  }
}
