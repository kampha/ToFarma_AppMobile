import 'package:to_farma_app/core/models/medication.dart';

class MedicationInformation {
  MedicationInformation({required this.horario, required this.medicamentos});
  String horario;
  List<Medication> medicamentos;

  Map<String, dynamic> toJson() =>
      {"horario": horario, "medicamentos": medicamentos};
}

class MedicationInformationGroup {
  String group;
  List<MedicationInformation> items;

  MedicationInformationGroup({required this.group, required this.items});

  Map<String, dynamic> toJson() => {"group": group, "items": items};
}
