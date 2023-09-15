import 'package:flutter/material.dart';
import 'package:article/article.dart';

class DetailsPage extends StatelessWidget {
  final Article article;

  const DetailsPage({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Article Body',
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
            width: 20,
          ),
          Container(
            margin: const EdgeInsets.all(15),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [BoxShadow(blurRadius: 8, spreadRadius: 2)],
                color: Colors.white70),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '#${article.id}',
                  style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 22,
                      color: Colors.blue),
                ),
                Text(
                  '${article.body}',
                  style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
