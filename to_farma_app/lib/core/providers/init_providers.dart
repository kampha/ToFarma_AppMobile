import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:to_farma_app/core/providers/providers.dart';
import 'package:to_farma_app/core/services/services.dart';

class MultiProvidersInit {
  /// Inicializa la lista de proveedores.

  static List<SingleChildWidget> initProviders() {
    return <SingleChildWidget>[
      ChangeNotifierProvider<AppThemeProvider>(
          create: (_) => AppThemeProvider()),
      ChangeNotifierProvider<PermissionsProvider>(
        create: (_) => PermissionsProvider(),
      ),
      ChangeNotifierProvider<ConfigurationProvider>(
        create: (context) => ConfigurationProvider(),
      ),
      ChangeNotifierProvider<AuthUserProvider>(
        create: (_) => AuthUserProvider(),
      ),
      ChangeNotifierProvider<LoadingProviders>(
        create: (context) => LoadingProviders(),
      ),
      ChangeNotifierProvider(
        create: (_) => OAuthLaravelServices(),
      ),
      ChangeNotifierProvider(
        create: (_) => UsersServices(),
      ),
      ChangeNotifierProvider(
        create: (_) => MedicationsServices(),
      ),
      ChangeNotifierProvider(
        create: (_) => PostsServices(),
      ),
      ChangeNotifierProvider(
        create: (_) => CifradoService(),
      ),
      ChangeNotifierProvider(
        create: (_) => MensajesServices(),
      ),
      ChangeNotifierProvider(
        create: (_) => PacienteService(),
      ),
      ChangeNotifierProvider(
        create: (_) => RecetaMedicaService(),
      ),
      ChangeNotifierProvider(
        create: (_) => RecetaMedicaDetalleService(),
      ),
      ChangeNotifierProvider(
        create: (_) => MedicacionService(),
      ),
      ChangeNotifierProvider(
        create: (_) => PharmacovigilanceProvider(),
      ),
    ];
  }
}
