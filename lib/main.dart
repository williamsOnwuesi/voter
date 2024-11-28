import 'package:flutter/material.dart';
import 'package:voter/pages/my_hompage.dart';
import 'package:voter/pages/start_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:voter/firebase_options.dart';
import 'package:voter/pages/voting/admin_page.dart';
import 'package:voter/pages/voting/election_results_page.dart';
import 'package:voter/pages/voting/settings_page.dart';
import 'package:voter/pages/voting/voting_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Voting App',
        navigatorKey: navigatorKey,
        theme: ThemeData(
          // This is the theme of your application.
          //
          // TRY THIS: Try running your application with "flutter run". You'll see
          // the application has a purple toolbar. Then, without quitting the app,
          // try changing the seedColor in the colorScheme below to Colors.green
          // and then invoke "hot reload" (save your changes or press the "hot
          // reload" button in a Flutter-supported IDE, or press "r" if you used
          // the command line to start the app).
          //
          // Notice that the counter didn't reset back to zero; the application
          // state is not lost during the reload. To reset the state, use hot
          // restart instead.
          //
          // This works for code too, not just values: Most code changes can be
          // tested with just a hot reload.
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const StartPage(),
        routes: {
          '/voting': (context) => const VotingPage(),
          '/home': (context) => const MyHomePage(title: 'Special Voting App'),
          '/settings': (context) => const SettingsPage(),
          '/admin': (context) => const AdminPage(),
          '/election_results': (context) => const ElectionResultsPage(),
        });
  }
}
