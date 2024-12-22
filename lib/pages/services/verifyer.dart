import 'package:cloud_firestore/cloud_firestore.dart';

class Verifier {
  Future<bool> checkIfRegNoIsAttached(String regNo) async {
    final isAttached = await FirebaseFirestore.instance
        .collection("registered_users_data")
        .where("regNo", isEqualTo: regNo)
        .get();

    return isAttached.size >= 1 ? true : false;
  }

  Future<bool> checkIfVoterIsAccredited(String regNo) async {
    final isAccredited = await FirebaseFirestore.instance
        .collection("accredited_users_data")
        .where("regNo", isEqualTo: regNo)
        .get();

    // print(isAccredited.toString());

    return isAccredited.size >= 1 ? true : false;
  }
}
