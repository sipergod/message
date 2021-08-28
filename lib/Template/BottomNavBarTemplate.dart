import 'package:flutter/material.dart';
import 'package:message/Page/HomePage.dart';
import 'package:message/Page/LocalNotificationOptionPage.dart';
import 'package:message/Template/RootTemplate.dart';

class BottomNavBarTemplate extends StatefulWidget {
  final GlobalKey<ScaffoldState>? scaffoldKey;
  final String? title;
  final Widget? appBarAction;
  final Widget? drawerMenu;
  final Widget? bottomTabBar;
  final Widget? bodyWidget;
  final int? bottomNavigateBarIndex;
  final Widget? floatingActionButton;

  BottomNavBarTemplate({
    Key? key,
    this.scaffoldKey,
    this.title,
    this.appBarAction,
    this.drawerMenu,
    this.bottomTabBar,
    this.bodyWidget,
    this.bottomNavigateBarIndex,
    this.floatingActionButton,
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
    );
  }

  Widget buildBottomNavigateBar() {
    return BottomAppBar(
      shape: widget.floatingActionButton != null
          ? CircularNotchedRectangle()
          : null,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            color: setActive(0),
            tooltip: 'Home',
            onPressed: () {
              setPressFunc(0, '/');
            },
            icon: Icon(Icons.home),
          ),
          Spacer(),
          IconButton(
            color: setActive(1),
            tooltip: 'Notification',
            onPressed: () {
              setPressFunc(1, '/notification');
            },
            icon: Icon(Icons.notification_important_rounded),
          ),
          IconButton(
            color: setActive(2),
            tooltip: 'Authentication',
            onPressed: () {
              setPressFunc(2, '/authentication');
            },
            icon: Icon(Icons.fingerprint),
          ),
          IconButton(
            color: setActive(3),
            tooltip: 'Settings',
            onPressed: () {
              setPressFunc(3, '/setting');
            },
            icon: Icon(Icons.settings),
          ),
        ],
      ),
    );
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
