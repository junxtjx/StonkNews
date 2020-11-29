import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:stonknews/controller/data.dart';
import 'package:stonknews/model/article_model.dart';
import 'package:stonknews/model/category_model.dart';
import 'package:stonknews/controller/news.dart';
import 'package:stonknews/views/article.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<CategoryModel> categories = new List<CategoryModel>();
  List<ArticleModel> articles = new List<ArticleModel>();

  bool _loading = true;

  @override
  initState() {
    // TODO: implement initState
    super.initState();
    categories = getCategories();
    getNews();
  }

  getNews() async{
    News news = News();
    await news.getNews();
    articles = news.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Stocks",
                  style: TextStyle(
                  color: Colors.blue[600]),),
            Text("News"),
          ],
        ),
      ),
      body: _loading ? Center(
        child: Container(
          child: CircularProgressIndicator(),
        ),
      ): SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Container(
          child: Column(
            children: <Widget>[

              // News Categories
              Container(
                height : 80,
                child: ListView.builder(
                  itemCount: categories.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index){
                    return Category(
                      imageUrl: categories[index].imageUrl,
                      category: categories[index].category,
                    );
                    }),
              ),
              
              // Articles
              Container(
                  padding: EdgeInsets.fromLTRB(12, 16, 12, 0),
                  child: ListView.builder(
                  itemCount: articles.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index){
                    return ArticleCol(
                        imageUrl: articles[index].urlToImage,
                        title: articles[index].title,
                        desc: articles[index].description,
                        url: articles[index].url
                    );
                  },),
              )

            ],
          ),
        ),
      ),
    );
  }
}

class Category extends StatelessWidget {

  final imageUrl, category;
  Category({this.imageUrl, this.category});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){

    },
      child: Container(
        margin: EdgeInsets.fromLTRB(0, 15, 15, 0),
        child: Stack(
          children: <Widget>[
            ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.network(imageUrl, width:120, height:60, fit: BoxFit.cover)),
            Container(
              alignment: Alignment.center,
              width: 120, height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Colors.black38,
              ),
              child: Text(category, style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500
              ))
            )
          ],
        ),
      ),
    );
  }
}

class ArticleCol extends StatelessWidget {

  final String imageUrl, title, desc, url;

  ArticleCol({this.imageUrl, this.title, this.desc, this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => Article(articleUrl: url,)),);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 34),
        child:
          Column(
            children: <Widget>[
              Image.network(imageUrl),
              Text(title, style: TextStyle(
                fontSize: 18,
                color: Colors.black
              )),
            ],
          ),
      ),
    );
  }
}
