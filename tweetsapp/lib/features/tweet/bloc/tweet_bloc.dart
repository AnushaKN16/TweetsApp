import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweetsapp/features/tweet/bloc/tweet_event.dart';
import 'package:tweetsapp/features/tweet/bloc/tweet_state.dart';
import 'package:tweetsapp/features/tweet/model/tweet_model.dart';
import 'package:tweetsapp/features/tweet/repo/tweet_repo.dart';

class TweetsBloc extends Bloc<TweetEvent, TweetState> {
  TweetsBloc() : super(TweetInitial()) {
    on<TweetInitialFetchEvent>(tweetInitialFetchEvent);
  }

  FutureOr<void> tweetInitialFetchEvent(
      TweetInitialFetchEvent event, Emitter<TweetState> emit) async {
    emit(TweetsLoadingState());

    List<TweetModel> tweets = await TweetRepo.getAllTweets();
    emit(TweetsSuccessState(tweets: tweets));
  }
}
