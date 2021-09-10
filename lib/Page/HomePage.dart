import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:message/Component/FirebaseMessageConfig.dart';
import 'package:message/Component/Fragment/SkeletonLoadWidget.dart';
import 'package:message/Event/PublicFunctionEvent.dart';
import 'package:message/Static/ApplicationInitSettings.dart';
import 'package:message/Static/Constants.dart';
import 'package:message/Static/ListBuildItem/ListBottomNavigateItem.dart';
import 'package:message/Template/BottomNavBarTemplate.dart';
import 'package:message/UI/ElemBuilder.dart';
import 'package:message/UI/ListViewBuilder.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _counter = 0;
  bool fBtnVisible = true;
  ScrollController scrollController = new ScrollController();

  void _incrementCounter() {
    setState(() {
      _counter++;
    });

    ElemBuilder(this).buildAndShowSnackBar(
      'Do push notification',
      'Undo',
      () {},
    );

    FirebaseMessageConfig.sendPushMessage([
      ApplicationInitSettings.instance.sharedPreferences.getString('token')!
    ], {}, {});
  }

  @override
  void initState() {
    PublicFunctionEvent.instance.addScrollListener(
      scrollController,
      () {},
      () {
        if (fBtnVisible == true) {
          setState(() {
            fBtnVisible = false;
          });
        }
      },
      () {
        if (fBtnVisible == false) {
          setState(() {
            fBtnVisible = true;
          });
        }
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavBarTemplate(
      bodyWidget: Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Container(
                  padding: EdgeInsets.all(Constants.padding),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'You have pushed the button this many times:',
                      ),
                      Text(
                        '$_counter',
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      buildTestItem(),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  child: buildListData(),
                ),
              ),
            ],
          ),
        ),
      ),
      listBottomNavigateBar: ListBottomNavigateItem.list,
      bottomNavigateBarIndex: ListBottomNavigateItem.homeIndex,
      floatingActionButton: Visibility(
        visible: fBtnVisible,
        child: FloatingActionButton(
          onPressed: _incrementCounter,
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  Widget buildTestItem() {
    /*return Center(
      child: Container(
        padding: EdgeInsets.only(
          top: Constants.padding,
          bottom: Constants.paddingSmall,
        ),
        child: CircularProgressIndicator(
          valueColor: new AlwaysStoppedAnimation<Color>(
            Theme.of(context).colorScheme.secondary,
          ),
        ),
      ),
    );*/
    return SkeletonLoadWidget();
    /*return Container();*/
  }

  Widget buildListData() {
    return ListViewBuilder(
      initListData: [],
      scrollController: scrollController,
    );
  }
}
