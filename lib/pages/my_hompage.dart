import 'package:flutter/material.dart';
import 'package:voter/api_models/news.api.dart';
import 'package:voter/api_models/news.dart';
import 'package:voter/pages/voting/widgets/news_card.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //start news integration.
  List<News> _news = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    getNews();
  }

  Future<void> getNews() async {
    _news = await NewsApi.getNews();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        // backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        backgroundColor: Colors.green,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(
          widget.title,
          style: const TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
        ),
      ),

      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _news.length,
              itemBuilder: (context, index) {
                return NewsCard(
                    title: _news[index].name.toString(),
                    cookTime: _news[index].totalTime.toString(),
                    rating: _news[index].rating.toString(),
                    thumbnailUrl: _news[index].images.toString());
              },
            ),

      // This trailing comma makes auto-formatting nicer for build methods.
      bottomNavigationBar: BottomAppBar(
        color: Colors.amber,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/admin');
                },
                icon: const Column(children: [
                  Icon(
                    Icons.admin_panel_settings_outlined,
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                  Text(
                    'Admin',
                    style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontSize: 10,
                    ),
                  )
                ])),
            FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, '/voting');
              },
              backgroundColor: const Color.fromARGB(255, 97, 207, 6),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              child: const Icon(
                Icons.how_to_vote_rounded,
                color: Color.fromARGB(255, 255, 255, 255),
              ),
            ),
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/settings');
                },
                icon: const Column(children: [
                  Icon(
                    Icons.settings,
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                  Text(
                    'Settings',
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
