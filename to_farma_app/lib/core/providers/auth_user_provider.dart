import 'package:flutter/material.dart';

class AuthUserProvider extends ChangeNotifier {
  String _identificationLogin = "";
  String _passwordLogin = "";

  String _username = "";
  String _password = "";
  String _cedula = "";
  String _email = "";
  String _telefono = "";
  String _direccion = "";
  String _fechaNacimiento = "2022-12-31";

  bool _isVisisblePassword = true;

  ///GET
  String get identificationLogin => _identificationLogin;
  String get passwordLogin => _passwordLogin;

  String get password => _password;
  String get userName => _username;
  String get email => _email;
  String get cedula => _cedula;
  bool get isVisisblePassword => _isVisisblePassword;
  String get telefono => _telefono;
  String get direccion => _direccion;
  String get fechaNacimiento => _fechaNacimiento;

  ///SET
  set identificationLogin(String value) {
    _identificationLogin = value;
    notifyListeners();
  }

  set passwordLogin(String password) {
    _passwordLogin = password;
    notifyListeners();
  }

  set userName(String user) {
    _username = user;
    notifyListeners();
  }

  set password(String value) {
    _password = value;
    notifyListeners();
  }

  set cedula(String value) {
    _cedula = value;
    notifyListeners();
  }

  set email(String value) {
    _email = value;
    notifyListeners();
  }

  set isVisisblePassword(bool isVisible) {
    _isVisisblePassword = isVisible;
    notifyListeners();
  }

  set telefono(String value) {
    _telefono = value;
    notifyListeners();
  }

  set direccion(String value) {
    _direccion = value;
    notifyListeners();
  }

  set fechaNacimiento(String value) {
    _fechaNacimiento = value;
    notifyListeners();
  }

  //validacion de login
  bool isValidateForm() {
    return (identificationLogin.length >= 11 && passwordLogin.length >= 6)
        ? true
        : false;
  }

  //validacion de registro
  bool isValidateRegister() {
    return (userName.isNotEmpty &&
            cedula.length >= 11 &&
            email.isNotEmpty &&
            password.isNotEmpty &&
            direccion.isNotEmpty &&
            telefono.length >= 9 &&
            fechaNacimiento.length >= 6)
        ? true
        : false;
  }

  void cleanLogin() {
    _identificationLogin = '';
    _passwordLogin = '';
  }

  void cleanRegister() {
    _cedula = "";
    _direccion = "";
    _telefono = "";
    _fechaNacimiento = "";
    _password = "";
    _username = "";
    _email = "";
  }
  bool isValidEmailRecover(){
    return email.isNotEmpty;
  }
}
