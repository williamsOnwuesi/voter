import 'package:flutter/material.dart';
import 'package:voter/pages/voting/widgets/candidates_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class VotingPage extends StatefulWidget {
  const VotingPage({super.key});

  @override
  State<VotingPage> createState() => _VotingPageState();
}

class _VotingPageState extends State<VotingPage> {
  String? authenticatedUserEmail;
  var votedStatusdata;

  void getAuthenticatedUserEmail() {
    //
    final FirebaseAuth auth = FirebaseAuth.instance;
    var user = auth.currentUser;

    authenticatedUserEmail = user?.email;

    setState(() {});
  }

  void getVotedStatus() async {
    DocumentSnapshot<Map<String, dynamic>> votedStatus = await FirebaseFirestore
        .instance
        .collection("registered_users_data")
        .doc(authenticatedUserEmail)
        .get();

    votedStatusdata = votedStatus.data()!['voted'];

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getAuthenticatedUserEmail();
    getVotedStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Voting Area',
          style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
        ),
        backgroundColor: const Color.fromARGB(255, 248, 170, 3),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(8),
          children: <Widget>[
            Container(
              color: const Color.fromARGB(255, 160, 182, 82),
              child: Center(
                  child: CandidateCard(
                      title: 'Bola Ahmed Tinubu(BAT)',
                      cookTime: 'tinubu',
                      rating: 'APC',
                      votedStatus: votedStatusdata,
                      thumbnailUrl:
                          'https://upload.wikimedia.org/wikipedia/commons/7/77/Bola_Tinubu_portrait.jpg')),
            ),
            Container(
              color: const Color.fromARGB(255, 160, 182, 82),
              child: Center(
                  child: CandidateCard(
                      title: 'Peter Obi',
                      cookTime: 'obi',
                      rating: 'PDP',
                      votedStatus: votedStatusdata,
                      thumbnailUrl:
                          'https://i0.wp.com/media.premiumtimesng.com/wp-content/files/2022/10/78f1dc4e-142f-44e4-a328-f15724fe63d4_peter-obi.jpg?fit=2252%2C1312&ssl=1')),
            ),
            Container(
              color: const Color.fromARGB(255, 160, 182, 82),
              child: Center(
                  child: CandidateCard(
                      title: 'Mohammed Umar Bago',
                      cookTime: 'cookTime',
                      rating: 'APC',
                      votedStatus: votedStatusdata,
                      thumbnailUrl:
                          'https://leadership.ng/wp-content/uploads/2023/12/bago.png')),
            ),
            Container(
              color: const Color.fromARGB(255, 160, 182, 82),
              child: Center(
                  child: CandidateCard(
                      title: 'Abdulkadir Kure',
                      cookTime: 'cookTime',
                      rating: 'PDP',
                      votedStatus: votedStatusdata,
                      thumbnailUrl:
                          'https://www.bellanaija.com/wp-content/uploads/2017/01/pix200811128371265.jpg')),
            ),
            Container(
              height: 50,
              color: const Color.fromARGB(255, 0, 0, 0),
              child: const Center(
                  child: Column(
                children: [
                  Text(
                    'Developer Contact',
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    '08133174091',
                    style: TextStyle(color: Colors.white),
                  )
                ],
              )),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.amber,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/home');
                },
                icon: const Column(children: [
                  Icon(
                    Icons.home_filled,
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                  Text(
                    'Home',
                    style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontSize: 10,
                    ),
                  )
                ])),
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/election_results');
                },
                icon: const Column(children: [
                  Icon(
                    Icons.notes_rounded,
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                  Text(
                    'Results',
                    style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontSize: 10,
                    ),
                  )
                ])),
          ],
        ),
      ),
    );
  }
}
