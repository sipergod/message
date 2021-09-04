import 'package:flutter/material.dart';
import 'package:message/Event/InitEvent.dart';
import 'package:message/Event/PublicFunctionEvent.dart';

class RootTemplate extends StatefulWidget {
  final GlobalKey<ScaffoldState>? scaffoldKey;
  final bool? automaticallyImplyLeading;
  final String? title;
  final Widget? appBarAction;
  final Widget? drawerMenu;
  final Widget? bottomTabBar;
  final bool? checkExit;
  final Widget? bodyWidget;
  final int? bottomNavigateBarIndex;
  final Widget? bottomNavigateBar;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;

  RootTemplate({
    Key? key,
    this.scaffoldKey,
    this.automaticallyImplyLeading,
    this.title,
    this.appBarAction,
    this.drawerMenu,
    this.bottomTabBar,
    this.checkExit,
    this.bodyWidget,
    this.bottomNavigateBarIndex,
    this.bottomNavigateBar,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
  }) : super(key: key);

  @override
  _RootTemplateState createState() => new _RootTemplateState();
}

class _RootTemplateState extends State<RootTemplate>
    with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance!.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    Init.instance.addEventAppLifecycleState(state, this);
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: widget.scaffoldKey,
      appBar: buildAppBar() as AppBar,
      drawer: widget.drawerMenu,
      body: WillPopScope(
        onWillPop: widget.checkExit == null || (widget.checkExit!) == true
            ? () async {
                return await PublicFunctionEvent.instance.onWillPop();
              }
            : null,
        child: SafeArea(
          child: widget.bodyWidget as Widget,
        ),
      ),
      bottomNavigationBar: widget.bottomNavigateBar,
      floatingActionButtonLocation: widget.floatingActionButtonLocation,
      floatingActionButton: widget.floatingActionButton,
    );
  }

  Widget buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: widget.automaticallyImplyLeading == null
          ? true
          : widget.automaticallyImplyLeading as bool,
      centerTitle: true,
      title: buildTitle(),
      actions: widget.appBarAction != null ? buildAppbarAction() : null,
      bottom: buildTabBar() as PreferredSizeWidget,
    );
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

  Widget? buildTabBar() {
    if (widget.bottomTabBar != null) {
      return widget.bottomTabBar as Widget;
    } else {
      return PreferredSize(
        child: Container(),
        preferredSize: Size.fromHeight(0.0),
      );
    }
  }
}
