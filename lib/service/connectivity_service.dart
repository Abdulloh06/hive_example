// Created by Muhammadjonov Abdulloh on 15.11.2022

import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {

  static Future<bool> checkConnection() async {

    final connection = Connectivity();

    final result = await connection.checkConnectivity();

    if(result == ConnectivityResult.wifi
        || result == ConnectivityResult.mobile) {
      return true;
    } else {
      return false;
    }

  }

}