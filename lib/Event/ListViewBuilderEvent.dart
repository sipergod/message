import 'package:flutter/material.dart';

import 'PublicFunctionEvent.dart';

class ListViewBuilderEvent {
  State state;
  ListViewBuilderEvent(this.state);

  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  ScrollController scrollController = new ScrollController();

  bool isLoading = false;
  bool floatingButtonVisibility = false;
  int currentPageNum = 1;

  List<Map<String, dynamic>> listData = [];

  void setScaffoldKey(GlobalKey<ScaffoldState> key) {
    scaffoldKey = key;
  }

  void preLoad() {
    addScrollListener();
  }

  void addScrollListener() {
    PublicFunctionEvent().addScrollListener(
      scrollController,
      () {
        loadList(currentPageNum + 1);
      },
      () {},
      () {},
    );
  }

  Future<void> loadList(int pageNum) async {
    if(pageNum != 1) {
      state.setState(() {
        isLoading = true;
      });
    }
    await testLoadList(pageNum).then((value) {
      state.setState(() {
        isLoading = false;
      });
    });
  }

  Future<void> testLoadList(int pageNum) async {
    await Future.delayed(Duration(seconds: 1));
    if (pageNum == 1) {
      state.setState(() {
        listData = List<Map<String, dynamic>>.generate(
          50,
          (i) => i % 6 == 0
              ? {i.toString(): Text('Heading $i')}
              : {i.toString(): Text('Sender $i ' 'Message body $i')},
        );
      });
      print('Do refresh list\n');
    } else {
      List<Map<String, dynamic>>.generate(
        50,
        (i) => (listData.length + i) % 6 == 0
            ? {
                (listData.length + i).toString():
                    Text('Heading ${listData.length + i}')
              }
            : {
                (listData.length + i).toString():
                    Text('Sender ${listData.length + i} '
                        'Message body ${listData.length + i}')
              },
      ).forEach((element) {
        state.setState(() {
          listData.add(element);
        });
      });
      print('Do func load list\n');
    }
  }
}
