import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import 'BitmapUtil.dart';

Widget getDailyPage(_imageUrl, _mainColor, _content) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      Expanded(
          flex: 5,
          child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              child: FadeInImage.assetNetwork(
                  placeholder: "image/1.jpg",
                  image: _imageUrl,
                  fit: BoxFit.cover))),
      Expanded(
        flex: 4,
        child: Center(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
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
                          getCurrentTime(),
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
                      "安",
                      style: TextStyle(
                          fontSize: 50,
                          color: _mainColor,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                color: _mainColor,
                width: 2,
                height: 175,
              ),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                child: AutoSizeText(
                  _content,
                  style: TextStyle(
                      fontSize: 20, color: getReverseColor(_mainColor)),
                  softWrap: true,
                ),
              ))
            ],
          ),
        ),
      )
    ],
  );
}

String getCurrentTime() {
  int dateTime = DateTime.now().hour;
  if (dateTime < 10) {
    return "早";
  } else if (dateTime < 20) {
    return "午";
  } else {
    return "晚";
  }
}
