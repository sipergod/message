import 'dart:math';
import 'package:flutter/material.dart';

class AnimationPageEvent {
  State state;
  AnimationPageEvent(this.state);

  Duration duration = new Duration(seconds: 2);
  Curve curve = Curves.easeOut;
  bool crossFadeState = true;
  late double width;
  late double height;
  late Color color;
  late Color textColor;
  late BorderRadius borderRadius;

  late AnimationController controller;
  late Animation<double> animation;
  late Animation<Offset> offsetAnimation;

  DecorationTween decorationTween = DecorationTween(
    begin: BoxDecoration(
      color: ThemeData.dark().backgroundColor,
      border: Border.all(style: BorderStyle.none),
      borderRadius: BorderRadius.circular(60.0),
      shape: BoxShape.rectangle,
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x66666666),
          blurRadius: 10.0,
          spreadRadius: 3.0,
          offset: Offset(0, 6.0),
        )
      ],
    ),
    end: BoxDecoration(
      color: ThemeData.dark().backgroundColor,
      border: Border.all(
        style: BorderStyle.none,
      ),
      borderRadius: BorderRadius.zero,
      // No shadow.
    ),
  );

  void preLoad() {
    doContainerAnimation();
  }

  void doContainerAnimation() {
    state.setState(() {
      final random = Random();

      // Generate a random width and height from 50 to 250.
      width = random.nextInt(250).toDouble() + 50;
      height = random.nextInt(250).toDouble() + 50;

      // Generate a random color.
      color = Color.fromRGBO(
        random.nextInt(256),
        random.nextInt(256),
        random.nextInt(256),
        1,
      );

      textColor = Color.fromRGBO(
        random.nextInt(256),
        random.nextInt(256),
        random.nextInt(256),
        1,
      );

      // Generate a random border radius.
      borderRadius = BorderRadius.circular(random.nextInt(100).toDouble());

      crossFadeState = !crossFadeState;
    });
  }

  AlignmentGeometry randomAlignment() {
    int index = Random().nextInt(9);
    switch (index) {
      case 0:
        return Alignment.centerLeft;
      case 1:
        return Alignment.centerRight;
      case 2:
        return Alignment.center;
      case 3:
        return Alignment.bottomCenter;
      case 4:
        return Alignment.topCenter;
      case 5:
        return Alignment.bottomLeft;
      case 6:
        return Alignment.bottomRight;
      case 7:
        return Alignment.topLeft;
      case 8:
        return Alignment.topRight;
      default:
        return Alignment.center;
    }
  }
}
