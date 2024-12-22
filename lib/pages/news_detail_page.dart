import 'package:flutter/material.dart';

class NewsDetailPage extends StatelessWidget {
  final String newsTitle;
  final String newsURL;
  final String thumbnailUrl;

  const NewsDetailPage({
    super.key,
    required this.newsTitle,
    required this.newsURL,
    required this.thumbnailUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(newsTitle),
        Text(newsURL),
        Text(thumbnailUrl),
      ],
    );
  }
}
