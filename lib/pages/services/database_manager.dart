import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseManager {
  final db = FirebaseFirestore.instance;

  //Read Current Election results data from Firebase
  Future getElectionResults() async {
    final tinubuElectionResultsData = await FirebaseFirestore.instance
        .collection("votes")
        .where("candidate", isEqualTo: "tinubu")
        .get();

    final obiElectionResultsData = await FirebaseFirestore.instance
        .collection("votes")
        .where("candidate", isEqualTo: "obi")
        .get();

    // final obiElectionResultsData =
    //     await db.collection("cities").where("capital", isEqualTo: true);

    var tinubuVotes = tinubuElectionResultsData.size;
    var obiVotes = obiElectionResultsData.size;

    print(tinubuVotes);
    print(obiVotes);
    print(tinubuVotes);

    // var data = jsonEncode({
    //   'data': [
    //     {'name': 'tinubu', 'votes': tinubuVotes},
    //     {'name': 'obi', 'votes': obiVotes},
    //     {'name': 'dino melaye', 'votes': tinubuVotes},
    //     {'name': 'obasanjo', 'votes': tinubuVotes},
    //     {'name': 'Atiku', 'votes': tinubuVotes},
    //     {'name': 'Goodluck', 'votes': tinubuVotes},
    //     {'name': 'Yaradua', 'votes': tinubuVotes},
    //     {'name': 'Shettima', 'votes': tinubuVotes},
    //     {'name': 'Wike', 'votes': tinubuVotes},
    //     {'name': 'buhari', 'votes': tinubuVotes},
    //     {'name': 'Datti', 'votes': tinubuVotes},
    //     {'name': 'namadi sambo', 'votes': tinubuVotes},
    //     {'name': 'el-ruffai', 'votes': tinubuVotes},
    //     {'name': 'gabriel suswan', 'votes': tinubuVotes},
    //     {'name': 'kwankwaso', 'votes': tinubuVotes},
    //     {'name': 'samuel orttom', 'votes': tinubuVotes},
    //     {'name': 'abullolo', 'votes': tinubuVotes},
    //     {'name': 'kure', 'votes': tinubuVotes},
    //     {'name': 'funke_akindele', 'votes': tinubuVotes},
    //     {'name': 'tinubu', 'votes': tinubuVotes},
    //   ]
    // });

    var electionResultsList = [];

    var tinubuElectionData = Candidate('Tinubu', 'APC', tinubuVotes.toString());
    var obiElectionData = Candidate('Obi', 'Labour Party', obiVotes.toString());
    var atikuElectionData = Candidate('Atiku', 'PDP', '95');

    // var electionResultsList = [
    //   tinubuElectionData,
    //   obiElectionData,
    //   atikuElectionData
    // ];

    electionResultsList.add(tinubuElectionData);
    electionResultsList.add(obiElectionData);
    electionResultsList.add(atikuElectionData);

    print(electionResultsList);

    return electionResultsList;
  }

  Future castVote(Map<String, dynamic> userRegistrationData, String id) async {
    return await FirebaseFirestore.instance
        .collection("votes")
        .doc(id)
        .set(userRegistrationData);
  }

  void changeVotedStatuesToTrue(
      Map<String, dynamic> statusData, String email) async {
    await FirebaseFirestore.instance
        .collection("registered_users_data")
        .doc(email)
        .set(statusData);
  }
}

class Candidate extends Object {
  String name;
  String party;
  String votes;
  // int example

  Candidate(this.name, this.party, this.votes);
}

// class Person extends Object {
//   int id;
//   String name;

//   Person(this.id, this.name);
// }

// void main() {
//   var person = new Person(1, 'Malik');

//   var PersonsList = [];

//   PersonsList.add(person);
// }
