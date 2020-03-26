import 'package:flutter/material.dart';

class CircleLogin extends StatelessWidget {
  final double radius;
  final List<Color> colors;

  const CircleLogin({Key key, @required this.radius, @required this.colors})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: this.radius * 2,
        height: this.radius * 2,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(this.radius),
            gradient: LinearGradient(
              colors: this.colors,
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
            )));
  }
}
