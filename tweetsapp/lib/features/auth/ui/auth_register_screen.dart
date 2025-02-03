import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweetsapp/design/app_widgets.dart';
import 'package:tweetsapp/features/auth/bloc/auth_bloc.dart';
import 'package:tweetsapp/features/auth/bloc/auth_event.dart';
import 'package:tweetsapp/features/auth/bloc/auth_state.dart';

class AuthRegisterScreen extends StatefulWidget {
  const AuthRegisterScreen({super.key});

  @override
  State<AuthRegisterScreen> createState() => _AuthRegisterScreenState();
}

class _AuthRegisterScreenState extends State<AuthRegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  AuthBloc authBloc = AuthBloc();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLogin = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        title: AppLogo(),
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        bloc: authBloc,
        listenWhen: (previous, current) => current is AuthActionState,
        buildWhen: (previous, current) => current is! AuthActionState,
        listener: (context, state) {
          if (state is AuthErrorState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
          } else if (state is AuthSuccessState) {
            Navigator.popUntil(context, (route) => route.isFirst);
          }
        },
        builder: (contex, state) {
          return Form(
            key: _formKey,
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!isLogin)
                    TextFormField(
                      controller: nameController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter your name";
                        } else {
                          return null;
                        }
                      },
                      decoration: const InputDecoration(hintText: 'Your Name'),
                    ),
                  TextFormField(
                    controller: emailController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter your Email";
                      } else {
                        return null;
                      }
                    },
                    decoration: const InputDecoration(hintText: 'Your Email'),
                  ),
                  TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter your password";
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(hintText: 'Your Password'),
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  SizedBox(
                    width: double.maxFinite,
                    child: ElevatedButton(
                      onPressed: () {
                        authBloc.add(AuthenticationEvent(
                            authType:
                                isLogin ? AuthType.login : AuthType.register,
                            email: emailController.text,
                            password: passwordController.text));
                      },
                      child: Text(isLogin ? "Login" : "Register"),
                    ),
                  ),
                  Row(
                    children: [
                      Text(isLogin
                          ? "Don't have an account?"
                          : "Already having an account?"),
                      InkWell(
                          onTap: () {
                            setState(() {
                              isLogin = !isLogin;
                            });
                            print("bool,$isLogin");
                          },
                          child: Text(
                            !isLogin ? "Login" : "Register",
                            style: TextStyle(color: Colors.deepPurple.shade200),
                          )),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
