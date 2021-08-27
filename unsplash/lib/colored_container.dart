import 'package:flutter/material.dart';
//unused
class ColoredContainer extends StatelessWidget {
  ColoredContainer(this._isContainerVisible);
  final bool _isContainerVisible;
  var link;
  @override
    Widget build(BuildContext context) {
      return Center (
        child: Image.network(link),
      );
    }

}