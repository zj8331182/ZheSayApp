import 'dart:async';
import 'dart:ui' as UI;

import 'package:flutter/material.dart';
import 'package:flutter_app/poetryPage.dart';
import 'package:transparent_image/transparent_image.dart';

import 'BitmapUtil.dart';
import 'DotIndicator.dart';
import 'WebModel.dart';
import 'dailyPage.dart';
import 'mainPresent.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '哲说',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blueGrey,
      ),
      home: AppStateContent(),
    );
  }
}

class AppStateContent extends StatefulWidget {
  @override
  _AppStateContentState createState() => _AppStateContentState();
}

class _AppStateContentState extends State<AppStateContent> {
  String _imageUrl = "http";
  var _content = "Test";
  final DateTime _now = new DateTime.now();
  final PageController _controller = PageController();
  Color _mainColor = Colors.blueGrey;
  var _poeTitle;
  var _poeDynasty;
  var _poeAuthor;
  var _poeContent;
  var _poeTrags;

  @override
  void initState() {
    _initData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            new Expanded(
              child: new FadeInImage.memoryNetwork(
                  fit: BoxFit.fitHeight,
                  placeholder: kTransparentImage,
                  image: _imageUrl),
            )
          ],
        ),
        BackdropFilter(
          filter: UI.ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 40, 0, 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  child: Text(
                    _now.year.toString() +
                        " / " +
                        _now.month.toString() +
                        " / " +
                        _now.day.toString(),
                    softWrap: false,
                    style: TextStyle(
                        fontSize: 24,
                        decoration: TextDecoration.none,
                        color: getReverseColor(_mainColor)),
                  ),
                  onTap: _initData,
                ),
                Expanded(
                  child: PageView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 3,
                    controller: _controller,
                    itemBuilder: (context, index) {
                      return _createItem(context, index);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: DotsIndicator(
                    controller: _controller,
                    itemCount: 3,
                    onPageSelected: (int page) {
                      _controller.animateTo(page.toDouble(),
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.ease);
                    },
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _createItem(context, index) {
    switch (index) {
      case 0:
        return getItem(getDailyPage(_imageUrl, _mainColor, _content));
      case 1:
        return getItem(getPoetryPage(_mainColor, _poeTrags, _poeTitle,
            _poeDynasty, _poeAuthor, _poeContent));
      case 2:
        return getItem(Container());
      default:
        return getItem(Container());
    }
  }

  getItem(Widget child) {
    return Card(
        color: Color(0x84FFFFFF),
        margin: EdgeInsets.all(20),
        elevation: 5,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: child,
        ));
  }

  Future _initData() async {
    var content = await getDailyContent();
    String imageUrl = content.data["Body"]["img_url"];
    UI.Image bitmap = await loadImage(imageUrl);
    Color col = await getMajorColor(bitmap);
    setState(() {
      print(col);
      _mainColor = col;
      _imageUrl = imageUrl;
      _content = content.data["Body"]["word"];
    });
    var _poeToken = await getPoetryToken();
    var poeContent = await getPoetryContent(_poeToken);
    setState(() {
      _poeTitle = poeContent.data["data"]["origin"]["title"];
      print("Title $_poeTitle");
      _poeAuthor = poeContent.data["data"]["origin"]["author"];
      _poeContent = poeContent.data["data"]["origin"]["content"];
      print("Content $_poeContent");
      print(_poeContent.runtimeType);
      _poeDynasty = poeContent.data["data"]["origin"]["dynasty"];
      _poeTrags = poeContent.data["data"]["matchTags"];
    });
    print(content.data["Body"]);
  }
}
