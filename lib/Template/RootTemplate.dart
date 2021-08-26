import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:message/Component/LocalNotificationConfig.dart';
import 'package:message/Static/LocalAuthenticationService.dart';
import 'package:message/Static/LocalNotificationService.dart';

class RootTemplate extends StatefulWidget {
  final GlobalKey<ScaffoldState>? scaffoldKey;
  final String? title;
  final Widget? appBarAction;
  final Widget? drawerMenu;
  final Widget? bottomTabBar;
  final Widget? bodyWidget;
  final int? bottomNavigateBarIndex;
  final Widget? bottomNavigateBar;
  final Widget? floatingActionButton;

  RootTemplate({
    Key? key,
    this.scaffoldKey,
    this.title,
    this.appBarAction,
    this.drawerMenu,
    this.bottomTabBar,
    this.bodyWidget,
    this.bottomNavigateBarIndex,
    this.bottomNavigateBar,
    this.floatingActionButton,
  }) : super(key: key);

  @override
  _RootTemplateState createState() => new _RootTemplateState();
}

class _RootTemplateState extends State<RootTemplate>
    with WidgetsBindingObserver {

  @override
  void initState() {
    LocalNotificationService.notificationService.initialize();
    LocalAuthenticationService.localAuthenticationConfig.initialize();

    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: widget.scaffoldKey,
      appBar: buildAppBar() as AppBar,
      drawer: widget.drawerMenu,
      body: SafeArea(child: widget.bodyWidget as Widget),
      bottomNavigationBar: widget.bottomNavigateBar,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: widget.floatingActionButton,
    );
  }

  Widget buildAppBar() {
    Widget returnWidget = Container();

    returnWidget = AppBar(
      automaticallyImplyLeading: true,
      centerTitle: true,
      title: buildTitle(),
      actions: widget.appBarAction != null ? buildAppbarAction() : null,
      bottom: widget.bottomTabBar != null
          ? PreferredSize(
              child: buildTabBar(),
              preferredSize: Size.fromHeight(100),
            )
          : null,
    );

    return returnWidget;
  }

  Widget buildTitle() {
    Widget returnWidget;
    if (widget.title == null) {
      returnWidget = Container(
        padding: EdgeInsets.all(5),
        child: Image.asset(
          'assets/ic_launcher.png',
          height: 40,
          color: Colors.white,
          fit: BoxFit.fitHeight,
        ),
      );
    } else {
      returnWidget = Text(widget.title.toString());
    }
    return returnWidget;
  }

  List<Widget> buildAppbarAction() {
    List<Widget> returnWidget = [];
    if (widget.appBarAction != null) {
      returnWidget.add(widget.appBarAction as Widget);
    }
    return returnWidget;
  }

  Widget buildTabBar() {
    Widget returnWidget;
    if (widget.title != null && widget.bottomTabBar != null) {
      returnWidget = widget.bottomTabBar as Widget;
    } else {
      returnWidget = PreferredSize(
        child: Container(),
        preferredSize: Size.fromHeight(0.0),
      );
    }
    return returnWidget;
  }
}
