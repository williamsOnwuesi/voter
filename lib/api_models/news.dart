class News {
  // final String? name;
  // final String? images;
  // final double? rating;
  // final String? totalTime;

  final String? name;
  final String? images;
  final String? rating;
  final String? totalTime;

  News({this.name, this.images, this.rating, this.totalTime});

  factory News.fromJson(dynamic json) {
    // return News(
    //     name: json['name'] as String,
    //     images: json['images'][0]['hostedLargeUrl'] as String,
    //     rating: json['rating'] as double,
    //     totalTime: json['totalTime'] as String);
    return News(
        name: json['title'] as String,
        images: json['urlToImage'] != null
            ? json['urlToImage'] as String
            : 'Unavailable',
        rating:
            json['author'] != null ? json['author'] as String : 'Unavailable',
        totalTime: json['publishedAt'] as String);
  }

  static List<News> newsFromSnapshot(List snapshot) {
    return snapshot.map((data) {
      return News.fromJson(data);
    }).toList();
  }

  @override
  String toString() {
    return 'Recipe {name: $name, image: $images, rating: $rating, totalTime: $totalTime}';
  }
}
