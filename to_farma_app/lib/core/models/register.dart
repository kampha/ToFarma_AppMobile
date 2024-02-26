import 'dart:convert';

Register registerFromJson(String str) => Register.fromJson(json.decode(str));

String registerToJson(Register data) => json.encode(data.toJson());

class Register {
  Register({
    this.email,
    this.password,
    this.birthDate,
    this.phone,
    this.name,
    this.address,
    this.identification,
  });

  String? email;
  String? password;
  DateTime? birthDate;
  String? phone;
  String? name;
  String? address;
  String? identification;

  factory Register.fromJson(Map<String, dynamic> json) => Register(
        email: json["email"],
        password: json["password"],
        birthDate: DateTime.parse(json["birthDate"]),
        phone: json["phone"],
        name: json["name"],
        address: json["address"],
        identification: json["identification"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
        "birthDate":
            "${birthDate?.year.toString().padLeft(4, '0')}-${birthDate?.month.toString().padLeft(2, '0')}-${birthDate?.day.toString().padLeft(2, '0')}",
        "phone": phone,
        "name": name,
        "address": address,
        "identification": identification,
      };
}
