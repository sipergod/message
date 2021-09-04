import 'package:flutter/material.dart';

class MultiTabPageEvent {
  State state;
  Function setStateFunc;
  MultiTabPageEvent(this.state, this.setStateFunc);

  late TabController tabController;
  int currentTabIndex = 0;

  void preLoad() {
    tabController.addListener(() {
      if (tabController.index != tabController.previousIndex) {
        setStateFunc(() {
          currentTabIndex = tabController.index;
        });
      }
    });
  }
}
