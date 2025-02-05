import 'package:flutter/foundation.dart';

@immutable
sealed class CreateTweetEvent {}

class PostTweetEvent extends CreateTweetEvent {
  final String content;

  PostTweetEvent({required this.content});
}
