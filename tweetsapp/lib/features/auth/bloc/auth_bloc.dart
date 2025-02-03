import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
          log(event.email);
          log(event.password);
          credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
              email: event.email, password: event.password);
        } on FirebaseAuthException catch (e) {
          if (e.code == 'user-not-found') {
            log('No user found for that email.');
            emit(AuthErrorState(error: "No user found for that email."));
          } else if (e.code == 'wrong-password') {
            log('Wrong password provided for that user.');
            emit(AuthErrorState(
                error: "Wrong password provided for that user."));
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
            log('The password provided is too weak.');
            emit(AuthErrorState(error: 'The password provided is too weak.'));
          } else if (e.code == 'email-already-in-use') {
            log('The account already exists for that email.');
            emit(AuthErrorState(
                error: 'The account already exists for that email.'));
          }
        } catch (e) {
          log(e.toString());
          emit(AuthErrorState(error: "Something went wrong"));
        }
    }

    if (credential != null) {
      if (event.authType == AuthType.login) {
        UserModel? userModel =
            await AuthRepo.getUserRepo(credential.user?.uid ?? "");
        if (userModel != null) {
          await SharedPreferencesManager.saveUid(credential.user?.uid ?? "");
          RegisterOrLogin.authStream.add(credential.user?.uid ?? "");
          emit(AuthSuccessState());
        } else {
          emit(AuthErrorState(error: "Something went wrong"));
        }
      } else if (event.authType == AuthType.register) {
        log(credential.user?.uid ?? "");
        bool? success = await AuthRepo.createUserRepo(UserModel(
            uid: credential.user?.uid ?? "",
            tweets: [],
            firstName: "Akshit",
            lastNAme: "Madan",
            email: event.email,
            createdAt: DateTime.now()));
        if (success ?? false) {
          log(credential.user?.uid ?? "");
          await SharedPreferencesManager.saveUid(credential.user?.uid ?? "");
          RegisterOrLogin.authStream.add(credential.user?.uid ?? "");
          emit(AuthSuccessState());
        } else {
          emit(AuthErrorState(error: "Something went wrong"));
        }
      }
    } else {
      log("Credential is null");
      emit(AuthErrorState(error: "Something went wrong"));
    }
  }
}
