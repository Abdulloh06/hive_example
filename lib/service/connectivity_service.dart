// Created by Muhammadjonov Abdulloh on 15.11.2022

import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {

  static late bool hasConnection;

  // Get connection status when app is started
  static Future<bool> checkConnection() async {
    final result = await Connectivity().checkConnectivity();
    hasConnection = result == ConnectivityResult.wifi
        || result == ConnectivityResult.mobile;
    return hasConnection;
  }

  // Listen to connection status and update connection bool
  static Future<void> listenToConnection() async {
    Connectivity().onConnectivityChanged.listen((result) {
      print(result);
      if(result == ConnectivityResult.wifi || result == ConnectivityResult.mobile) {
        hasConnection = true;
      } else {
        hasConnection = false;
      }
    });
  }
}
