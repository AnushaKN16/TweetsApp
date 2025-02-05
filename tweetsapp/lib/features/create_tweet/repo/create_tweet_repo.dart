import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:tweetsapp/core/config.dart';

class CreateTweetRepo {
  static Future<bool> postTweetRepo(String tweetId, String adminId,
      String content, DateTime createdAt) async {
    try {
      Dio dio = Dio();

      final response = await dio.post('${Config.serverUrl}tweet', data: {
        'tweetId': tweetId,
        'adminId': adminId,
        'content': content,
        'createdAt': createdAt.toIso8601String(),
      });

      if (response.statusCode! >= 200 && response.statusCode! <= 300) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log(e.toString());
      return false;
    }
  }
}
