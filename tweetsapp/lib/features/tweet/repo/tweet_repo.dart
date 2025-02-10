import 'package:dio/dio.dart';
import 'package:tweetsapp/core/config.dart';
import 'package:tweetsapp/features/tweet/model/tweet_model.dart';

class TweetRepo {
  static Future<List<TweetModel>> getAllTweets() async {
    try {
      Dio dio = Dio();
      final response = await dio.get("${Config.serverUrl}tweet/all");
      List<TweetModel> tweets = [];

      if (response.statusCode! >= 200 && response.statusCode! <= 300) {
        for (int i = 0; i < response.data['data'].length; i++) {
          tweets.add(TweetModel.fromMap(response.data['data'][i]));
        }
      }
      return tweets;
    } catch (e) {
      print(e);
      return [];
    }
  }
}
