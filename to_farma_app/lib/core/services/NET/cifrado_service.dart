import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:to_farma_app/core/models/models.dart';
import 'package:http/http.dart' as http;
import 'package:to_farma_app/core/server/server.dart';
import 'package:to_farma_app/core/shared_preferences/preferences_paciente.dart';

class CifradoService extends ChangeNotifier {
  NETConfig config = NETConfig();
  final String prefix = NETConfig.prefix;
  final String version = NETConfig.version1;
  final String endPoitn = "SeguridadUtilidad/Cifrar";
  final storage = const FlutterSecureStorage();

  FutureResponse future = FutureResponse(respuesta: false, mensaje: '');

  Future<FutureResponse> loadCifrado() async {
    try {
      String userid = await storage.read(key: "idUser") ?? '';
      const String clientid = LaravelConfig.clientSecret;
      final url = Uri.https(NETConfig.baseUrl, "$prefix/$version/$endPoitn");

      final body = jsonEncode({'cadena': "$userid|$clientid"});

      final response = await http.post(url,
          headers: config.headerSinAutenticar(), body: body);

      Map<String, dynamic> jsonMap = json.decode(response.body);

      switch (response.statusCode) {
        case 200:
          Cifrado model = Cifrado.fromJson(jsonMap);
          SharedPreferencesPatientService.setToken = model.data ?? '';

          future.respuesta = true;
          future.model = model;
          break;
        case 500:
          Error model = Error.fromJson(jsonMap);

          future.respuesta = false;
          future.mensaje = model.error;
          break;
        default:
          future.respuesta = false;
          future.mensaje = "Error al consumir el servicio para cifrar token";
      }
    } catch (e) {
      future.respuesta = false;
      future.mensaje = e.toString();
    }

    return future;
  }
}
