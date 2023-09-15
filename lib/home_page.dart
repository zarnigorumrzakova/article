import 'dart:convert';
import 'package:article/details_page.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'article.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;
  List<Article> _article = [];
  late RefreshController refreshController;

  @override
  void initState() {
    super.initState();
    refreshController = RefreshController();
    _initialFetchArticles();
  }

  Future<void> _initialFetchArticles() async {
    setState(() {
      isLoading = true;
    });
    final Uri url = Uri.https('jsonplaceholder.typicode.com', '/posts');
    final response = await http.get(url);
    final List<dynamic> jsonList = json.decode(response.body);
    setState(() {
      _article = jsonList.map((json) => Article.fromJson(json)).toList();
      isLoading = false;
    });
    refreshController.loadComplete();

  }
  Future<void> refreshArticle() async {
    final Uri url = Uri.https('jsonplaceholder.typicode.com', '/posts');
    final response = await http.get(url);
    final List<dynamic> jsonList = json.decode(response.body);
    setState(() {
      _article = jsonList.map((json) => Article.fromJson(json)).toList();
    });
    refreshController.refreshCompleted();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    refreshController.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Article'),
      ),
      body: isLoading
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : SmartRefresher(
        enablePullUp: true,
        onLoading: _initialFetchArticles,
        onRefresh: refreshArticle,
        controller: refreshController,
        child: ListView.builder(
            itemCount: _article.length,
            itemBuilder: (context, index) {
              return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) =>
                                DetailsPage(article: _article[index])));
                  },
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.black12),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                              blurRadius: 7,
                              spreadRadius: 4,
                              color: Colors.grey)
                        ]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('#${_article[index].id}',
                            style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                                color: Colors.blue)),
                        Text(
                          '${_article[index].title}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ));
            }),
      ),
    );
  }
}
