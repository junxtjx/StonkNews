import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Article extends StatefulWidget {

  String articleUrl;
  Article({this.articleUrl});

  @override
  _ArticleState createState() => _ArticleState();
}

class _ArticleState extends State<Article> {

  final Completer<WebViewController> _controller = Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Container(
          transform: Matrix4.translationValues(-16, 0, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Stocks",
                style: TextStyle(
                    color: Colors.blue[600]),),
              Text("News"),
            ],
          ),
        ),
      ),
        body: Container(
          child: WebView(
            initialUrl: widget.articleUrl,
            onWebViewCreated: ((WebViewController webViewController) {
              _controller.complete(webViewController);
            }),
          ),
        ),
    );
  }
}
