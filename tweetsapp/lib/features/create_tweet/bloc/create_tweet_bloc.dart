import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweetsapp/features/create_tweet/bloc/create_tweet_event.dart';
import 'package:tweetsapp/features/create_tweet/bloc/create_tweet_state.dart';
import 'package:tweetsapp/features/create_tweet/repo/create_tweet_repo.dart';
import 'package:uuid/uuid.dart';

class CreateTweetBloc extends Bloc<CreateTweetEvent, CreateTweetState> {
  CreateTweetBloc() : super(CreateTweetInitial()) {
    on<PostTweetEvent>(postTweet);
  }

  FutureOr<void> postTweet(
      PostTweetEvent event, Emitter<CreateTweetState> emit) async {
    emit(CreateTweetLoadingState());
    final uuid = Uuid().v1();
    final String curUserId = FirebaseAuth.instance.currentUser?.uid ?? "";
    bool success = await CreateTweetRepo.postTweetRepo(
        uuid, curUserId, event.content, DateTime.now());

    if (success) {
      emit(CreateTweetSuccessState());
    } else {
      emit(CreateTweetErrorState());
    }
  }
}
