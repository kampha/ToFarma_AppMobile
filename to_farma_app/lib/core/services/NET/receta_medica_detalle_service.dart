import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:to_farma_app/core/models/models.dart';
import 'package:http/http.dart' as http;
import 'package:to_farma_app/core/server/server.dart';
import 'package:to_farma_app/core/shared_preferences/preferences_paciente.dart';
import 'package:to_farma_app/core/utlis/code_responseNET.dart';

class RecetaMedicaDetalleService extends ChangeNotifier {
  NETConfig config = NETConfig();
  final String prefix = NETConfig.prefix;
  final String version = NETConfig.version1;
  final String endPoitn = "RecetaMedicaDetalle/Todos";
  bool isLoading = true;

  FutureResponse future = FutureResponse(respuesta: false, mensaje: null);

  Future<FutureResponse> getRecetaMedicaDetalle(
      String numeroreceta, int recetamedicaid) async {
    try {
      String id = recetamedicaid.toString();

      final url =
          Uri.https(NETConfig.baseUrl, "$prefix/$version/$endPoitn/$id");

      final response = await http.get(url,
          headers: config
              .headerAutenticar(SharedPreferencesPatientService.getToken));

      Map<String, dynamic> jsonMap = json.decode(response.body);

      switch (response.statusCode) {
        case CodeResponseNET.Success:
          RecetaMedicaDetalle model = RecetaMedicaDetalle.fromJson(jsonMap);

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
              "Error al consumir el servicio para obtener el detalle de receta médica número $numeroreceta";
      }
    } catch (e) {
      future.mensaje = e;
    }

    isLoading = false;
    notifyListeners();
    return future;
  }
}
