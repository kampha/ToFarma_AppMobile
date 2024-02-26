import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesPatientService {
  static late SharedPreferences _preferences;

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static String token = "";

  //Método para guardar un valor String
  static Future setString(String key, String value) async =>
      await _preferences.setString(key, value);

  //Método para obtener un valor String
  static String? getString(String key) => _preferences.getString(key);

  ///setear y guadar en las preferencias
  static set setToken(String value) {
    token = value;
    _preferences.setString('net_token', value);
  }

  ///obtener las preferences
  static String get getToken => _preferences.getString('net_token') ?? '';

  //Método para eliminar un valor en las preferences
  static Future remove(String key) async => await _preferences.remove(key);
}
