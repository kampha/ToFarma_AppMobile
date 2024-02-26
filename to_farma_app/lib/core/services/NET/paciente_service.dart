import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:to_farma_app/core/models/models.dart';
import 'package:http/http.dart' as http;
import 'package:to_farma_app/core/server/server.dart';
import 'package:to_farma_app/core/shared_preferences/preferences_paciente.dart';
import 'package:to_farma_app/core/utlis/code_responseNET.dart';

class PacienteService extends ChangeNotifier {
  NETConfig config = NETConfig();
  final String prefix = NETConfig.prefix;
  final String version = NETConfig.version1;
  final String endPoitn = "Paciente/Seleccionar/Cedula";
  final storage = const FlutterSecureStorage();

  FutureResponse future = FutureResponse(respuesta: false, mensaje: null);

  Future<FutureResponse> getPaciente() async {
    try {
      String cedula = await storage.read(key: "cedulaUser") ?? '';

      final url =
          Uri.https(NETConfig.baseUrl, "$prefix/$version/$endPoitn/$cedula");

      final response = await http.get(url,
          headers: config
              .headerAutenticar(SharedPreferencesPatientService.getToken));

      Map<String, dynamic> jsonMap = json.decode(response.body);

      switch (response.statusCode) {
        case CodeResponseNET.Success:
          Paciente model = Paciente.fromJson(jsonMap);

          await storage.write(
              key: "identificadorPaciente",
              value: model.data.identificador.toString());

          future.respuesta = true;
          future.model = model;
          break;
        case CodeResponseNET.Authorization:
        case CodeResponseNET.Server:
          Error model = Error.fromJson(jsonMap);

          future.mensaje = model.error;
          break;
        default:
          future.mensaje =
              "Error al consumir el servicio para obtener el paciente";
      }
    } catch (e) {
      future.mensaje = e;
    }

    return future;
  }
}
