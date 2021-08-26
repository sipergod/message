import 'package:flutter/material.dart';
import 'package:message/Static/Enum/AuthenticationSupportState.dart';
import 'package:message/Static/LocalAuthenticationService.dart';
import 'package:message/Template/BottomNavBarTemplate.dart';

class LocalAuthenticationPage extends StatefulWidget {
  LocalAuthenticationPage({Key? key}) : super(key: key);

  @override
  LocalAuthenticationPageState createState() =>
      new LocalAuthenticationPageState();
}

class LocalAuthenticationPageState extends State<LocalAuthenticationPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavBarTemplate(
      bodyWidget: buildBody(),
      bottomNavigateBarIndex: 2,
    );
  }

  Widget buildBody() {
    return ListView(
      padding: const EdgeInsets.only(top: 30),
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (LocalAuthenticationService
                    .localAuthenticationConfig.supportState ==
                AuthenticationSupportState.unknown)
              CircularProgressIndicator()
            else if (LocalAuthenticationService
                    .localAuthenticationConfig.supportState ==
                AuthenticationSupportState.supported)
              Text("This device is supported")
            else
              Text("This device is not supported"),
            Divider(height: 100),
            Text(
                'Can check biometrics: ${LocalAuthenticationService.localAuthenticationConfig.canCheckBiometrics}\n'),
            ElevatedButton(
              child: const Text('Check biometrics'),
              onPressed: LocalAuthenticationService
                  .localAuthenticationConfig.checkBiometrics,
            ),
            Divider(height: 100),
            Text(
                'Available biometrics: ${LocalAuthenticationService.localAuthenticationConfig.availableBiometrics}\n'),
            ElevatedButton(
              child: const Text('Get available biometrics'),
              onPressed: LocalAuthenticationService
                  .localAuthenticationConfig.getAvailableBiometrics,
            ),
            Divider(height: 100),
            Text(
                'Current State: $LocalAuthenticationService.localAuthenticationConfig.authorized\n'),
            (LocalAuthenticationService
                    .localAuthenticationConfig.isAuthenticating)
                ? ElevatedButton(
                    onPressed: LocalAuthenticationService
                        .localAuthenticationConfig.cancelAuthentication,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("Cancel Authentication"),
                        Icon(Icons.cancel),
                      ],
                    ),
                  )
                : Column(
                    children: [
                      ElevatedButton(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('Authenticate'),
                            Icon(Icons.perm_device_information),
                          ],
                        ),
                        onPressed: LocalAuthenticationService
                            .localAuthenticationConfig.authenticate,
                      ),
                      ElevatedButton(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(LocalAuthenticationService
                                    .localAuthenticationConfig.isAuthenticating
                                ? 'Cancel'
                                : 'Authenticate: biometrics only'),
                            Icon(Icons.fingerprint),
                          ],
                        ),
                        onPressed: LocalAuthenticationService
                            .localAuthenticationConfig
                            .authenticateWithBiometrics,
                      ),
                    ],
                  ),
          ],
        ),
      ],
    );
  }
}
