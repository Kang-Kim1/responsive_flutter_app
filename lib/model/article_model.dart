
class Article {
  int? id;
  String? userName;
  String? title;
  String? content;
  String? newsLink;
  String? dateTime;
  String? company;
  String? category;
  String? imageUrl;
  int? subscribeCount;

  Article(
      {this.id,
        this.userName,
        this.title,
        this.content,
        this.newsLink,
        this.dateTime,
        this.company,
        this.category,
        this.imageUrl,
        this.subscribeCount});

  Article.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['username'];
    title = json['title'];
    content = json['content'];
    newsLink = json['newsLink'];
    dateTime = json['dateTime'];
    company = json['company'];
    category = json['category'];
    imageUrl = json['imageUrl'];
    subscribeCount = json['subscribeCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = data;
    data['username'] = userName;
    data['title'] = title;
    data['content'] = content;
    data['newsLink'] = newsLink;
    data['dateTime'] = dateTime;
    data['company'] = company;
    data['category'] = category;
    data['imageUrl'] = imageUrl;
    data['subscribeCount'] = subscribeCount;

    return data;
  }
}