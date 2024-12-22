import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:email_validator/email_validator.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:voter/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:voter/pages/services/verifyer.dart';

class SignUp extends StatefulWidget {
  final VoidCallback switchToLogin;

  const SignUp({super.key, required this.switchToLogin});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  var formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController regNoController = TextEditingController();

  Future signUpWithFirebase() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) {
      return;
    }

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });

    var email = emailController.text;
    var password = passwordController.text;
    var regNo = regNoController.text;

    Map<String, dynamic> registeredUsersData = {
      'email': email,
      "voted": false,
      "regNo": regNo,
    };

    //print("This user is verified");

    Future<bool> res = Verifier().checkIfRegNoIsAttached(regNo);

    if (await res) {
      print(
          "Sorry your Reg number is already attached to another users account. please contact a NACOSS official.");
      //
      var snackBarError = const SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
            title: 'Oh Snap!',
            message:
                "Sorry this Registration number is already attached. Please visit Naccos office.",
            contentType: ContentType.failure),
      );
      //
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBarError);

      //
    } else {
      print("This Reg number is not attached yet $res");
      //
      try {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        await FirebaseFirestore.instance
            .collection("registered_users_data")
            .doc(email)
            .set(registeredUsersData);

        //
      } on FirebaseAuthException catch (error) {
        var signUpErrorSnackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
              title: 'Oh Snap!',
              message: '${error.message}',
              contentType: ContentType.failure),
        );

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(signUpErrorSnackBar);
      }

      //
    }

    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sign Up Page',
          style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
        ),
        backgroundColor: const Color.fromARGB(255, 4, 255, 59),
      ),
      body: SafeArea(
        child: Container(
          child: Center(
            child: Column(
              children: [
                const Text('You will sign up here.',
                    style: TextStyle(color: Color.fromARGB(255, 10, 211, 3))),
                Form(
                    key: formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: emailController,
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(labelText: 'Email'),
                          obscureText: false,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (email) =>
                              email != null && !EmailValidator.validate(email)
                                  ? 'Please enter a valid email.'
                                  : null,
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        TextFormField(
                          controller: regNoController,
                          textInputAction: TextInputAction.next,
                          decoration:
                              const InputDecoration(labelText: 'Reg Number'),
                          obscureText: false,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) =>
                              value != null && value.length < 5
                                  ? 'Enter minimunm of 5 characters'
                                  : null,
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        TextFormField(
                            controller: passwordController,
                            textInputAction: TextInputAction.next,
                            decoration:
                                const InputDecoration(labelText: 'Password'),
                            obscureText: true,
                            validator: (value) =>
                                value != null && value.length < 5
                                    ? 'Enter minimunm of 5 characters'
                                    : null),
                        const SizedBox(
                          height: 25,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              signUpWithFirebase();
                            },
                            child: const Text("Sign Up"))
                      ],
                    )),
                RichText(
                    text: TextSpan(
                        style: const TextStyle(
                            color: Color.fromARGB(212, 57, 156, 238),
                            fontSize: 20),
                        text: 'Already have an account?   ',
                        children: [
                      TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = widget.switchToLogin,
                          text: 'Log In',
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
