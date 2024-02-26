import 'dart:convert';
import 'package:to_farma_app/core/models/NET/auditoria.dart';

class RecetaMedicaDetalle {
  String message;
  List<DatumRMD> data;

  RecetaMedicaDetalle({
    required this.message,
    required this.data,
  });

  factory RecetaMedicaDetalle.fromRawJson(String str) =>
      RecetaMedicaDetalle.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RecetaMedicaDetalle.fromJson(Map<String, dynamic> json) =>
      RecetaMedicaDetalle(
        message: json["message"],
        data:
            List<DatumRMD>.from(json["data"].map((x) => DatumRMD.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class DatumRMD {
  int id;
  int linea;
  int rmId;
  int medicinaActualId;
  String via;
  int dosis;
  String unidadDosis;
  int frecuencia;
  String unidadFrecuencia;
  int duracion;
  String unidadDuracion;
  String prescripcion;
  Medicina medicina;
  Auditoria auditoria;

  DatumRMD(
      {required this.id,
      required this.linea,
      required this.rmId,
      required this.medicinaActualId,
      required this.via,
      required this.dosis,
      required this.unidadDosis,
      required this.frecuencia,
      required this.unidadFrecuencia,
      required this.duracion,
      required this.unidadDuracion,
      required this.prescripcion,
      required this.medicina,
      required this.auditoria});

  factory DatumRMD.fromRawJson(String str) =>
      DatumRMD.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DatumRMD.fromJson(Map<String, dynamic> json) => DatumRMD(
        id: json["id"],
        linea: json["linea"],
        rmId: json["rm_id"],
        medicinaActualId: json["medicina_actual_id"],
        via: json["via"],
        dosis: json["dosis"],
        unidadDosis: json["unidad_dosis"],
        frecuencia: json["frecuencia"],
        unidadFrecuencia: json["unidad_frecuencia"],
        duracion: json["duracion"],
        unidadDuracion: json["unidad_duracion"],
        prescripcion: json["prescripcion"],
        medicina: Medicina.fromJson(json["medicina"]),
        auditoria: Auditoria.fromJson(json["auditoria"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "linea": linea,
        "rm_id": rmId,
        "medicina_actual_id": medicinaActualId,
        "via": via,
        "dosis": dosis,
        "unidad_dosis": unidadDosis,
        "frecuencia": frecuencia,
        "unidad_frecuencia": unidadFrecuencia,
        "duracion": duracion,
        "unidad_duracion": unidadDuracion,
        "prescripcion": prescripcion,
        "medicina": medicina.toJson(),
        "auditoria": auditoria.toJson()
      };
}

class Medicina {
  int id;
  String codigoBarra;
  int medicinaActualId;
  String descripcion;
  String unidadDosis;
  String via;
  int cfId;
  Auditoria auditoria;
  String? imagen;

  Medicina({
    required this.id,
    required this.codigoBarra,
    required this.medicinaActualId,
    required this.descripcion,
    required this.unidadDosis,
    required this.via,
    required this.cfId,
    required this.auditoria,
    this.imagen,
  });

  factory Medicina.fromRawJson(String str) =>
      Medicina.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Medicina.fromJson(Map<String, dynamic> json) => Medicina(
        id: json["id"],
        codigoBarra: json["codigo_barra"],
        medicinaActualId: json["medicina_actual_id"],
        descripcion: json["descripcion"],
        unidadDosis: json["unidad_dosis"],
        via: json["via"],
        cfId: json["cf_id"],
        auditoria: Auditoria.fromJson(json["auditoria"]),
        imagen: json["imagen"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "codigo_barra": codigoBarra,
        "medicina_actual_id": medicinaActualId,
        "descripcion": descripcion,
        "unidad_dosis": unidadDosis,
        "via": via,
        "cf_id": cfId,
        "auditoria": auditoria.toJson(),
        "imagen": imagen,
      };
}
