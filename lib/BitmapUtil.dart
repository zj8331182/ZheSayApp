import 'dart:async';
import 'dart:collection';
import 'dart:typed_data';
import 'dart:ui' as UI;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as ui;

Future<Color> getMajorColor(UI.Image bitmap) async {
  ByteData byteData = await bitmap.toByteData();
  var threshold = 30;
  var byteOffset = 0;
  var avgHue = 0;
  for (int h = 0; h < bitmap.height; h++) {
    for (int w = 0; w < bitmap.width; w++) {
      var hue = byteData.getUint32(byteOffset);
      avgHue = (avgHue * byteOffset + hue) ~/ (byteOffset + 1);
    }
  }

  byteOffset = 0;
  Map<int, int> colors = SplayTreeMap();

  for (int h = 0; h < bitmap.height; h++) {
    for (int w = 0; w < bitmap.width; w++) {
      int hue = byteData.getUint32(byteOffset);
      //如果色差大于阈值，则加入列表
      if ((hue - avgHue).abs() > threshold) {
        if (colors.containsKey(hue)) {
          colors[hue] += 1;
        } else {
          colors[hue] = 1;
        }
      }
      byteOffset += 1;
    }
  }
  if (colors.isEmpty) {
    print("isEmpty");
    return Colors.black;
  }
  List<MapEntry> result = colors.entries.toList();
  result.sort((a, b) => a.value - b.value);
  return Color(result[result.length - 1].key);
}

Color getReverseColor(Color color) {
  var red = 0xFF - color.red;
  var green = 0xFF - color.green;
  var blue = 0xFF - color.blue;
  Color c = Color.fromARGB(color.alpha, red, green, blue);
  return c;
}

Future<UI.Image> loadImage(String imageUrl) {
  ImageStream stream = imageUrl.startsWith("http")
      ? NetworkImage(imageUrl).resolve(ImageConfiguration.empty)
      : AssetImage(imageUrl, bundle: getAssetBundle())
          .resolve(ImageConfiguration.empty);
  Completer<UI.Image> completer = new Completer<UI.Image>();
  ImageStreamListener l;
  l = ImageStreamListener((ImageInfo frame, bool synchronousCall) {
    UI.Image image = frame.image;
    completer.complete(image);
    stream.removeListener(l);
  });
  stream.addListener(l);
  return completer.future;
}

getAssetBundle() =>
    ui.rootBundle != null ? ui.rootBundle : ui.NetworkAssetBundle(Uri.base);
