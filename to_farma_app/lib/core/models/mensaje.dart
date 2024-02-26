// To parse this JSON data, do
//
//     final mensaje = mensajeFromJson(jsonString);

import 'dart:convert';

List<Mensaje> mensajeFromJson(String str) =>
    List<Mensaje>.from(json.decode(str).map((x) => Mensaje.fromJson(x)));

String mensajeToJson(List<Mensaje> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Mensaje {
  int? id;
  int? senderId;
  int? receiverId;
  String? type;
  String text;
  DateTime createdAt;
  DateTime? updatedAt;
  Receiver? sender;
  Receiver? receiver;

  Mensaje({
    this.id,
    this.senderId,
    this.receiverId,
    this.type,
    required this.text,
    required this.createdAt,
    this.updatedAt,
    this.sender,
    this.receiver,
  });

  factory Mensaje.fromJson(Map<String, dynamic> json) => Mensaje(
        id: json["id"],
        senderId: json["sender_id"],
        receiverId: json["receiver_id"] ?? 8,
        type: json["type"],
        text: json["text"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        sender: Receiver.fromJson(json["sender"]),
        //receiver: Receiver.fromJson(json["receiver"]?? Receiver()),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sender_id": senderId,
        "receiver_id": receiverId,
        "type": type,
        "text": text,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "sender": sender!.toJson(),
        "receiver": receiver!.toJson(),
      };
}

class Receiver {
  int? id;
  String? token;
  String? name;
  String? phone;
  String? identification;
  String? education;
  String? notes;
  String? address;
  String? addressLink;
  String? occupation;
  DateTime? birthDate;
  String? email;
  DateTime? emailVerifiedAt;
  String? avatar;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? isActive;
  String? firebaseToken;
  int? medicationNotify;

  Receiver({
    this.id,
    this.token,
    this.name,
    this.phone,
    this.identification,
    this.education,
    this.notes,
    this.address,
    this.addressLink,
    this.occupation,
    this.birthDate,
    this.email,
    this.emailVerifiedAt,
    this.avatar,
    this.createdAt,
    this.updatedAt,
    this.isActive,
    this.firebaseToken,
    this.medicationNotify,
  });

  factory Receiver.fromJson(Map<String, dynamic> json) => Receiver(
        id: json["id"],
        token: json["token"],
        name: json["name"],
        phone: json["phone"],
        identification: json["identification"],
        education: json["education"],
        notes: json["notes"],
        address: json["address"],
        addressLink: json["address_link"],
        occupation: json["occupation"],
        birthDate: DateTime.parse(json["birth_date"]),
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"] == null
            ? null
            : DateTime.parse(json["email_verified_at"]),
        avatar: json["avatar"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        isActive: json["is_active"],
        firebaseToken: json["firebase_token"],
        medicationNotify: json["medication_notify"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "token": token,
        "name": name,
        "phone": phone,
        "identification": identification,
        "education": education,
        "notes": notes,
        "address": address,
        "address_link": addressLink,
        "occupation": occupation,
        "birth_date":
            "${birthDate!.year.toString().padLeft(4, '0')}-${birthDate!.month.toString().padLeft(2, '0')}-${birthDate!.day.toString().padLeft(2, '0')}",
        "email": email,
        "email_verified_at": emailVerifiedAt?.toIso8601String(),
        "avatar": avatar,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "is_active": isActive,
        "firebase_token": firebaseToken,
        "medication_notify": medicationNotify,
      };
}
