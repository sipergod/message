import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:message/Static/Enum/AuthenticationSupportState.dart';
import 'package:message/UI/ElemBuilder.dart';

class LocalAuthenticationConfig {
  State? state;
  final LocalAuthentication localAuthentication;
  Function? setStateFunc;
  LocalAuthenticationConfig({
    this.state,
    required this.localAuthentication,
    this.setStateFunc,
  }) : super();

  AuthenticationSupportState supportState = AuthenticationSupportState.unknown;
  bool canCheckBiometrics = false;
  List<BiometricType> availableBiometrics = [];
  String authorized = 'Not Authorized';
  bool isAuthorized = false;
  bool isAuthenticating = false;

  void initialize() {
    localAuthentication.isDeviceSupported().then((isSupported) {
      supportState = (isSupported
          ? AuthenticationSupportState.supported
          : AuthenticationSupportState.unsupported);
    });

    checkBiometrics().then((bool) {
      canCheckBiometrics = bool;
    });

    getAvailableBiometrics().then((list) {
      availableBiometrics = list;
    });
  }

  Future<bool> checkBiometrics() async {
    late bool canCheckBiometrics;
    try {
      canCheckBiometrics = await localAuthentication.canCheckBiometrics;
    } on PlatformException catch (e) {
      canCheckBiometrics = false;
      print(e);
    }

    return canCheckBiometrics;
  }

  Future<List<BiometricType>> getAvailableBiometrics() async {
    late List<BiometricType> availableBiometrics;
    try {
      availableBiometrics = await localAuthentication.getAvailableBiometrics();
    } on PlatformException catch (e) {
      availableBiometrics = <BiometricType>[];
      print(e);
    }

    return availableBiometrics;
  }

  Future<void> authenticate() async {
    bool authenticated = false;
    try {
      setStateFunc!(() {
        isAuthenticating = true;
        authorized = 'Authenticating';
      });
      authenticated = await localAuthentication.authenticate(
        localizedReason: 'Let OS determine authentication method',
        useErrorDialogs: true,
        stickyAuth: true,
      );
      setStateFunc!(() {
        isAuthenticating = false;
      });
    } on PlatformException catch (e) {
      print(e);
      setStateFunc!(() {
        isAuthenticating = false;
        authorized = "Error - ${e.message}";
        isAuthorized = false;
      });

      ElemBuilder(state!).buildAndShowSnackBar(
        'Error - ${e.message}',
        '',
        () {},
      );
      return;
    }
    setStateFunc!(() {
      authorized = authenticated ? 'Authorized' : 'Not Authorized';
      isAuthorized = authenticated;
    });
  }

  Future<void> authenticateWithBiometrics() async {
    bool authenticated = false;
    try {
      setStateFunc!(() {
        isAuthenticating = true;
        authorized = 'Authenticating';
      });
      authenticated = await localAuthentication.authenticate(
        localizedReason:
            'Scan your fingerprint (or face or whatever) to authenticate',
        useErrorDialogs: true,
        stickyAuth: true,
        biometricOnly: true,
      );
      setStateFunc!(() {
        isAuthenticating = false;
        authorized = 'Authenticating';
      });
    } on PlatformException catch (e) {
      print(e);
      setStateFunc!(() {
        isAuthenticating = false;
        authorized = "Error - ${e.message}";
        isAuthorized = false;
      });

      return;
    }

    final String message = authenticated ? 'Authorized' : 'Not Authorized';
    isAuthorized = authenticated;

    authorized = message;
  }

  void cancelAuthentication() async {
    await localAuthentication.stopAuthentication();
    setStateFunc!(() {
      isAuthenticating = false;
    });
  }

  void returnUnauthenticated() async {
    setStateFunc!(() {
      authorized = 'Not Authorized';
      isAuthorized = false;
    });
  }
}
