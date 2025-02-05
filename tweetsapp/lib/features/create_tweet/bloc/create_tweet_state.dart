import 'package:flutter/foundation.dart';

@immutable
sealed class CreateTweetState {}

final class CreateTweetInitial extends CreateTweetState {}

final class CreateTweetActionState extends CreateTweetState {}

final class CreateTweetLoadingState extends CreateTweetActionState {}

final class CreateTweetSuccessState extends CreateTweetActionState {}

final class CreateTweetErrorState extends CreateTweetActionState {}
