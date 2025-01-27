import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tweetsapp/design/app_images.dart';

class AuthRegisterScreen extends StatefulWidget {
  const AuthRegisterScreen({super.key});

  @override
  State<AuthRegisterScreen> createState() => _AuthRegisterScreenState();
}

class _AuthRegisterScreenState extends State<AuthRegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    bool isLogin = true;

    return Scaffold(
      appBar: AppBar(
          leading: Container(),
          title: Container(
            child: SizedBox(
                width: 120,
                height: 40,
                child: SvgPicture.asset(
                  AppImages.logo,
                  color: Colors.white,
                )),
          )),
      body: Form(
        key: _formKey,
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              !isLogin
                  ? TextFormField(
                      controller: nameController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter your name";
                        } else {
                          return null;
                        }
                      },
                      decoration: const InputDecoration(hintText: 'Your Name'),
                    )
                  : TextFormField(
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
                  onPressed: () {},
                  child: Text("Login"),
                ),
              ),
              Row(
                children: [
                  Text(isLogin
                      ? "Don't have an account?"
                      : "Already having an account?"),
                  Text(!isLogin ? "Login" : "Register"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
