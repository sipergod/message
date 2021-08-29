import 'package:flutter/material.dart';
import 'package:message/Event/PageEvent/MultiTabPageEvent.dart';
import 'package:message/Static/ListBuildItem/ListBottomNavigateItem.dart';
import 'package:message/Static/ListBuildItem/ListTabItem.dart';
import 'package:message/Template/MultiTabTemplate.dart';

class MultiTabPage extends StatefulWidget {
  MultiTabPage({Key? key}) : super(key: key);

  @override
  MultiTabPageState createState() => new MultiTabPageState();
}

class MultiTabPageState extends State<MultiTabPage>
    with TickerProviderStateMixin {
  late MultiTabPageEvent multiTabEvent;

  @override
  void initState() {
    multiTabEvent = new MultiTabPageEvent(this);
    multiTabEvent.tabController = new TabController(
      length: ListTabItem.list.length,
      vsync: this,
    );
    multiTabEvent.preLoad();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiTabTemplate(
      listTab: ListTabItem.list,
      tabController: multiTabEvent.tabController,
      bodyWidget: TabBarView(
        controller: multiTabEvent.tabController,
        children: ListTabItem.list.map((Map<String, dynamic> item) {
          return Center(
            child: Text(
              multiTabEvent.tabController.index.toString(),
            ),
          );
        }).toList(),
        /*[
          Center(
            child: Text(
              multiTabEvent.tabController.index.toString(),
            ),
          ),
        ],*/
      ),
      listBottomNavigateBar: ListBottomNavigateItem.list,
      bottomNavigateBarIndex: 1,
    );
  }
}
