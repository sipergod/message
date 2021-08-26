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
            color: checkIndex(0),
            tooltip: 'Home',
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/');
            },
            icon: Icon(Icons.home),
          ),
          Spacer(),
          IconButton(
            color: checkIndex(1),
            tooltip: 'Notification',
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/notification');
            },
            icon: Icon(Icons.notification_important_rounded),
          ),
          IconButton(
            color: checkIndex(2),
            tooltip: 'Authentication',
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/authentication');
            },
            icon: Icon(Icons.fingerprint),
          ),
          IconButton(
            color: checkIndex(3),
            tooltip: 'Settings',
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/setting');
            },
            icon: Icon(Icons.settings),
          ),
        ],
      ),
    );
  }

  Color checkIndex(int i) {
    if (i == widget.bottomNavigateBarIndex)
      return Colors.orange;
    else
      return Theme.of(context).disabledColor;
  }
}
