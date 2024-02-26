import 'package:to_farma_app/core/shared_preferences/preferences_user.dart';

class LaravelConfig {
  static const String clientId = '1';
  static const String clientSecret = 'WTz0Z7oBCRjSQXjHpKVVcEXAwUHdbAZJvHRRpATg';
  static const String grantType = 'password';
  static const String scope = '*';
  static const String baseUrl = 'admin.tofarma.com';
  static const String prefix = 'api';
  static String token = SharedPreferencesService.getToken;
  // ignore: prefer_function_declarations_over_variables

  Map<String, String> header(String token) => {
        'Authorization': 'Bearer $token',
      };
}
