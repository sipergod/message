import 'package:flutter/material.dart';
import 'package:message/Template/RootTemplate.dart';

class BottomNavBarTemplate extends StatefulWidget {
  final GlobalKey<ScaffoldState>? scaffoldKey;
  final String? title;
  final Widget? appBarAction;
  final Widget? drawerMenu;
  final Widget? bottomTabBar;
  final Widget? bodyWidget;
  final List<Map<String, dynamic>> listBottomNavigateBar;
  final int? bottomNavigateBarIndex;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;

  BottomNavBarTemplate({
    Key? key,
    this.scaffoldKey,
    this.title,
    this.appBarAction,
    this.drawerMenu,
    this.bottomTabBar,
    this.bodyWidget,
    required this.listBottomNavigateBar,
    this.bottomNavigateBarIndex,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
  }) : super(key: key);

  @override
  BottomNavBarTemplateState createState() => new BottomNavBarTemplateState();
}

class BottomNavBarTemplateState extends State<BottomNavBarTemplate> {
  @override
  Widget build(BuildContext context) {
    return RootTemplate(
      title: widget.title,
      appBarAction: widget.appBarAction,
      drawerMenu: widget.drawerMenu,
      bottomTabBar: widget.bottomTabBar,
      bodyWidget: widget.bodyWidget,
      bottomNavigateBar: buildBottomNavigateBar(),
      floatingActionButton: widget.floatingActionButton,
      floatingActionButtonLocation: widget.listBottomNavigateBar.isNotEmpty
          ? FloatingActionButtonLocation.centerDocked
          : null,
    );
  }

  Widget? buildBottomNavigateBar() {
    if (widget.listBottomNavigateBar.isNotEmpty) {
      return BottomAppBar(
        shape: widget.floatingActionButton != null
            ? CircularNotchedRectangle()
            : null,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: new List<Widget>.generate(
              widget.listBottomNavigateBar.length,
              (index) => bottomNavigateItem(
                    index,
                    widget.listBottomNavigateBar,
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
      return Theme.of(context).accentColor;
    else
      return Theme.of(context).disabledColor;
  }

  void setPressFunc(int i, String routeName) {
    if (!checkIndex(i)) Navigator.pushReplacementNamed(context, routeName);
  }
}
