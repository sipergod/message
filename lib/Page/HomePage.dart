import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:message/Component/FirebaseMessageConfig.dart';
import 'package:message/Event/PublicFunctionEvent.dart';
import 'package:message/Static/ListBuildItem/ListBottomNavigateItem.dart';
import 'package:message/Template/BottomNavBarTemplate.dart';
import 'package:message/UI/ListViewBuilder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  bool fBtnVisible = true;
  String token = '';
  ScrollController scrollController = new ScrollController();

  void _incrementCounter() {
    setState(() {
      _counter++;
    });

    FirebaseMessageConfig.sendPushMessage([token], {}, {});
  }

  @override
  void initState() {
    super.initState();

    PublicFunctionEvent().addScrollListener(
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

    SharedPreferences.getInstance().then(
      (sharedPreferences) => {token = sharedPreferences.getString('token')!},
    );
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavBarTemplate(
      bodyWidget: Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(border: Border.all(color: Colors.red)),
          child: Column(
            children: [
              SingleChildScrollView(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.blue)),
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
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.blue)),
                  child: buildListData(),
                ),
              ),
            ],
          ),
        ),
      ),
      listBottomNavigateBar: ListBottomNavigateItem.list,
      bottomNavigateBarIndex: 0,
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

  Widget buildListData() {
    return ListViewBuilder(
        initListData: [], scrollController: scrollController);
  }
}
