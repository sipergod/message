import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PublicFunctionEvent {
  void addScrollListener(
    ScrollController controller,
    Function loadMoreFunc,
    Function setVisible,
    Function setInvisible,
  ) {
    controller.addListener(() {
      if (controller.offset >= controller.position.maxScrollExtent &&
          !controller.position.outOfRange) {
        loadMoreFunc();
      }

      if (controller.position.userScrollDirection == ScrollDirection.reverse) {
        setVisible();
      } else if (controller.position.userScrollDirection ==
          ScrollDirection.forward) {
        setInvisible();
      }
    });
  }

  static Future<bool> onWillPop(DateTime? currentBackPressTime) {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(msg: 'Click twice to exit app');
      return Future.value(false);
    }
    return Future.value(true);
  }
}
