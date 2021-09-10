import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:message/Event/PageEvent/AppLockPageEvent.dart';
import 'package:message/Event/PublicFunctionEvent.dart';
import 'package:message/Static/ApplicationInitSettings.dart';
import 'package:message/Static/Constants.dart';
import 'package:message/Static/LocalAuthenticationService.dart';
import 'package:message/Template/RootTemplate.dart';

class AppLockPage extends StatefulWidget {
  final BuildContext? context;
  final bool? isSetupPasscode;

  AppLockPage({
    Key? key,
    this.context,
    this.isSetupPasscode,
  }) : super(key: key);

  @override
  AppLockPageState createState() => new AppLockPageState();
}

class AppLockPageState extends State<AppLockPage> {
  late AppLockPageEvent appLockPageEvent;

  @override
  void initState() {
    LocalAuthenticationService.localAuthenticationConfig.state = this;
    LocalAuthenticationService.localAuthenticationConfig.setStateFunc = this.setState;

    appLockPageEvent = new AppLockPageEvent(this, this.setState);
    appLockPageEvent.preLoad(widget.isSetupPasscode);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.context != null) {
      context = widget.context!;
    }

    return RootTemplate(
      automaticallyImplyLeading: appLockPageEvent.isChangingPasscode ||
          appLockPageEvent.isSetupPasscode,
      checkExit: !(appLockPageEvent.isChangingPasscode ||
          appLockPageEvent.isSetupPasscode),
      bodyWidget: WillPopScope(
        onWillPop: !(appLockPageEvent.isChangingPasscode ||
                appLockPageEvent.isSetupPasscode)
            ? () async {
                return await PublicFunctionEvent.instance.exitApp();
              }
            : null,
        child: buildMainBody(),
      ),
    );
  }

  Widget buildMainBody() {
    return Container(
      child: Center(
        child: Column(
          children: [
            buildStatus(),
            buildPasswordInput(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Constants.padding),
              child: Divider(
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            buildKeyboard(),
          ],
        ),
      ),
    );
  }

  Widget buildStatus() {
    return Expanded(
      flex: 2,
      child: Container(
        child: Center(
          child: RichText(
            //textAlign: TextAlign.center,
            text: TextSpan(children: [
              TextSpan(
                text: appLockPageEvent.status,
              ),
            ]),
          ),
        ),
      ),
    );
  }

  Widget buildPasswordInput() {
    return Expanded(
      flex: 2,
      child: Container(
        margin: EdgeInsets.all(Constants.padding),
        child: Center(
          child: appLockPageEvent.inputPassword.isEmpty &&
                  !appLockPageEvent.isChangingPasscode
              ? RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(children: [
                    TextSpan(
                      text: 'Enter passcode',
                    ),
                  ]),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    appLockPageEvent.isSetupPasscode
                        ? appLockPageEvent.inputPassword.length
                        : ApplicationInitSettings.instance.appPasscodeLength,
                    (index) {
                      return Icon(
                        appLockPageEvent.inputPassword.length <= index
                            ? Icons.circle_outlined
                            : Icons.circle,
                        size: Constants.padding,
                      );
                    },
                  ),
                ),
        ),
      ),
    );
  }

  Widget buildKeyboard() {
    return Expanded(
      flex: 6,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: Constants.paddingLarge),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: Constants.paddingSmall),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildButton('1', null),
                  buildButton('2', null),
                  buildButton('3', null),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: Constants.paddingSmall),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildButton('4', null),
                  buildButton('5', null),
                  buildButton('6', null),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: Constants.paddingSmall),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildButton('7', null),
                  buildButton('8', null),
                  buildButton('9', null),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: Constants.paddingSmall),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  appLockPageEvent.isSetupPasscode
                      ? buildDoneButton()
                      : buildBioAuthenticationButton(),
                  buildButton('0', null),
                  buildBackspaceButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildButton(String text, Function? onPressFunction) {
    return MaterialButton(
      onPressed: () {
        if (onPressFunction == null) {
          appLockPageEvent.onPressNumberButton(text);
        } else {
          onPressFunction();
        }
      },
      child: Text(
        text,
        style: TextStyle(
          fontSize: Theme.of(context).textTheme.bodyText1!.fontSize! * 2,
        ),
      ),
      shape: CircleBorder(),
      height: Constants.buttonHeight,
    );
  }

  Widget buildDoneButton() {
    return IconButton(
      onPressed: () {
        appLockPageEvent.onPressDoneButton();
      },
      icon: Icon(
        Icons.check_circle,
      ),
      splashRadius: Constants.buttonSplashRadius,
    );
  }

  Widget buildBioAuthenticationButton() {
    return IconButton(
      onPressed: () {
        appLockPageEvent.onPressBioAuthenticationButton();
      },
      tooltip: 'Authentication with Biometrics',
      icon: Icon(
        Icons.fingerprint,
      ),
      splashRadius: Constants.buttonSplashRadius,
    );
  }

  Widget buildBackspaceButton() {
    return IconButton(
      onPressed: () {
        appLockPageEvent.onPressBackspaceButton();
      },
      icon: Icon(
        Icons.backspace_outlined,
      ),
      splashRadius: Constants.buttonSplashRadius,
    );
  }
}
