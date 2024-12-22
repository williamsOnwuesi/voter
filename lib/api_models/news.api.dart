import 'package:http/http.dart' as http;
import 'package:voter/api_models/news.dart';
import 'dart:convert';
// import 'package:voting_app/api_models/news.dart';

class NewsApi {
  static Future<List<News>> getNews() async {
    // var uri = Uri.https('yummly2.p.rapidapi.com', '/feeds/list',
    //     {"limit": "18", "start": "0", "tag": "list.recipe.popular"});

    // final response = await http.get(uri, headers: {
    //   "x-rapidapi-key": "fa13dbe4c5msh02ac0fc2e696d06p13efd7jsn2244cd2894e3",
    //   "x-rapidapi-host": "yummly2.p.rapidapi.com",
    //   "useQueryString": "true"
    // });

    // print(response.toString());

    // Map data = jsonDecode(response.body);
    // List temp = [];

    //News Start

    //st

    const String baseUrl =
        'https://newsapi.org/v2/top-headlines?category=politics&apiKey=c0ee93f435ae49c7b86a0826ceaaf33e';

    var client = http.Client();

    var url = Uri.parse(baseUrl);

    // var requestHeaders = {
    //   'Authorization': 'Bearer sfie328370428387=',
    //   'api_key': 'ief873fj38uf38uf83u839898989',
    // };

    var res = await client.get(url);
    Map dataN = jsonDecode(res.body);

    List tempN = [];

    // print(dataN);

    //en

    for (var i in dataN['articles']) {
      // print(i['title']);
      // print(i);
      tempN.add(i);
    }

    //News End
    // print(data);

    // for (var i in data['feed']) {
    //   // print(i['content']['details']);
    //   temp.add(i['content']['details']);
    // }

    return News.newsFromSnapshot(tempN);
    // return News.newsFromSnapshot(temp);
  }
}
