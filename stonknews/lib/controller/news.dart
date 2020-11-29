import 'dart:convert';

import 'package:stonknews/model/article_model.dart';
import 'package:http/http.dart' as http;

class News{
  List<ArticleModel> news = [];

  Future<void> getNews() async {
    String url = "http://newsapi.org/v2/everything?domains=wsj.com&sortBy=popularity&apiKey=3e3b460e86df4165bf32951420e643b8";

    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);

    if(jsonData['status'] == "ok"){
      jsonData["articles"].forEach((element)
      {
        if(element["urlToImage"] != null && element["description"] != null) {
          ArticleModel articleModel = new ArticleModel(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            url: element['url'],
            urlToImage: element['urlToImage'],
            publishedAt: element['publishedAt'],
            content: element['content']
          );
          news.add(articleModel);
        }
      });
    }

  }


}