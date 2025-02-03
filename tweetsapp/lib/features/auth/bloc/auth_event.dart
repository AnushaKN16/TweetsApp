import 'package:equatable/equatable.dart';
import 'package:tweetsapp/features/auth/bloc/auth_bloc.dart';

sealed class AuthEvent {}

class AuthenticationEvent extends AuthEvent {
  final AuthType authType;
  final String email;
  final String password;

  AuthenticationEvent(
      {required this.authType, required this.email, required this.password});
}
