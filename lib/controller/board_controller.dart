import 'package:get/get.dart';
import 'package:responsive_app/constant/pref_key.dart';
import 'package:responsive_app/repository/board_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/article_model.dart';

class BoardController extends GetxController {
  static BoardController get to => Get.find();

  BoardController({required this.boardRepository});

  final BoardRepository boardRepository;
  final maxKeywords = 5;
  var allArticleList = <Article>[];
  var articleList = <Article>[].obs;
  var searchKeywords = <String>[].obs;
  var enteredText = '';

  @override
  void onInit() async {
    allArticleList = await boardRepository.getAllItems();
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getStringList(searchKeywordsPrefKey) != null) {
      searchKeywords.value = prefs.getStringList(searchKeywordsPrefKey)!;
    }
    if (articleList.isEmpty) {
      articleList.value = allArticleList;
    }
    super.onInit();
  }

  Future<void> searchArticle() async {
    articleList.value = allArticleList.where((element) {
      return element.title!.contains(enteredText) || element.content!.contains(enteredText);
    }).toList();
  }

  Future<void> addArticle(Article newArticle) async {
    articleList.add(newArticle);
  }

  int getLastIndex() {
    return articleList.length;
  }

  void addSearchKeyword(String keyword) async {
    if (keyword.isEmpty) return;
    final prefs = await SharedPreferences.getInstance();
    if (searchKeywords.length == maxKeywords) {
      searchKeywords.removeLast();
    }

    searchKeywords.insert(0, keyword);
    prefs.setStringList(searchKeywordsPrefKey, searchKeywords);
  }

}
