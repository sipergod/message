import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:message/Static/ApplicationInitSettings.dart';
import 'package:message/Static/LocalAuthenticationService.dart';
import 'package:message/Static/PageRouteName.dart';
import 'package:message/UI/ElemBuilder.dart';

class AppLockPageEvent {
  State state;
  Function setStateFunc;
  AppLockPageEvent(this.state, this.setStateFunc);

  String inputPassword = '';
  String inputConfirmPassword = '';
  String status = '';
  bool isConfirmed = false;
  bool isChangingPasscode = false;
  bool isSetupPasscode = false;

  void preLoad(bool? inputIsSetupPasscode) {
    if (inputIsSetupPasscode != null) {
      isSetupPasscode = inputIsSetupPasscode;
      if (ApplicationInitSettings.instance.appPasscode.isNotEmpty &&
          ApplicationInitSettings.instance.appPasscodeLength != 0) {
        isChangingPasscode = true;
        isSetupPasscode = false;
        status = 'Enter your current passcode';
      }
    }

    if (!isSetupPasscode && !isChangingPasscode) {
      status = 'Enter your passcode to unlock!';
    }
  }

  void onPressNumberButton(String number) {
    setStateFunc(() {
      inputPassword = inputPassword + number;
    });
    if (isChangingPasscode || !isSetupPasscode) {
      if (inputPassword.length ==
          ApplicationInitSettings.instance.appPasscodeLength) {
        checkPassword();
      }
    }
  }

  void onPressDoneButton() {
    if (inputPassword.isNotEmpty) {
      if (isConfirmed) {
        if (inputConfirmPassword == inputPassword) {
          Navigator.of(state.context).pop(inputPassword);
        } else {
          setStateFunc(() {
            status = 'Wrong confirmation passcode, try again!';
            inputPassword = '';
            ElemBuilder(state).buildAndShowSnackBar(
              status,
              '',
              () {},
            );
          });
        }
      } else {
        setStateFunc(() {
          isConfirmed = true;
          status = 'Please confirm your passcode again!';
          inputConfirmPassword = inputPassword;
          inputPassword = '';
          ElemBuilder(state).buildAndShowSnackBar(
            status,
            '',
            () {},
          );
        });
      }
    } else {
      status = 'Please input your passcode!';
      ElemBuilder(state).buildAndShowSnackBar(
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
      setStateFunc(() {
        status =
            LocalAuthenticationService.localAuthenticationConfig.authorized;
      });

      if (LocalAuthenticationService.localAuthenticationConfig.isAuthorized) {
        Navigator.of(state.context).pop();
      }
    });
  }

  void onPressBackspaceButton() {
    if (inputPassword.isNotEmpty) {
      setStateFunc(() {
        inputPassword = inputPassword.substring(0, inputPassword.length - 1);
      });
    }
  }

  void checkPassword() {
    String encodePassword =
        sha256.convert(utf8.encode(inputPassword)).toString();

    if (encodePassword == ApplicationInitSettings.instance.appPasscode) {
      if (isChangingPasscode) {
        setStateFunc(() {
          isChangingPasscode = false;
          isSetupPasscode = true;
          status = 'Enter your new passcode!';
          inputPassword = '';
        });
      } else {
        if (Navigator.of(state.context).canPop()) {
          Navigator.of(state.context).pop();
        } else {
          Navigator.of(state.context)
              .pushReplacementNamed(PageRouteName.homeRoute);
        }
      }
    } else {
      setStateFunc(() {
        status = 'Wrong passcode!';
        inputPassword = '';
      });
    }
  }
}
