import 'dart:convert';
import 'package:to_farma_app/core/models/NET/auditoria.dart';

class Paciente {
  String message;
  Data data;

  Paciente({
    required this.message,
    required this.data,
  });

  factory Paciente.fromRawJson(String str) =>
      Paciente.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Paciente.fromJson(Map<String, dynamic> json) => Paciente(
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  int id;
  String identificador;
  String documentoUnico;
  String email;
  dynamic fechaNacimiento;
  Auditoria auditoria;

  Data({
    required this.id,
    required this.identificador,
    required this.documentoUnico,
    required this.email,
    this.fechaNacimiento,
    required this.auditoria,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        identificador: json["identificador"],
        documentoUnico: json["documento_unico"],
        email: json["email"],
        fechaNacimiento: json["fecha_nacimiento"],
        auditoria: Auditoria.fromJson(json["auditoria"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "identificador": identificador,
        "documento_unico": documentoUnico,
        "email": email,
        "fecha_nacimiento": fechaNacimiento,
        "auditoria": auditoria.toJson(),
      };
}
