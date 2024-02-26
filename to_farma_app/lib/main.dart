import 'package:flutter/material.dart';
import 'package:to_farma_app/app.dart';

import 'package:device_preview/device_preview.dart';
import 'package:to_farma_app/core/shared_preferences/preferences_paciente.dart';
import 'package:to_farma_app/core/shared_preferences/preferences_user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesService.init(); // Inicializa SharedPreferences
  await SharedPreferencesPatientService.init(); // Inicializa SharedPreferences

  runApp(
    DevicePreview(
      enabled: false,

      /// para ver el preview o no.
      builder: (context) => const MyApp(), // Wrap your app
    ),
  );
}
