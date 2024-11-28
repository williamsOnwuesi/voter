import 'package:flutter/material.dart';
import 'package:voter/pages/authentication/login.dart';
import 'package:voter/pages/authentication/sign_up.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;

  @override
  Widget build(BuildContext context) {
    if (isLogin == true) {
      return LoginPage(switchToSignUp: toggle);
    } else {
      return SignUp(switchToLogin: toggle);
    }
  }

  void toggle() => setState(() => isLogin = !isLogin);
}
