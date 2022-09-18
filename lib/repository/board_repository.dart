import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:responsive_app/model/article_model.dart';

abstract class BoardRepository {
  Future<List<Article>> getAllItems();
}

class BoardRepositoryImpl implements BoardRepository {
  @override
  Future<List<Article>> getAllItems() async {
      var dio = Dio();
      var response = await dio.get('https://raw.githubusercontent.com/doznAvokado/flutter_web_task/master/data.json');

      var articleList = <Article>[];
      json.decode(response.data)['data'].forEach((article) {
        articleList.add(Article.fromJson(article));
      });
    return articleList;
  }
}
