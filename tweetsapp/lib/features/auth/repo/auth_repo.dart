import 'dart:developer';

import 'package:tweetsapp/core/config.dart';
import 'package:tweetsapp/features/auth/model/user_model.dart';
import 'package:dio/dio.dart';

class AuthRepo {
  static Future<UserModel?> getUserRepo(String uid) async {
    try {
      Dio dio = Dio();
      final response = await dio.get(Config.serverUrl + "user/$uid");

      if (response.statusCode! >= 200 && response.statusCode! <= 300) {
        log(response.data);

        UserModel userModel = UserModel.fromMap(response.data);
        return userModel;
      } else {
        return null;
      }
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  static Future<bool?> createUserRepo(UserModel userModel) async {
    Dio dio = Dio();
    final response =
        await dio.post("${Config.serverUrl}user", data: userModel.toMap());

    if (response.statusCode! >= 200 && response.statusCode! <= 300) {
      return true;
    } else {
      return false;
    }
  }
}
