import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class PublicFunctionEvent {
  void addScrollListener(
      ScrollController controller, Function loadMoreFunc, Function setVisible, Function setInvisible) {
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
}
