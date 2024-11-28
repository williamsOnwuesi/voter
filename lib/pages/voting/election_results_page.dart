import 'package:flutter/material.dart';
import 'package:voter/pages/services/database_manager.dart';

class ElectionResultsPage extends StatefulWidget {
  const ElectionResultsPage({super.key});

  @override
  State<ElectionResultsPage> createState() => _ElectionResultsPageState();
}

class _ElectionResultsPageState extends State<ElectionResultsPage> {
  //
  var electionResultsDataList = [];

  void getElectionResultsData() async {
    electionResultsDataList = await DatabaseManager().getElectionResults();

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getElectionResultsData();
  }

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          "Election Results",
          style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
        ),
      ),
      body: SafeArea(
        child: Center(
            child: ListView.builder(
          itemCount: electionResultsDataList.length,
          itemBuilder: (context, index) {
            return Column(children: [
              ListTile(
                leading: const Icon(Icons.flag),
                title: Text(electionResultsDataList[index].name),
                subtitle: Text(electionResultsDataList[index].party),
                trailing: Column(children: [
                  const Text('Votes'),
                  Text(electionResultsDataList[index].votes),
                ]),
                // onTap: () {
                //   // Navigate to user profile page
                //   Navigator.push(context,
                //       MaterialPageRoute(builder: (context) => ProfilePage()));
                // },
              ),
            ]);
          },
        )),
      ),
    );
  }
}
