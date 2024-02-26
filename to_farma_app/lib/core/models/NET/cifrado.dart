import 'dart:convert';

class Cifrado {
  String message;
  String? data;

  Cifrado({
    required this.message,
    this.data,
  });

  factory Cifrado.fromRawJson(String str) => Cifrado.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Cifrado.fromJson(Map<String, dynamic> json) => Cifrado(
        message: json["message"],
        data: json["data"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data,
      };
}
