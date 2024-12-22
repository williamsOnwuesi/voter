import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ulid/ulid.dart';
import 'package:voter/pages/services/database_manager.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:voter/pages/services/verifyer.dart';

class CandidateCard extends StatelessWidget {
  final String title;
  final String rating;
  final String cookTime;
  final dynamic votedStatus;
  final String thumbnailUrl;

  CandidateCard({
    super.key,
    required this.title,
    required this.cookTime,
    required this.rating,
    required this.votedStatus,
    required this.thumbnailUrl,
  });

  String? authenticatedUserEmail;
  String? authenticatedUserRegNo;

  void getAuthenticatedUserEmail() async {
    //
    final FirebaseAuth auth = FirebaseAuth.instance;
    var user = auth.currentUser;

    authenticatedUserEmail = user?.email;

    DocumentSnapshot<Map<String, dynamic>> authenticatedUserData =
        await FirebaseFirestore.instance
            .collection("registered_users_data")
            .doc(authenticatedUserEmail)
            .get();

    authenticatedUserRegNo = authenticatedUserData.data()!['regNo'];
  }

  @override
  Widget build(BuildContext context) {
    getAuthenticatedUserEmail();
    //
    void castNewVote() async {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return const Center(child: CircularProgressIndicator());
          });
      //
      var randomId = Ulid().toUuid();

      Map<String, dynamic> registrationData = {
        "candidate": cookTime,
        'party': rating,
        "id": randomId,
      };

      Map<String, dynamic> votedStatusData = {
        "email": authenticatedUserEmail,
        'voted': 'true',
      };

      await DatabaseManager()
          .castVote(registrationData, authenticatedUserEmail.toString())
          .then((res) => {
                DatabaseManager().changeVotedStatuesToTrue(
                    votedStatusData, authenticatedUserEmail.toString())
              });

      //
      var snackBar = const SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
            title: 'Congratulations!',
            message:
                'You have successfully voted in this election. Thanks for participating.',
            contentType: ContentType.success),
      );

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);

      Navigator.pushNamed(context, '/voting');
    }

    //
    //
    //
    Future showConfirmVotePopUp() => showDialog(
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
                        "Are you sure you want to vote this candidate. You can not reverse this action!!!.",
                        style: TextStyle(color: Color.fromARGB(255, 253, 2, 2)),
                      ),
                      Text(
                        "Click Yes to continue",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "Cancel",
                            style: TextStyle(
                                color: Color.fromARGB(255, 2, 121, 218)),
                          )),
                      const Spacer(),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 241, 12, 12)),
                          onPressed: () {
                            castNewVote();
                          },
                          child: const Text(
                            "YES",
                            style: TextStyle(color: Colors.white),
                          ))
                    ],
                  ),
                ]),
              ),
            ));
    //
    //
    //
    void displayVotedMessage() {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return const Center(child: CircularProgressIndicator());
          });
      //
      //
      var snackBar = const SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
            title: 'Oh Snap!',
            message:
                'You have already voted in this election. Thanks for participating',
            contentType: ContentType.failure),
      );

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);

      Navigator.pop(context);
    }

    void beginVotingProcess() async {
      //
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return const Center(child: CircularProgressIndicator());
          });
      //
      var snackBar = const SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
            title: 'Not Yet Accredited!!!',
            message:
                'Sorry You are not yet an Accredited voter. Please visit Nacoss office for clarifications!!!.',
            contentType: ContentType.failure),
      );
      //
      var res = Verifier()
          .checkIfVoterIsAccredited(authenticatedUserRegNo.toString());

      if (await res) {
        Navigator.pop(context);
        showConfirmVotePopUp();
      } else {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
        // Navigator.pop(context);
      }
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
      width: MediaQuery.of(context).size.width,
      height: 180,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.6),
            offset: const Offset(
              0.0,
              10.0,
            ),
            blurRadius: 10.0,
            spreadRadius: -6.0,
          ),
        ],
        image: DecorationImage(
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.35),
            BlendMode.multiply,
          ),
          image: NetworkImage(thumbnailUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 19,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(5),
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: Colors.yellow,
                        size: 18,
                      ),
                      const SizedBox(width: 7),
                      Text(
                        rating,
                        style: const TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255)),
                      ),
                    ],
                  ),
                ),
                Container(
                    child: votedStatus != null && votedStatus != "true"
                        ? ElevatedButton(
                            onPressed: () {
                              beginVotingProcess();
                            },
                            child: const Text('Cast Vote'))
                        : ElevatedButton(
                            onPressed: () {
                              displayVotedMessage();
                            },
                            child: const Text('Voted'),
                          ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
