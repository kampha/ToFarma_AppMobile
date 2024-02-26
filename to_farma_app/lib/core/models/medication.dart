import 'dart:convert';

Map<String, List<Medication>> medicationFromJson(String str) =>
    Map.from(json.decode(str)).map((k, v) => MapEntry<String, List<Medication>>(
        k, List<Medication>.from(v.map((x) => Medication.fromJson(x)))));

String medicationToJson(Map<String, List<Medication>> data) =>
    json.encode(Map.from(data).map((k, v) => MapEntry<String, dynamic>(
        k, List<dynamic>.from(v.map((x) => x.toJson())))));

class Medication {
  Medication({
    required this.id,
    required this.presentation,
    required this.dose,
    required this.takeTime,
    required this.medicineId,
    required this.patientId,
    required this.createdAt,
    this.updatedAt,
    required this.rmId,
    required this.rmdId,
    required this.rmPacienteId,
    required this.notify,
    required this.canceled,
    required this.medicine,
  });

  int id;
  String presentation;
  String dose;
  String takeTime;
  int medicineId;
  int patientId;
  DateTime createdAt;
  dynamic updatedAt;
  int rmId;
  int rmdId;
  int rmPacienteId;
  int notify;
  int canceled;
  Medicine medicine;

  factory Medication.fromJson(Map<String, dynamic> json) => Medication(
        id: json["id"],
        presentation: json["presentation"],
        dose: json["dose"],
        takeTime: json["take_time"],
        medicineId: json["medicine_id"],
        patientId: json["patient_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"],
        rmId: json["rm_id"],
        rmdId: json["rmd_id"],
        rmPacienteId: json["rm_paciente_id"],
        notify: json["notify"],
        canceled: json["canceled"],
        medicine: Medicine.fromJson(json["medicine"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "presentation": presentation,
        "dose": dose,
        "take_time": takeTime,
        "medicine_id": medicineId,
        "patient_id": patientId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt,
        "rm_id": rmId,
        "rmd_id": rmdId,
        "rm_paciente_id": rmPacienteId,
        "notify": notify,
        "canceled": canceled,
        "medicine": medicine.toJson(),
      };
}

class Medicine {
  Medicine({
    required this.id,
    required this.logo,
    required this.name,
    required this.measurementUnit,
    required this.presentations,
    required this.quantity,
    required this.dataSheet,
    required this.createdAt,
    required this.updatedAt,
    required this.type,
    required this.administrationRoute,
  });

  int id;
  String logo;
  String name;
  String measurementUnit;
  String presentations;
  int quantity;
  String dataSheet;
  DateTime createdAt;
  DateTime updatedAt;
  String type;
  String administrationRoute;

  factory Medicine.fromJson(Map<String, dynamic> json) => Medicine(
        id: json["id"],
        logo: json["logo"],
        name: json["name"],
        measurementUnit: json["measurement_unit"],
        presentations: json["presentations"],
        quantity: json["quantity"],
        dataSheet: json["data_sheet"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        type: json["type"],
        administrationRoute: json["administration_route"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "logo": logo,
        "name": name,
        "measurement_unit": measurementUnit,
        "presentations": presentations,
        "quantity": quantity,
        "data_sheet": dataSheet,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "type": type,
        "administration_route": administrationRoute,
      };
}
