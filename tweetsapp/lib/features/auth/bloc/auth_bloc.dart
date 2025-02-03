import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tweetsapp/app.dart';
import 'package:tweetsapp/core/local_db/shared_preferences.dart';
import 'package:tweetsapp/features/auth/bloc/auth_event.dart';
import 'package:tweetsapp/features/auth/bloc/auth_state.dart';
import 'package:tweetsapp/features/auth/model/user_model.dart';
import 'package:tweetsapp/features/auth/repo/auth_repo.dart';

enum AuthType { login, register }

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitialState()) {
    on<AuthenticationEvent>(authenticationEvent);
  }

  FutureOr<void> authenticationEvent(
      AuthenticationEvent event, Emitter<AuthState> emit) async {
    UserCredential? credential;
    switch (event.authType) {
      case AuthType.login:
        try {
          credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
              email: event.email, password: event.password);
        } on FirebaseAuthException catch (e) {
          if (e.code == 'user-not-found') {
            print('No user found for that email.');
            emit(AuthErrorState(error: 'No user found for that email.'));
          } else if (e.code == 'wrong-password') {
            print('Wrong password provided for that user.');
            emit(AuthErrorState(
                error: 'Wrong password provided for that user.'));
          }
        }
        break;

      case AuthType.register:
        try {
          credential =
              await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: event.email,
            password: event.password,
          );
        } on FirebaseAuthException catch (e) {
          if (e.code == 'weak-password') {
            print('The password provided is too weak.');
            emit(AuthErrorState(error: 'The password provided is too weak.'));
          } else if (e.code == 'email-already-in-use') {
            print('The account already exists for that email.');
            emit(AuthErrorState(
                error: 'The account already exists for that email.'));
          }
        } catch (e) {
          print(e);
        }
    }

    if (credential != null) {
      if (event.authType == AuthType.login) {
        UserModel? userModel =
            await AuthRepo.getUserRepo(credential.user?.uid ?? "");
        if (userModel != null) {
          SharedPreferencesManager.saveUid(credential.user?.uid ?? "");

          RegisterOrLogin.authStream.add(credential.user?.uid ?? "");
          emit(AuthSuccessState());
        } else {
          emit(AuthErrorState(error: "Something went wrong"));
        }
      } else if (event.authType == AuthType.register) {
        bool? success = await AuthRepo.createUserRepo(UserModel(
          uid: credential.user?.uid ?? "",
          tweets: [],
          firstName: '',
          lastNAme: '',
          email: event.email,
          createdAt: DateTime.now(),
        ));
        if (success ?? false) {
          SharedPreferencesManager.saveUid(credential.user?.uid ?? "");
          RegisterOrLogin.authStream.add(credential.user?.uid ?? "");
          emit(AuthSuccessState());
        } else {
          emit(AuthErrorState(error: "Something went wrong"));
        }
      }
    }
  }
}

class AuthInitial {}
