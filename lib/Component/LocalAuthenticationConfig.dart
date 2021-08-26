import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:message/Static/Enum/AuthenticationSupportState.dart';

class LocalAuthenticationConfig {
  LocalAuthenticationConfig({required this.localAuthentication}) : super();

  final LocalAuthentication localAuthentication;

  AuthenticationSupportState supportState = AuthenticationSupportState.unknown;
  bool canCheckBiometrics = false;
  List<BiometricType> availableBiometrics = [];
  String authorized = 'Not Authorized';
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
      isAuthenticating = true;
      authorized = 'Authenticating';

      authenticated = await localAuthentication.authenticate(
        localizedReason: 'Let OS determine authentication method',
        useErrorDialogs: true,
        stickyAuth: true,
      );

      isAuthenticating = false;
    } on PlatformException catch (e) {
      print(e);

      isAuthenticating = false;
      authorized = "Error - ${e.message}";

      return;
    }

    authorized = authenticated ? 'Authorized' : 'Not Authorized';
  }

  Future<void> authenticateWithBiometrics() async {
    bool authenticated = false;
    try {
      isAuthenticating = true;
      authorized = 'Authenticating';

      authenticated = await localAuthentication.authenticate(
        localizedReason:
            'Scan your fingerprint (or face or whatever) to authenticate',
        useErrorDialogs: true,
        stickyAuth: true,
        biometricOnly: true,
      );

      isAuthenticating = false;
      authorized = 'Authenticating';
    } on PlatformException catch (e) {
      print(e);

      isAuthenticating = false;
      authorized = "Error - ${e.message}";

      return;
    }

    final String message = authenticated ? 'Authorized' : 'Not Authorized';

    authorized = message;
  }

  void cancelAuthentication() async {
    await localAuthentication.stopAuthentication();
    isAuthenticating = false;
  }
}
