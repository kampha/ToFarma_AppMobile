import 'package:flutter/material.dart';
import 'package:to_farma_app/core/models/models.dart';
import 'package:to_farma_app/core/server/server.dart';
import 'package:http/http.dart' as http;

import '../shared_preferences/preferences_user.dart';

class MedicationsServices extends ChangeNotifier {
  final String prefix = LaravelConfig.prefix;
  final config = LaravelConfig();

  final List<MedicationInformation> lstMedicamentos = [];
  List<MedicationInformationGroup> lstMedicamentosGroups = [];

  Future<List<MedicationInformation>> getTodayMedication() async {
    lstMedicamentos.clear();
    final url =
        Uri.https(LaravelConfig.baseUrl, '$prefix/patient/todayMedication');

    final respuesta = await http.get(url,
        headers: config.header(SharedPreferencesService.getToken));

    if (respuesta.body != '[]' && respuesta.statusCode == 200) {
      List<MedicationInformation> medicamentosLst = [];
      final resp = medicationFromJson(respuesta.body);
      resp.forEach((key, value) {
        final temp = MedicationInformation(horario: key, medicamentos: value);
        lstMedicamentos.add(temp);
        medicamentosLst.add(temp);
        return;
      });
      return medicamentosLst;
    }
    return lstMedicamentos;
  }

  Future<List<MedicationInformationGroup>> getMedicationsGroup() async {
    lstMedicamentos.clear();
    lstMedicamentosGroups.clear();

    final url =
        Uri.https(LaravelConfig.baseUrl, '$prefix/patient/todayMedication');

    final respuesta = await http.get(url,
        headers: config.header(SharedPreferencesService.getToken));

    if (respuesta.body != '[]' && respuesta.statusCode == 200) {
      final resp = medicationFromJson(respuesta.body);
      final List<MedicationInformation> medicamentosHora =
          <MedicationInformation>[];

      resp.forEach((key, value) {
        final temp = MedicationInformation(horario: key, medicamentos: value);
        medicamentosHora.add(temp);
      });
      final List<MedicationInformationGroup> grupoHorario =
          <MedicationInformationGroup>[];
      List<MedicationInformation> dia = [];
      List<MedicationInformation> tarde = [];
      List<MedicationInformation> noche = [];
      grupoHorario
          .add(MedicationInformationGroup(group: 'Mañana', items: dia));
      grupoHorario
          .add(MedicationInformationGroup(group: 'Tarde', items: tarde));
      grupoHorario
          .add(MedicationInformationGroup(group: 'Noche', items: noche));
      for (MedicationInformation temp in medicamentosHora) {
        int hour = int.parse(temp.horario.substring(0, 2));
        if ((temp.horario.contains("AM"))&& hour >= 6 && hour < 12 ) {
          //Mañana
          if (grupoHorario.isNotEmpty) {
            for (var search in grupoHorario) {
              if (search.group == "Mañana") {
                search.items.add(temp);
              }
            }
          } 
        }else if((hour == 12 && temp.horario.contains("PM")) || (hour >= 1 && hour <= 5 && temp.horario.contains("PM"))){
          if (grupoHorario.isNotEmpty) {
            for (var search in grupoHorario) {
              if (search.group == "Tarde") {
                search.items.add(temp);
              }
            }
          }
        }else{
          if (grupoHorario.isNotEmpty) {
            for (var search in grupoHorario) {
              if (search.group == "Noche") {
                search.items.add(temp);
              }
            }
          }
        }
      }
      return grupoHorario;
    }
    return lstMedicamentosGroups;
  }
}
