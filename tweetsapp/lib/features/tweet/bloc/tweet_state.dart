import 'package:tweetsapp/features/tweet/model/tweet_model.dart';

sealed class TweetState {}

final class TweetInitial extends TweetState {}

final class TweetsLoadingState extends TweetState {}

final class TweetsSuccessState extends TweetState {
  final List<TweetModel> tweets;

  TweetsSuccessState({required this.tweets});
}

final class TweetsErrorState extends TweetState {}
