import 'package:flutter/material.dart';

class MultiTabPageEvent {
  State state;
  MultiTabPageEvent(this.state);

  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
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
