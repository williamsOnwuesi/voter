import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:voter/main.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback switchToSignUp;

  const LoginPage({super.key, required this.switchToSignUp});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future loginWithFirebase() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });

    var email = emailController.text;
    var password = passwordController.text;

    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      //
    } on FirebaseAuthException catch (e) {
      // Utils().showSnackBar(e.message);

      var snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
            title: 'Oh Snap!',
            message: '${e.message}',
            contentType: ContentType.failure),
      );

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    }

    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Login Page',
          style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
        ),
        backgroundColor: const Color.fromARGB(255, 0, 162, 255),
      ),
      body: SafeArea(
        child: Container(
          child: Center(
            child: Column(
              children: [
                const Text('Welcome! Login Here!.'),
                TextFormField(
                  controller: emailController,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(labelText: 'Email'),
                  obscureText: false,
                ),
                const SizedBox(
                  height: 25,
                ),
                TextFormField(
                  controller: passwordController,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                ),
                ElevatedButton(
                    onPressed: () {
                      loginWithFirebase();
                    },
                    child: const Text("Login")),
                RichText(
                    text: TextSpan(
                        style: const TextStyle(
                            color: Color.fromARGB(213, 243, 25, 25),
                            fontSize: 20),
                        text: 'Don\'t have an account yet?   ',
                        children: [
                      TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = widget.switchToSignUp,
                          text: 'Sign Up',
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Theme.of(context).colorScheme.secondary))
                    ])),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
