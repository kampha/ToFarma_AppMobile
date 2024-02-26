import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:to_farma_app/core/models/models.dart';
import 'package:http/http.dart' as http;
import 'package:to_farma_app/core/server/server.dart';
import 'package:to_farma_app/core/shared_preferences/preferences_paciente.dart';
import 'package:to_farma_app/core/utlis/code_responseNET.dart';

class RecetaMedicaService extends ChangeNotifier {
  NETConfig config = NETConfig();
  final String prefix = NETConfig.prefix;
  final String version = NETConfig.version1;
  final String endPoitn = "RecetaMedica/Paciente";
  final storage = const FlutterSecureStorage();
  bool isLoading = true;

  FutureResponse future = FutureResponse(respuesta: false, mensaje: null);

  Future<FutureResponse> getRecetaMedica() async {
    try {
      isLoading = true;
      future.respuesta = false;

      String identificador =
          await storage.read(key: "identificadorPaciente") ?? '';

      final url = Uri.https(
          NETConfig.baseUrl, "$prefix/$version/$endPoitn/$identificador");

      final response = await http.get(url,
          headers: config
              .headerAutenticar(SharedPreferencesPatientService.getToken));

      Map<String, dynamic> jsonMap = json.decode(response.body);

      switch (response.statusCode) {
        case CodeResponseNET.Success:
          final RecetaMedica model = RecetaMedica.fromJson(jsonMap);

          future.model = model;
          future.respuesta = true;
          break;
        case CodeResponseNET.Authorization:
        case CodeResponseNET.Server:
          Error model = Error.fromJson(jsonMap);

          future.mensaje = model.error;
          break;
        default:
          future.mensaje =
              "Error al consumir el servicio para obtener las recetas médicas";
      }
    } catch (e) {
      future.mensaje = e;
    }

    isLoading = false;
    notifyListeners();
    return future;
  }
}
