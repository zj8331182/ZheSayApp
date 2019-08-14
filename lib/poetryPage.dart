import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import 'BitmapUtil.dart';

Widget getPoetryPage(
    _mainColor, List tags, String title, dynasty, author, List content) {
  List<String> contentList = List();
  var rep = new RegExp(r"，|。");
  for (String s in content) {
    contentList.addAll(s.split(rep));
  }
  contentList.removeWhere((element) {
    return element == null || element.trim().isEmpty;
  });
  print(contentList);
  return Column(
    children: <Widget>[
      Row(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) =>
                  getItem(context, index, _mainColor, tags),
              itemCount: tags.length,
            ),
          ),
          Column(
            children: <Widget>[
              ClipOval(
                child: Container(
                  width: 75,
                  height: 75,
                  decoration: BoxDecoration(
                    color: _mainColor,
                  ),
                  child: Center(
                    child: Text(
                      "诗",
                      style: TextStyle(
                          fontSize: 50,
                          color: getReverseColor(_mainColor),
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(60, 0, 0, 0),
                child: Text(
                  "词",
                  style: TextStyle(
                      fontSize: 50,
                      color: _mainColor,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ],
          )
        ],
      ),
      Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            AutoSizeText(
              title,
              style: TextStyle(
                fontSize: 40,
                color: getReverseColor(_mainColor),
              ),
              maxLines: 2,
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                "$dynasty $author",
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: getReverseColor(_mainColor)),
                maxLines: 1,
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 32),
              child: ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index) =>
                    getContentItem(context, index, _mainColor, contentList),
                itemCount: contentList.length,
              ),
            )
          ],
        ),
      )
    ],
  );
}

Widget getContentItem(
    BuildContext context, int index, _mainColor, List<String> contents) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0, 8, 16),
      child: AutoSizeText(
        contents[index],
        style: TextStyle(fontSize: 35, color: getReverseColor(_mainColor)),
        maxLines: 1,
      ),
    ),
  );
}

Widget getItem(BuildContext context, int index, _mainColor, List tags) {
  return Stack(
    children: <Widget>[
      AutoSizeText(
        tags[index],
        style: TextStyle(
            fontSize: 25,
            color: _mainColor,
            backgroundColor: getReverseColor(_mainColor)),
      ),
    ],
  );
}
