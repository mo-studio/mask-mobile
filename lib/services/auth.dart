import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:MASK/services/api.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

Future<bool> authenticate() async {  
  final appAuth = FlutterAppAuth();
  final storage = new FlutterSecureStorage();
  try {
    final AuthorizationTokenResponse result =
      await appAuth.authorizeAndExchangeCode(
      AuthorizationTokenRequest(
        'nodejs-app',
        'com.corellian.mask://login-callback',
        issuer: API.env.authURL + 'auth/realms/example',
        scopes: ['openid', 'profile'],
        promptValues: ['login']
      ),
    );
    await storage.write(key: 'accessToken', value: result.accessToken.toString());
    await storage.write(key: 'refreshToken', value: result.refreshToken.toString());
    API.accessToken = result.accessToken;
    API.refreshToken = result.refreshToken;
    return true;
  } catch(e) {
    print(e);
    return false;
  }
}

Future<bool> logout() async {
  http.Client client = IOClient();

  final url = API.env.authURL + "auth/realms/example/protocol/openid-connect/logout?redirect_uri=com.corellian.mask%3A%2F%2F";
  final res = await client.post(url,
    headers: {"Content-Type": "application/x-www-form-urlencoded", "Authorization": "Bearer ${API.accessToken}"},
    body: {"client_id": "nodejs-app", "refresh_token": "${API.refreshToken}"});
  if (res.statusCode == 204) {
    final storage = new FlutterSecureStorage();
    await storage.delete(key: 'accessToken');
    await storage.delete(key: 'refreshToken');
    return true;
  } else {
    throw Exception('Failed to log out');
  }
}
