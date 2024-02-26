import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_farma_app/app/routes/routes.dart';
import 'package:to_farma_app/app/themes/themes,.dart';
import 'package:to_farma_app/core/providers/providers.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

//device preview
import 'package:device_preview/device_preview.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: MultiProvidersInit.initProviders(), child: _MyApp());
    // return const _MyApp();
  }
}

class _MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appThemeProvider = Provider.of<AppThemeProvider>(context);

    return MaterialApp(
      ///configurations device preview
      /// luego desconmentar locale: const Locale('es', 'MX'), y comentar las tres propiedades de device preview
      //useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,

      debugShowCheckedModeBanner: false,
      theme: appThemeProvider.themeData,
      title: 'ToFarma',
      darkTheme: darkTheme,
      themeMode: appThemeProvider.themeMode,
      //home: const SplashScreen(),
      //locale: const Locale('es', 'MX'),
      routes: AppRoutes.getRoutes(),
      initialRoute: AppRoutes.initialRoute,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('es', 'MX'),
      ],
    );
  }
}
