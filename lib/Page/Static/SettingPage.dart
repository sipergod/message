import 'package:flutter/material.dart';
import 'package:message/Event/PageEvent/SettingPageEvent.dart';
import 'package:message/Static/Constants.dart';
import 'package:message/Static/ListBuildItem/ListBottomNavigateItem.dart';
import 'package:message/Template/BottomNavBarTemplate.dart';

class SettingPage extends StatefulWidget {
  SettingPage({Key? key}) : super(key: key);

  @override
  SettingPageState createState() => new SettingPageState();
}

class SettingPageState extends State<SettingPage> {
  late SettingPageEvent settingPageEvent;

  @override
  void initState() {
    settingPageEvent = new SettingPageEvent(this);

    Future.delayed(Duration(seconds: 1)).then((value) {
      settingPageEvent.preLoad();
      Future.delayed(Duration(seconds: 1));
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavBarTemplate(
      bodyWidget: buildBody(),
      listBottomNavigateBar: ListBottomNavigateItem.list,
      bottomNavigateBarIndex: ListBottomNavigateItem.settingIndex,
    );
  }

  Widget loadingState() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget buildBody() {
    return Container(
      child: ListView(
        children: [
          buildInterfaceSetting(),
          //createActionBar(),
        ],
      ),
    );
  }

  Widget buildInterfaceSetting() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Theme.of(context).backgroundColor.withAlpha(88),
      ),
      margin: EdgeInsets.all(Constants.paddingSmall),
      padding: EdgeInsets.all(Constants.padding),
      child: Column(
        children: [
          buildGroupTitle('Interface'),
          Divider(),
          buildSettingOption('themeIsSystem', 'Use system theme', true),
          buildSettingOption('themeIsDark', 'Dark theme',
              !settingPageEvent.themeStyleIsSystem),
        ],
      ),
    );
  }

  Widget buildGroupTitle(String title) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
        textAlign: TextAlign.start,
      ),
    );
  }

  Widget buildSettingOption(String settingName, String title, bool isActive) {
    return IgnorePointer(
      ignoring: !isActive,
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Text(title),
            ),
            Container(
              child: buildOption(settingName),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildOption(String settingName) {
    switch (settingName) {
      case 'themeIsSystem':
        return Switch(
          value: settingPageEvent.themeStyleIsSystem,
          onChanged: settingPageEvent.changeThemeMode,
        );
      case 'themeIsDark':
        return Switch(
          value: settingPageEvent.themeStyleIsDark,
          onChanged: settingPageEvent.changeThemeStyle,
        );
      default:
        return Container();
    }
  }
}
