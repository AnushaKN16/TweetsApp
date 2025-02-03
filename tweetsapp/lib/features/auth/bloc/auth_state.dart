import 'package:equatable/equatable.dart';

sealed class AuthState {}

final class AuthInitialState extends AuthState {}

abstract class AuthActionState extends AuthState {}

class AuthErrorState extends AuthActionState {
  final String error;

  AuthErrorState({required this.error});
}

class AuthSuccessState extends AuthActionState {}
