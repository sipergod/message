import 'package:message/Component/FirebaseMessageConfig.dart';
import 'package:message/Static/ApplicationInitSettings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Init {
  Init._();
  static final instance = Init._();

  Future<void> initialize() async {
    ApplicationInitSettings initSetting = ApplicationInitSettings.instance;

    initSetting.sharedPreferences = await SharedPreferences.getInstance();

    FirebaseMessageConfig.initialize();
    setThemeIsSystem(initSetting);
    setThemeIsDark(initSetting);
  }

  void setThemeIsSystem(ApplicationInitSettings initSetting) {
    if (initSetting.sharedPreferences.getBool('themeIsSystem') == null) {
      initSetting.sharedPreferences.setBool('themeIsSystem', false);
    } else {
      initSetting.themeIsSystem = ApplicationInitSettings
          .instance.sharedPreferences
          .getBool('themeIsSystem')!;
    }
  }

  void setThemeIsDark(ApplicationInitSettings initSetting) {
    if (initSetting.sharedPreferences.getBool('themeIsDark') == null) {
      initSetting.sharedPreferences.setBool('themeIsDark', false);
    } else {
      initSetting.themeIsDark = ApplicationInitSettings
          .instance.sharedPreferences
          .getBool('themeIsDark')!;
    }
  }
}
