import 'dart:convert';
import 'package:to_farma_app/core/models/NET/auditoria.dart';
import 'package:to_farma_app/core/models/NET/paciente.dart';

class RecetaMedica {
  String? message;
  List<DatumRM> data;

  RecetaMedica({
    this.message,
    required this.data,
  });

  factory RecetaMedica.fromRawJson(String str) =>
      RecetaMedica.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RecetaMedica.fromJson(Map<String, dynamic> json) => RecetaMedica(
        message: json["message"],
        data: List<DatumRM>.from(json["data"].map((x) => DatumRM.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class DatumRM {
  int id;
  String numero;
  String fechaHora;
  int hpId;
  int pacienteId;
  int peso;
  int estatura;
  int edad;
  int hmId;
  int hospitalId;
  int medicoId;
  String estado;
  String evaluacion;
  Data paciente;
  Hospital hospital;
  Medico medico;
  Auditoria auditoria;

  DatumRM(
      {required this.id,
      required this.numero,
      required this.fechaHora,
      required this.hpId,
      required this.pacienteId,
      required this.peso,
      required this.estatura,
      required this.edad,
      required this.hmId,
      required this.hospitalId,
      required this.medicoId,
      required this.estado,
      required this.evaluacion,
      required this.paciente,
      required this.hospital,
      required this.medico,
      required this.auditoria});

  factory DatumRM.fromRawJson(String str) => DatumRM.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DatumRM.fromJson(Map<String, dynamic> json) => DatumRM(
      id: json["id"],
      numero: json["numero"],
      fechaHora: json["fecha_hora"],
      hpId: json["hp_id"],
      pacienteId: json["paciente_id"],
      peso: json["peso"],
      estatura: json["estatura"],
      edad: json["edad"],
      hmId: json["hm_id"],
      hospitalId: json["hospital_id"],
      medicoId: json["medico_id"],
      estado: json["estado"],
      evaluacion: json["evaluacion"],
      paciente: Data.fromJson(json["paciente"]),
      hospital: Hospital.fromJson(json["hospital"]),
      medico: Medico.fromJson(json["medico"]),
      auditoria: Auditoria.fromJson(json["auditoria"]));

  Map<String, dynamic> toJson() => {
        "id": id,
        "numero": numero,
        "fecha_hora": fechaHora,
        "hp_id": hpId,
        "paciente_id": pacienteId,
        "peso": peso,
        "estatura": estatura,
        "edad": edad,
        "hm_id": hmId,
        "hospital_id": hospitalId,
        "medico_id": medicoId,
        "estado": estado,
        "evaluacion": evaluacion,
        "paciente": paciente.toJson(),
        "hospital": hospital.toJson(),
        "medico": medico.toJson(),
        "auditoria": auditoria.toJson()
      };
}

class Hospital {
  int id;
  String nombre;
  String? url;
  Auditoria auditoria;

  Hospital({
    required this.id,
    required this.nombre,
    this.url,
    required this.auditoria,
  });

  factory Hospital.fromRawJson(String str) =>
      Hospital.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Hospital.fromJson(Map<String, dynamic> json) => Hospital(
        id: json["id"],
        nombre: json["nombre"],
        url: json["url"],
        auditoria: Auditoria.fromJson(json["auditoria"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "url": url,
        "auditoria": auditoria.toJson(),
      };
}

class Medico {
  int id;
  String codigo;
  String nombreCompleto;
  Auditoria auditoria;

  Medico({
    required this.id,
    required this.codigo,
    required this.nombreCompleto,
    required this.auditoria,
  });

  factory Medico.fromRawJson(String str) => Medico.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Medico.fromJson(Map<String, dynamic> json) => Medico(
        id: json["id"],
        codigo: json["codigo"],
        nombreCompleto: json["nombre_completo"],
        auditoria: Auditoria.fromJson(json["auditoria"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "codigo": codigo,
        "nombre_completo": nombreCompleto,
        "auditoria": auditoria.toJson(),
      };
}
