import 'package:local_auth/local_auth.dart';
import 'package:message/Component/LocalAuthenticationConfig.dart';

class LocalAuthenticationService {
  static LocalAuthentication localAuthentication = new LocalAuthentication();

  static LocalAuthenticationConfig localAuthenticationConfig =
      new LocalAuthenticationConfig(localAuthentication: localAuthentication);
}
