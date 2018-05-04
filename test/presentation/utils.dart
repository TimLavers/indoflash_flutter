import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

String textForKey(Key key) {
  var byKey = find.byKey(key);
  StatelessElement element = (byKey.evaluate().first as StatelessElement);
  var build = element.build();
  RichText richText = build as RichText;
  return richText.text.text;
}

String iconForKey(Key key) {
  var byKey = find.byKey(key);
  StatelessElement element = (byKey.evaluate().first as StatelessElement);
  var build = element.build();
  var image = (build as RawMaterialButton).child as Image;
  return (image.image as AssetImage).assetName;
}
