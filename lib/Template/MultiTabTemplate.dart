import 'package:flutter/material.dart';
import 'package:message/Component/Fragment/BottomTabBarWithFilterWidget.dart';
import 'package:message/Template/RootTemplate.dart';

class MultiTabTemplate extends StatefulWidget {
  final GlobalKey<ScaffoldState>? scaffoldKey;
  final String? title;
  final Widget? appBarAction;
  final Widget? drawerMenu;

  final Widget? bottomTabBar;
  final Widget? bodyWidget;
  final List<Map<String, dynamic>>? listBottomNavigateBar;
  final int? bottomNavigateBarIndex;
  final Widget? floatingActionButton;

  final Function? buildNotice;
  final List<Map<String, dynamic>> listTab;
  final TabController? tabController;

  final Widget? filterIcon;
  final List<Map<String, dynamic>>? listFilter;
  final Function? filterIconClickFunction;
  final Function? filterItemBuilder;

  MultiTabTemplate({
    Key? key,
    this.scaffoldKey,
    this.title,
    this.appBarAction,
    this.drawerMenu,
    this.bottomTabBar,
    this.bodyWidget,
    this.listBottomNavigateBar,
    this.bottomNavigateBarIndex,
    this.floatingActionButton,
    this.buildNotice,
    required this.listTab,
    this.tabController,
    this.filterIcon,
    this.listFilter,
    this.filterIconClickFunction,
    this.filterItemBuilder,
  }) : super(key: key);

  @override
  MultiTabTemplateState createState() => new MultiTabTemplateState();
}

class MultiTabTemplateState extends State<MultiTabTemplate> {
  List<Map<String, dynamic>> tempListBottomNavigateBar = [];

  @override
  void initState() {
    if (widget.listBottomNavigateBar != null) {
      tempListBottomNavigateBar = widget.listBottomNavigateBar!;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RootTemplate(
      title: widget.title,
      appBarAction: widget.appBarAction,
      drawerMenu: widget.drawerMenu,
      bottomTabBar: buildBottomTabBar(),
      bodyWidget: widget.bodyWidget,
      bottomNavigateBar: buildBottomNavigateBar(),
      floatingActionButton: widget.floatingActionButton,
      floatingActionButtonLocation: tempListBottomNavigateBar.isNotEmpty
          ? FloatingActionButtonLocation.centerDocked
          : null,
    );
  }

  Widget? buildBottomTabBar() {
    if (widget.listTab.isNotEmpty) {
      if (widget.listFilter != null) {
        if (widget.listFilter!.isNotEmpty) {
          PreferredSize(
            child: BottomTabBarWithFilterWidget(
              filterIcon: buildFilterIcon(),
              listTab: widget.listTab,
              listFilter: widget.listFilter!,
              tabController: widget.tabController!,
              filterItemBuilder: widget.filterItemBuilder!,
              filterIconClickFunction: widget.filterIconClickFunction,
              buildNotice: widget.buildNotice,
            ),
            preferredSize: Size.fromHeight(48.0),
          );
        }
      } else {
        return TabBar(
          controller: widget.tabController,
          isScrollable: widget.listTab.length >= 3,
          tabs: widget.listTab.map((Map<String, dynamic> item) {
            return Tab(
              icon: item['icon'],
              child: Container(
                child: Text(
                  item['text'].toString(),
                ),
              ),
            );
          }).toList(),
          indicatorColor: Colors.orange,
        );
      }
    } else {
      return null;
    }
  }

  Widget buildFilterIcon() {
    return (widget.filterIcon != null)
        ? widget.filterIcon!
        : ImageIcon(
            AssetImage('assets/filter.png'),
            size: 20.0,
            color: Colors.white70,
          );
  }

  Widget? buildBottomNavigateBar() {
    if (tempListBottomNavigateBar.isNotEmpty) {
      return BottomAppBar(
        shape: widget.floatingActionButton != null
            ? CircularNotchedRectangle()
            : null,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: new List<Widget>.generate(
              tempListBottomNavigateBar.length,
              (index) => bottomNavigateItem(
                    index,
                    tempListBottomNavigateBar,
                  )).toList(),
        ),
      );
    } else {
      return null;
    }
  }

  Widget bottomNavigateItem(int index, List<Map<String, dynamic>> listData) {
    if (listData[index].isNotEmpty) {
      return IconButton(
        color: setActive(index),
        tooltip: listData[index]['toolTip'],
        onPressed: () {
          setPressFunc(index, listData[index]['pageName']);
        },
        icon: listData[index]['icon'],
      );
    } else {
      return Spacer();
    }
  }

  bool checkIndex(int i) {
    if (i == widget.bottomNavigateBarIndex)
      return true;
    else
      return false;
  }

  Color setActive(int i) {
    if (checkIndex(i))
      return Colors.orange;
    else
      return Theme.of(context).disabledColor;
  }

  void setPressFunc(int i, String routeName) {
    if (!checkIndex(i)) Navigator.pushReplacementNamed(context, routeName);
  }
}
