import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> {
  Future showLogoutPopUp() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            content: Container(
              child: Column(children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(Icons.cancel),
                    ),
                  ],
                ),
                const Column(
                  children: [
                    Text(
                      "Are you sure you want to Logout?",
                      style: TextStyle(color: Color.fromRGBO(219, 20, 20, 1)),
                    ),
                    Text(
                      "Click Yes to confirm.",
                      style: TextStyle(color: Color.fromRGBO(63, 74, 236, 1)),
                    ),
                  ],
                ),
                Row(
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 52, 79, 230)),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Cancel',
                          style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255)),
                        )),
                    const Spacer(),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 230, 19, 19)),
                        onPressed: () {
                          logoutApp();
                        },
                        child: const Text(
                          "Yes",
                          style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255)),
                        ))
                  ],
                ),
              ]),
            ),
          ));

  void logoutApp() {
    FirebaseAuth.instance.signOut();
    Navigator.popUntil(context, (route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 7, 123, 255),
          title: const Text(
            'Settings',
            style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
          ),
        ),
        body: SafeArea(
            child: ListView(
          padding: const EdgeInsets.all(8),
          children: <Widget>[
            Container(
              height: 50,
              color: const Color.fromARGB(255, 219, 210, 183),
              child: Center(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 240, 42, 42),
                      ),
                      onPressed: () {
                        showLogoutPopUp();
                      },
                      child: const Text(
                        'Logout',
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255)),
                      ))),
            ),
            Container(
              height: 50,
              color: Colors.amber[500],
              child: const Center(child: Text('Entry B')),
            ),
          ],
        )));
  }
}
