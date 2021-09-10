import 'package:flutter/material.dart';
import 'package:message/Static/Constants.dart';

class BottomTabBarWithFilterWidget extends StatefulWidget {
  final List<Map<String, dynamic>> listTab;
  final List<Map<String, dynamic>> listFilter;
  final TabController tabController;
  final Widget filterIcon;
  final Function filterItemBuilder;
  final Function? filterIconClickFunction;
  final Function? buildNotice;

  BottomTabBarWithFilterWidget({
    Key? key,
    required this.listTab,
    required this.listFilter,
    required this.tabController,
    required this.filterIcon,
    required this.filterItemBuilder,
    this.filterIconClickFunction,
    this.buildNotice,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _BottomTabBarWithFilterWidgetState();
}

class _BottomTabBarWithFilterWidgetState
    extends State<BottomTabBarWithFilterWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return buildBottomTabBar();
  }

  Widget buildBottomTabBar() {
    return Container(
      padding: EdgeInsets.all(0.0),
      // color: StyleSheet.primaryColor,
      width: double.infinity,
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.only(
                left: Constants.paddingSmall,
                right: Constants.paddingSmall,
              ),
              // ignore: deprecated_member_use
              child: FlatButton(
                padding: EdgeInsets.all(0.0),
                child: widget.filterIcon,
                onPressed: () {
                  if (widget.filterIconClickFunction == null) {
                    showFilterSelector();
                  } else {
                    widget.filterIconClickFunction!();
                  }
                },
              ),
            ),
          ),
          Expanded(
            flex: 9,
            child: TabBar(
              controller: widget.tabController,
              isScrollable: widget.listTab.length > 2,
              tabs: widget.listTab.map((Map<String, dynamic> item) {
                return Tab(
                  child: Container(
                    child: Text(
                      item['snb-lang'],
                    ),
                  ),
                );
              }).toList(),
              indicatorColor: Theme.of(context).colorScheme.secondary,
            ),
          )
        ],
      ),
    );
  }

  void showFilterSelector() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                new Container(
                  width: double.infinity,
                  color: Theme.of(context).colorScheme.secondary,
                  padding: EdgeInsets.all(Constants.paddingSmall),
                  child: Text('Filter by',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                      )),
                ),
                Flexible(
                  child: ListView(
                    children: <Widget>[
                      new Wrap(
                        children: widget.listFilter.map((item) {
                          Widget itemWidget = widget.filterItemBuilder(item);
                          return itemWidget;
                        }).toList(),
                      ),
                    ],
                  ),
                ),
                buildNoticeItem(),
              ],
            ),
          );
        });
  }

  Widget buildNoticeItem() {
    Widget item = Container();
    if (widget.buildNotice != null) {
      item = widget.buildNotice!();
    }

    return item;
  }
}
