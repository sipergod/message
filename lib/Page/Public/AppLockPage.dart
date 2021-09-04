import 'dart:convert';
import 'dart:ui';

import 'package:crypto/crypto.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:message/Event/PublicFunctionEvent.dart';
import 'package:message/Static/ApplicationInitSettings.dart';
import 'package:message/Static/Constants.dart';
import 'package:message/Static/LocalAuthenticationService.dart';
import 'package:message/Static/PageRouteName.dart';
import 'package:message/Template/RootTemplate.dart';
import 'package:message/UI/ElemBuilder.dart';

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
  String _inputPassword = '';
  String _inputConfirmPassword = '';
  String status = '';
  bool isConfirmed = false;
  bool isChangingPasscode = false;
  bool isSetupPasscode = false;

  @override
  void initState() {
    LocalAuthenticationService.localAuthenticationConfig.state = this;

    if (widget.isSetupPasscode != null) {
      isSetupPasscode = widget.isSetupPasscode!;
      if (ApplicationInitSettings.instance.appPasscode.isNotEmpty &&
          ApplicationInitSettings.instance.appPasscodeLength != 0) {
        isChangingPasscode = true;
        isSetupPasscode = false;
        status = 'Input your current passcode';
      }
    }

    if (!isSetupPasscode && !isChangingPasscode) {
      status = 'Input your passcode to unlock!';
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.context != null) context = widget.context!;

    return RootTemplate(
      automaticallyImplyLeading: isChangingPasscode || isSetupPasscode,
      checkExit: !(isChangingPasscode || isSetupPasscode),
      bodyWidget: WillPopScope(
        onWillPop: !(isChangingPasscode || isSetupPasscode)
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildStatus(),
            buildPasswordInput(),
            buildKeyboard(),
          ],
        ),
      ),
    );
  }

  Widget buildStatus() {
    return Container(
      margin: EdgeInsets.fromLTRB(
        Constants.paddingLarge,
        Constants.paddingLarge,
        Constants.paddingLarge,
        0,
      ),
      padding: EdgeInsets.symmetric(vertical: Constants.paddingMedium),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20.0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(children: [
          TextSpan(
            text: status,
            style: TextStyle(
              fontSize: Theme.of(context).textTheme.bodyText1!.fontSize,
            ),
          ),
        ]),
      ),
    );
  }

  Widget buildPasswordInput() {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: Constants.paddingLarge,
      ),
      padding: EdgeInsets.symmetric(
        vertical: Constants.paddingMedium,
      ),
      width: MediaQuery.of(context).size.width,
      //height: 60,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _inputPassword.isEmpty && !isChangingPasscode
            ? [
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(children: [
                    TextSpan(
                      text: 'Enter passcode',
                      style: TextStyle(fontSize: 13),
                    ),
                  ]),
                )
              ]
            : List.generate(
                isSetupPasscode
                    ? _inputPassword.length
                    : ApplicationInitSettings.instance.appPasscodeLength,
                (index) {
                  return Icon(
                    _inputPassword.length <= index
                        ? Icons.circle_outlined
                        : Icons.circle,
                    size: Constants.padding,
                  );
                },
              ),
      ),
    );
  }

  Widget buildKeyboard() {
    return Container(
      margin: EdgeInsets.fromLTRB(
        Constants.paddingLarge,
        0,
        Constants.paddingLarge,
        Constants.paddingLarge,
      ),
      padding: EdgeInsets.symmetric(vertical: Constants.paddingMedium),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Theme.of(context).canvasColor.withOpacity(0.75),
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(20.0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: Constants.paddingSmall),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                buildButton('1', () => onPressNumberButton('1')),
                buildButton('2', () => onPressNumberButton('2')),
                buildButton('3', () => onPressNumberButton('3')),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: Constants.paddingSmall),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                buildButton('4', () => onPressNumberButton('4')),
                buildButton('5', () => onPressNumberButton('5')),
                buildButton('6', () => onPressNumberButton('6')),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: Constants.paddingSmall),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                buildButton('7', () => onPressNumberButton('7')),
                buildButton('8', () => onPressNumberButton('8')),
                buildButton('9', () => onPressNumberButton('9')),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: Constants.paddingSmall),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                isSetupPasscode
                    ? buildDoneButton()
                    : buildBioAuthenticationButton(),
                buildButton('0', () => onPressNumberButton('0')),
                buildBackspaceButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildButton(String text, void Function() onPress) {
    return ElevatedButton(
      onPressed: onPress,
      child: Text(
        text,
        style: TextStyle(
          fontSize: Theme.of(context).textTheme.bodyText1!.fontSize,
        ),
      ),
      style: ElevatedButton.styleFrom(
        shape: CircleBorder(),
        primary: Theme.of(context).primaryColor,
        minimumSize:
            Size(Constants.paddingLarge * 2, Constants.paddingLarge * 2),
        padding: EdgeInsets.all(Constants.paddingSmall),
      ),
    );
  }

  Widget buildDoneButton() {
    return IconButton(
      onPressed: () => onPressDoneButton(),
      icon: Icon(
        Icons.check_circle,
        color: Theme.of(context).primaryColor,
        size: Constants.padding * 2,
      ),
      splashRadius: 25.0,
    );
  }

  Widget buildBioAuthenticationButton() {
    return IconButton(
      onPressed: () => onPressBioAuthenticationButton(),
      tooltip: 'Authentication with Biometrics',
      icon: Icon(
        Icons.fingerprint,
        size: Constants.padding * 2,
      ),
      splashRadius: 25.0,
    );
  }

  Widget buildBackspaceButton() {
    return IconButton(
      onPressed: () => onPressBackspaceButton(),
      icon: Icon(
        Icons.backspace_outlined,
        size: Constants.padding * 2,
      ),
      splashRadius: 25.0,
    );
  }

  void onPressNumberButton(String number) {
    setState(() {
      _inputPassword = _inputPassword + number;
    });
    if (isChangingPasscode || !isSetupPasscode) {
      if (_inputPassword.length ==
          ApplicationInitSettings.instance.appPasscodeLength) {
        checkPassword();
      }
    }
  }

  void onPressDoneButton() {
    if (_inputPassword.isNotEmpty) {
      if (isConfirmed) {
        if (_inputConfirmPassword == _inputPassword) {
          Navigator.of(context).pop(_inputPassword);
        } else {
          setState(() {
            status = 'Wrong confirmation passcode, try again!';
            _inputPassword = '';
            ElemBuilder(this).buildAndShowSnackBar(
              status,
              '',
              () {},
            );
          });
        }
      } else {
        setState(() {
          isConfirmed = true;
          status = 'Please confirm your passcode again!';
          _inputConfirmPassword = _inputPassword;
          _inputPassword = '';
          ElemBuilder(this).buildAndShowSnackBar(
            status,
            '',
            () {},
          );
        });
      }
    } else {
      status = 'Please input your passcode!';
      ElemBuilder(this).buildAndShowSnackBar(
        status,
        '',
        () {},
      );
    }
  }

  void onPressBioAuthenticationButton() {
    LocalAuthenticationService.localAuthenticationConfig
        .authenticateWithBiometrics()
        .then((value) {
      setState(() {
        status =
            LocalAuthenticationService.localAuthenticationConfig.authorized;
      });
    });

    if (LocalAuthenticationService.localAuthenticationConfig.isAuthorized) {
      Navigator.of(context).pop();
    }
  }

  void onPressBackspaceButton() {
    if (_inputPassword.isNotEmpty) {
      setState(() {
        _inputPassword = _inputPassword.substring(0, _inputPassword.length - 1);
      });
    }
  }

  void checkPassword() {
    String encodePassword =
        sha256.convert(utf8.encode(_inputPassword)).toString();

    if (encodePassword == ApplicationInitSettings.instance.appPasscode) {
      if (isChangingPasscode) {
        setState(() {
          isChangingPasscode = false;
          isSetupPasscode = true;
          status = 'Enter your new passcode!';
          _inputPassword = '';
        });
      } else {
        if(Navigator.of(context).canPop()) {
          Navigator.of(context).pop();
        } else {
          Navigator.of(context).pushReplacementNamed(PageRouteName.homeRoute);
        }
      }
    } else {
      setState(() {
        status = 'Wrong passcode!';
        _inputPassword = '';
      });
    }
  }
}
