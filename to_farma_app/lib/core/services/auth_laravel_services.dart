import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:to_farma_app/core/models/models.dart';
import 'package:to_farma_app/core/server/server.dart';
import 'package:to_farma_app/core/shared_preferences/preferences_user.dart';

class OAuthLaravelServices extends ChangeNotifier {
  FutureResponse response = FutureResponse(respuesta: false);

  //login de autenticacion
  Future<FutureResponse> authUser(String usuario, String pass) async {
    OauthToken model = OauthToken(
        password: pass,
        username: usuario,
        clientId: LaravelConfig.clientId,
        clientSecret: LaravelConfig.clientSecret,
        grantType: LaravelConfig.grantType,
        scope: LaravelConfig.scope);
    final url = Uri.https(
      LaravelConfig.baseUrl,
      'oauth/token',
    );
    final respuesta = await http.post(url, body: model.toJson());

    ///moverlo a dentro del if cuando este funcional el login con cedula y contra
    if (respuesta.statusCode == 200) {
      final Map<String, dynamic> tokenMap = jsonDecode(respuesta.body);
      SharedPreferencesService.setToken = tokenMap['access_token'].toString();
      response.respuesta = true;
    } else if (respuesta.statusCode == 400) {
      response.respuesta = false;
      final Map<String, dynamic> tokenMap = jsonDecode(respuesta.body);
      if (tokenMap['error'] == 'invalid_grant') {
        response.mensaje = "Revisar el usuario y la contraseña.";
      } else {
        response.mensaje = 'Error al consumir servicio';
      }
    } else {
      response.respuesta = false;
      response.mensaje = "No logramos conectar con el servicio.";
    }

    return response;
  }
}
