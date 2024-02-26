import 'dart:convert';

class Auditoria {
  String createdAt;
  dynamic updatedAt;
  dynamic deletedAt;

  Auditoria({
    required this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory Auditoria.fromRawJson(String str) =>
      Auditoria.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Auditoria.fromJson(Map<String, dynamic> json) => Auditoria(
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        deletedAt: json["deleted_at"],
      );

  Map<String, dynamic> toJson() => {
        "created_at": createdAt,
        "updated_at": updatedAt,
        "deleted_at": deletedAt,
      };
}
