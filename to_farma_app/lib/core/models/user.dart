import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    required this.id,
    this.token,
    required this.name,
    this.phone,
    required this.identification,
    this.education,
    this.notes,
    this.address,
    this.addressLink,
    this.occupation,
    this.birthDate,
    required this.email,
    this.emailVerifiedAt,
    this.avatar,
    required this.createdAt,
    this.updatedAt,
    required this.isActive,
    this.firebaseToken,
    required this.medicationNotify,
    this.adherenceValue,
    this.adherenceCategorisation,
    this.diagnosticValue,
    this.diagnosticCategorisation,
    required this.roles,
    required this.adherencesAppliedToMe,
    required this.diagnosticsAppliedToMe,
  });

  int id;
  dynamic token;
  String name;
  dynamic phone;
  String identification;
  dynamic education;
  dynamic notes;
  dynamic address;
  dynamic addressLink;
  dynamic occupation;
  dynamic birthDate;
  String email;
  dynamic emailVerifiedAt;
  dynamic avatar;
  DateTime createdAt;
  dynamic updatedAt;
  int isActive;
  dynamic firebaseToken;
  int medicationNotify;
  dynamic adherenceValue;
  dynamic adherenceCategorisation;
  dynamic diagnosticValue;
  dynamic diagnosticCategorisation;
  List<Role> roles;
  List<SAppliedToMe> adherencesAppliedToMe;
  List<SAppliedToMe> diagnosticsAppliedToMe;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        token: json["token"],
        name: json["name"],
        phone: json["phone"],
        identification: json["identification"],
        education: json["education"],
        notes: json["notes"] ?? '',
        address: json["address"],
        addressLink: json["address_link"],
        occupation: json["occupation"],
        birthDate: json["birth_date"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"] ?? '',
        avatar: json["avatar"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"],
        isActive: json["is_active"],
        firebaseToken: json["firebase_token"] ?? '',
        medicationNotify: json["medication_notify"],
        adherenceValue: json["adherence_value"] ?? '0',
        adherenceCategorisation: json["adherence_categorisation"],
        diagnosticValue: json["diagnostic_value"] ?? '0',
        diagnosticCategorisation: json["diagnostic_categorisation"],
        roles: List<Role>.from(json["roles"].map((x) => Role.fromJson(x))),
        adherencesAppliedToMe: List<SAppliedToMe>.from(
            json["adherences_applied_to_me"]
                .map((x) => SAppliedToMe.fromJson(x))),
        diagnosticsAppliedToMe: List<SAppliedToMe>.from(
            json["diagnostics_applied_to_me"]
                .map((x) => SAppliedToMe.fromJson(x))),
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
            "${birthDate?.year.toString().padLeft(4, '0')}-${birthDate?.month.toString().padLeft(2, '0')}-${birthDate?.day.toString().padLeft(2, '0')}",
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "avatar": avatar,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt,
        "is_active": isActive,
        "firebase_token": firebaseToken,
        "medication_notify": medicationNotify,
        "adherence_value": adherenceValue,
        "adherence_categorisation": adherenceCategorisation,
        "diagnostic_value": diagnosticValue,
        "diagnostic_categorisation": diagnosticCategorisation,
        "roles": List<dynamic>.from(roles.map((x) => x.toJson())),
        "adherences_applied_to_me":
            List<dynamic>.from(adherencesAppliedToMe.map((x) => x.toJson())),
        "diagnostics_applied_to_me":
            List<dynamic>.from(diagnosticsAppliedToMe.map((x) => x.toJson())),
      };
}

class SAppliedToMe {
  SAppliedToMe({
    required this.id,
    required this.interviewedName,
    this.interviewedBirthday,
    required this.interviewedIdentification,
    this.patientParticipation,
    required this.answersJson,
    required this.isInterviewedEvaluation,
    required this.patientId,
    required this.pharmacistId,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String interviewedName;
  DateTime? interviewedBirthday;
  String interviewedIdentification;
  String? patientParticipation;
  String answersJson;
  int isInterviewedEvaluation;
  int patientId;
  int pharmacistId;
  DateTime createdAt;
  DateTime updatedAt;

  factory SAppliedToMe.fromJson(Map<String, dynamic> json) => SAppliedToMe(
        id: json["id"],
        interviewedName: json["interviewed_name"],
        interviewedBirthday: json["interviewed_birthday"] == null
            ? null
            : DateTime.parse(json["interviewed_birthday"]),
        interviewedIdentification: json["interviewed_identification"],
        patientParticipation: json["patient_participation"],
        answersJson: json["answers_json"],
        isInterviewedEvaluation: json["is_interviewed_evaluation"],
        patientId: json["patient_id"],
        pharmacistId: json["pharmacist_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "interviewed_name": interviewedName,
        "interviewed_birthday":
            "${interviewedBirthday!.year.toString().padLeft(4, '0')}-${interviewedBirthday!.month.toString().padLeft(2, '0')}-${interviewedBirthday!.day.toString().padLeft(2, '0')}",
        "interviewed_identification": interviewedIdentification,
        "patient_participation": patientParticipation,
        "answers_json": answersJson,
        "is_interviewed_evaluation": isInterviewedEvaluation,
        "patient_id": patientId,
        "pharmacist_id": pharmacistId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class Role {
  Role({
    required this.id,
    required this.name,
    required this.guardName,
    required this.createdAt,
    required this.updatedAt,
    required this.pivot,
  });

  int id;
  String name;
  String guardName;
  DateTime createdAt;
  DateTime updatedAt;
  Pivot pivot;

  factory Role.fromJson(Map<String, dynamic> json) => Role(
        id: json["id"],
        name: json["name"],
        guardName: json["guard_name"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        pivot: Pivot.fromJson(json["pivot"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "guard_name": guardName,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "pivot": pivot.toJson(),
      };
}

class Pivot {
  Pivot({
    required this.modelId,
    required this.roleId,
    required this.modelType,
  });

  int modelId;
  int roleId;
  String modelType;

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
        modelId: json["model_id"],
        roleId: json["role_id"],
        modelType: json["model_type"],
      );

  Map<String, dynamic> toJson() => {
        "model_id": modelId,
        "role_id": roleId,
        "model_type": modelType,
      };
}
