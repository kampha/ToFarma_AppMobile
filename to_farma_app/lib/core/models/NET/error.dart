import 'dart:convert';

class Error {
  String error;
  String? tracer;

  Error({
    required this.error,
    this.tracer,
  });

  factory Error.fromRawJson(String str) => Error.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Error.fromJson(Map<String, dynamic> json) => Error(
        error: json["error"],
        tracer: json["tracer"],
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "tracer": tracer,
      };
}
