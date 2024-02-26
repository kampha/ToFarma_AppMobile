import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:to_farma_app/core/models/models.dart';
import 'package:http/http.dart' as http;
import 'package:to_farma_app/core/server/server.dart';
import 'package:to_farma_app/core/shared_preferences/preferences_paciente.dart';
import 'package:to_farma_app/core/utlis/code_responseNET.dart';

class MedicacionService extends ChangeNotifier {
  NETConfig config = NETConfig();
  final String prefix = NETConfig.prefix;
  final String version = NETConfig.version1;
  final String endPoitn = "Medicacion/Nuevo";
  final storage = const FlutterSecureStorage();
  bool isLoading = true;

  FutureResponse future = FutureResponse(respuesta: false, mensaje: null);

  Future<FutureResponse> postMedicacion(int rmid, int rmdid) async {
    try {
      String cedula = await storage.read(key: "cedulaUser") ?? '';

      final url = Uri.https(NETConfig.baseUrl, "$prefix/$version/$endPoitn");

      final body =
          jsonEncode({"rm_id": rmid, "rmd_id": rmdid, "cedula": cedula});

      final response = await http.post(url,
          headers:
              config.headerAutenticar(SharedPreferencesPatientService.getToken),
          body: body);

      Map<String, dynamic> jsonMap = json.decode(response.body);

      switch (response.statusCode) {
        case CodeResponseNET.Success:
          Medicacion model = Medicacion.fromJson(jsonMap);

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
              "Error al consumir el servicio crear las notificaciones para la medicación";
      }
    } catch (e) {
      future.mensaje = e;
    }

    isLoading = false;
    return future;
  }
}
