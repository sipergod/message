import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:message/Static/ApplicationInitSettings.dart';

class PublicFunctionEvent {
  PublicFunctionEvent._();
  static final instance = PublicFunctionEvent._();

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

  Future<bool> onWillPop() {
    DateTime? currentClickTime =
        ApplicationInitSettings.instance.currentBackPressTime;
    DateTime now = DateTime.now();

    if (currentClickTime == null ||
        now.difference(currentClickTime) > Duration(seconds: 2)) {
      ApplicationInitSettings.instance.currentBackPressTime = now;

      Fluttertoast.showToast(msg: 'Click twice to exit app');
      return Future.value(false);
    }
    return Future.value(true);
  }

  Future<bool> exitApp() {
    if (Platform.isAndroid) {
      SystemNavigator.pop();
    } else if (Platform.isIOS) {
      exit(0);
    }
    return Future.value(true);
  }
}
