import 'dart:convert';

class Medicacion {
  String message;
  dynamic data;

  Medicacion({
    required this.message,
    this.data,
  });

  factory Medicacion.fromRawJson(String str) =>
      Medicacion.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Medicacion.fromJson(Map<String, dynamic> json) => Medicacion(
        message: json["message"],
        data: json["data"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data,
      };
}
