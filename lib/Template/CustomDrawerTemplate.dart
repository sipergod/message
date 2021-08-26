import 'package:flutter/material.dart';
import 'package:message/Static/Constants.dart';

class CustomDrawerTemplate extends StatefulWidget {
  final GlobalKey<ScaffoldState>? scaffoldKey;
  final String? title;
  final Widget? appBarAction;
  final Widget? drawerMenu;
  final Widget? bottomTabBar;
  final Widget? bodyWidget;
  final Widget? bottomNavigateBar;
  final Widget? floatingActionButton;

  CustomDrawerTemplate({
    Key? key,
    this.scaffoldKey,
    this.title,
    this.appBarAction,
    this.drawerMenu,
    this.bottomTabBar,
    this.bodyWidget,
    this.bottomNavigateBar,
    this.floatingActionButton,
  }) : super(key: key);

  @override
  _CustomDrawerTemplateState createState() => new _CustomDrawerTemplateState();
}

class _CustomDrawerTemplateState extends State<CustomDrawerTemplate>
    with WidgetsBindingObserver, SingleTickerProviderStateMixin {
  bool isCollapsed = true;
  late double screenWidth, screenHeight;
  final Duration duration = const Duration(milliseconds: 300);
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _menuScaleAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: duration,
    );
    _scaleAnimation = Tween<double>(
      begin: 1,
      end: 0.8,
    ).animate(_animationController);
    _menuScaleAnimation = Tween<double>(
      begin: 0.5,
      end: 1,
    ).animate(_animationController);
    _slideAnimation = Tween<Offset>(
      begin: Offset(-1, 0),
      end: Offset(0, 0),
    ).animate(_animationController);
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    _animationController.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;

    return Scaffold(
      key: widget.scaffoldKey,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            buildDrawer(),
            buildBody(),
          ],
        ),
      ),
      bottomNavigationBar: widget.bottomNavigateBar,
      floatingActionButton: widget.floatingActionButton,
    );
  }

  Widget buildDrawer() {
    return SlideTransition(
      position: _slideAnimation,
      child: ScaleTransition(
        scale: _menuScaleAnimation,
        child: Padding(
          padding: EdgeInsets.only(left: Constants.paddingMedium),
          child: Align(
            alignment: Alignment.centerLeft,
            child: widget.drawerMenu,
          ),
        ),
      ),
    );
  }

  Widget buildBody() {
    return AnimatedPositioned(
      duration: duration,
      top: 0,
      bottom: 0,
      left: isCollapsed ? 0 : 0.6 * screenWidth,
      right: isCollapsed ? 0 : -0.2 * screenWidth,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Material(
          animationDuration: duration,
          borderRadius:
              isCollapsed ? null : BorderRadius.all(Radius.circular(40)),
          elevation: 8,
          color: Theme.of(context).backgroundColor,
          child: Container(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(Constants.paddingMedium),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      InkWell(
                        child: Icon(Icons.menu, color: Colors.white),
                        onTap: () => triggerDrawer(),
                      ),
                      buildTitle(),
                      ...buildAppbarAction(),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    physics: ClampingScrollPhysics(),
                    child: Container(
                      padding: EdgeInsets.only(
                        left: Constants.paddingMedium,
                        right: Constants.paddingMedium,
                        bottom: Constants.paddingMedium,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            child: widget.bodyWidget,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTitle() {
    Widget returnWidget;
    if (widget.title == null) {
      returnWidget = Expanded(
        child: Container(
          padding: EdgeInsets.all(5),
          child: Image.asset(
            'assets/ic_launcher.png',
            height: 40,
            color: Colors.white,
            fit: BoxFit.fitHeight,
          ),
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

  void triggerDrawer() {
    setState(() {
      if (isCollapsed)
        _animationController.forward();
      else
        _animationController.reverse();

      isCollapsed = !isCollapsed;
    });
  }
}
