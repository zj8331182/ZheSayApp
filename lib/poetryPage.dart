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
      topSpace(_mainColor, tags),
      Expanded(
        child: poetryView(title, _mainColor, dynasty, author, contentList),
      )
    ],
  );
}

Widget topSpace(_mainColor, List tags) {
  return Container(
    height: 150,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Container(
          width: 100,
          child: ListView.builder(
            itemBuilder: (context, index) =>
                getItem(context, index, _mainColor, tags),
            itemCount: tags.length,
          ),
        ),
        Container(
          width: 150,
            child: Column(
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
        ))
      ],
    ),
  );
}

Container poetryView(
    String title, _mainColor, dynasty, author, List<String> contentList) {
  return Container(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        AutoSizeText(
          title,
          style: TextStyle(
            fontSize: 30,
            color: getReverseColor(_mainColor),
          ),
          maxLines: 1,
        ),
        Text(
          "$dynasty $author",
          style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: getReverseColor(_mainColor)),
          maxLines: 1,
        ),
        ListView.builder(
          shrinkWrap: true,
          itemBuilder: (context, index) =>
              getContentItem(context, index, _mainColor, contentList),
          itemCount: contentList.length,
        ),
      ],
    ),
  );
}

Widget getContentItem(
    BuildContext context, int index, _mainColor, List<String> contents) {
  return Center(
    child: AutoSizeText(
      contents[index],
      style: TextStyle(fontSize: 25, color: getReverseColor(_mainColor)),
      maxLines: 1,
    ),
  );
}

Widget getItem(BuildContext context, int index, _mainColor, List tags) {
  return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        child: Container(
          color: getReverseColor(_mainColor),
          width: 100,
          child: Center(
            child: AutoSizeText(
              tags[index],
              style: TextStyle(
                fontSize: 25,
                color: _mainColor,
              ),
            ),
          ),
        ),
      ));
}
