import 'package:flutter/material.dart';

class MultiTabPageEvent {
  State state;
  MultiTabPageEvent(this.state);

  late TabController tabController;
  int currentTabIndex = 0;

  void preLoad() {
    tabController.addListener(() {
      if (tabController.index != tabController.previousIndex) {
        state.setState(() {
          currentTabIndex = tabController.index;
        });
      }
    });
  }
}
