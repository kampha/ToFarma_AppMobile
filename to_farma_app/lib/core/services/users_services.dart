import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:to_farma_app/core/models/models.dart';
import 'package:to_farma_app/core/server/server.dart';
import 'package:http/http.dart' as http;
import 'package:to_farma_app/core/shared_preferences/preferences_paciente.dart';

import '../shared_preferences/preferences_user.dart';

class UsersServices extends ChangeNotifier {
  final String prefix = LaravelConfig.prefix;
  final LaravelConfig config = LaravelConfig();
  final String urlBackend = LaravelConfig.baseUrl;
  final storage = const FlutterSecureStorage();

  Future<User> getUser() async {
    final url = Uri.https(
      LaravelConfig.baseUrl,
      '$prefix/user',
    );

    final respuesta = await http.get(url,
        headers: config.header(SharedPreferencesService.getToken));

    final usuario = respuesta.body;
    final user = userFromJson(usuario);

    if (respuesta.statusCode == 200) {
      final String avatar = user.avatar.toString();
      final String image = 'https://$urlBackend/storage/$avatar';

      await storage.write(key: "idUser", value: user.id.toString());
      await storage.write(key: "nameUser", value: user.name.toString());
      await storage.write(
          key: "cedulaUser", value: user.identification.toString());
      await storage.write(key: "emailUser", value: user.email.toString());
      await storage.write(key: "avatarUser", value: image);
      await storage.write(
          key: "firebaseTokenUser", value: user.firebaseToken.toString());
      await storage.write(
          key: "idmedicationNotifyUser",
          value: user.medicationNotify.toString());
      await storage.write(
          key: "adherenceValueUser",
          value: user.adherenceValue.toString() == ''
              ? '0'
              : user.adherenceValue.toString());
      await storage.write(
          key: "diagnosticValueUser",
          value: user.diagnosticValue.toString() == ''
              ? '0'
              : user.diagnosticValue.toString());
      await storage.write(
          key: "adherenceCategorisationUser",
          value: user.adherenceCategorisation.toString());
      await storage.write(
          key: "diagnosticCategorisationUser",
          value: user.diagnosticCategorisation.toString());
      await storage.write(key: "phoneUser", value: user.phone.toString());
    }

    return user;
  }

  Future<bool> registerUser(Register model) async {
    final url = Uri.https(
      LaravelConfig.baseUrl,
      '$prefix/patient/register',
    );
    final respuesta = await http.post(url, body: model.toJson());
    if (respuesta.statusCode == 200) {
      return true;
    }
    return false;
  }

  Future<User> getInfo() async {
    List<Role> roles = [];
    List<SAppliedToMe> adherencesAppliedToMe = [];

    final user = User(
        id: int.parse(await storage.read(key: "idUser") ?? '0'),
        name: await storage.read(key: "nameUser") ?? '',
        identification: await storage.read(key: "cedulaUser") ?? '',
        email: await storage.read(key: "emailUser") ?? '',
        avatar: await storage.read(key: "avatarUser"),
        createdAt: DateTime.now(),
        firebaseToken: await storage.read(key: "firebaseTokenUser"),
        medicationNotify:
            int.parse(await storage.read(key: "idmedicationNotifyUser") ?? '0'),
        adherenceValue: await storage.read(key: "adherenceValueUser"),
        adherenceCategorisation:
            await storage.read(key: "adherenceCategorisationUser"),
        diagnosticValue: await storage.read(key: "diagnosticValueUser"),
        diagnosticCategorisation:
            await storage.read(key: "diagnosticCategorisationUser"),
        roles: roles,
        adherencesAppliedToMe: adherencesAppliedToMe,
        diagnosticsAppliedToMe: adherencesAppliedToMe,
        isActive: 1,
        phone: await storage.read(key: "phoneUser"));

    return user;
  }

  Future deleteInfo() async {
    await SharedPreferencesService.remove("token");
    await SharedPreferencesPatientService.remove("net_token");
    await storage.deleteAll();
  }

  Future<bool> changeMedicationNotify(int medicationNotify) async {
    final url = Uri.https(
      LaravelConfig.baseUrl,
      '${LaravelConfig.prefix}/patient/medicationNotify',
    );
    final LaravelConfig config = LaravelConfig();

    final respuesta = await http.post(url,
        headers: config.header(SharedPreferencesService.getToken),
        body: {'MedicationNotifyValue': medicationNotify.toString()});
    return respuesta.statusCode == 200;
  }

  Future<bool> recoverPassword(String email) async {
    final url = Uri.https(
      LaravelConfig.baseUrl,
      '${LaravelConfig.prefix}/password/email',
    );
    final respuesta = await http.post(url, body: {'email': email});
    return respuesta.statusCode == 200;
  }
}
