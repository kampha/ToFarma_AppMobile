import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:to_farma_app/app/components/componets.dart';
import 'package:to_farma_app/app/components/menu_home.dart';
import 'package:to_farma_app/app/pages/pages.dart';
import 'package:to_farma_app/app/widgets/widgets.dart';
import 'package:to_farma_app/core/providers/providers.dart';
import 'package:to_farma_app/core/services/services.dart';
import 'package:to_farma_app/core/utlis/utlis.dart';
import 'package:package_info_plus/package_info_plus.dart';

///librerias
import 'package:provider/provider.dart';
import 'package:to_farma_app/version.dart';

class BodyLogin extends StatelessWidget {
  const BodyLogin({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthUserProvider>(context);
    final loagingProvider = Provider.of<LoadingProviders>(context);

    String version = "Versión $versionNameApp";
    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      version = packageInfo.version;
    });

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 20,
                bottom: 10,
              ),
              child: TextFormField(
                  enabled: true,
                  inputFormatters: <TextInputFormatter>[
                    RegularExpressions.formatterIdentification,
                    LengthLimitingTextInputFormatter(14), //cambiar a 11
                  ],
                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
                  style: Fonts.robotoRegularBlack,
                  keyboardType: TextInputType.number,
                  decoration: InputDecorationCustom.getInputDecoration(
                    context: context,
                    hintext: '1-2345-6789',
                    labeltext: 'Cédula',
                    prefixicon: const Icon(Icons.perm_identity),
                  ),
                  onChanged: (value) {
                    authProvider.identificationLogin = value;
                  },
                  validator: (value) {
                    return null;
                  }),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 20,
                bottom: 20,
              ),
              child: TextFormField(
                  autocorrect: false,
                  obscureText: authProvider.isVisisblePassword,
                  inputFormatters: <TextInputFormatter>[
                    LengthLimitingTextInputFormatter(-1), //cambiar a 11
                    FilteringTextInputFormatter.allow(
                        RegularExpressions.regexTest),
                  ],
                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
                  style: Fonts.robotoRegularBlack,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecorationCustom.getInputDecoration(
                    context: context,
                    labeltext: 'Contraseña',
                    hintext: '*******',
                    prefixicon: const Icon(
                      Icons.lock,
                    ),
                    suffixIcon: IconButton(
                        onPressed: () async {
                          if (authProvider.isVisisblePassword) {
                            authProvider.isVisisblePassword = false;
                          } else {
                            authProvider.isVisisblePassword = true;
                          }
                        },
                        icon: (authProvider.isVisisblePassword)
                            ? const Icon(Icons.visibility)
                            : const Icon(Icons.visibility_off)),
                  ),
                  onChanged: (value) {
                    authProvider.passwordLogin = value;
                  }),
            ),

            //boton de login
            Padding(
              padding: const EdgeInsets.only(
                top: 20,
                bottom: 10,
              ),
              child: ButtonActionWidget(
                function: () async {
                  FocusScope.of(context).unfocus();
                  if (authProvider.isValidateForm()) {
                    loagingProvider.isLoading = true;
                    final identiFormat = CustomFuntions.removeDashes(
                        authProvider.identificationLogin);

                    //peticion al server
                    final authService = Provider.of<OAuthLaravelServices>(
                        context,
                        listen: false);

                    final response = await authService.authUser(
                        identiFormat, authProvider.passwordLogin);

                    await Future.delayed(const Duration(seconds: 2));

                    if (!response.respuesta) {
                      loagingProvider.isLoading = false;
                      ShowSnackBar.showCustomSnackBar(
                          context, response.mensaje);
                      return;
                    }

                    if (context.mounted) {
                      final userService =
                          Provider.of<UsersServices>(context, listen: false);

                      await userService.getUser();

                      final cifradoService =
                          Provider.of<CifradoService>(context, listen: false);

                      await cifradoService.loadCifrado();

                      final pacienteService =
                          Provider.of<PacienteService>(context, listen: false);

                      await pacienteService.getPaciente();

                      authProvider.cleanLogin();

                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MenuComponent(),
                        ),
                      );
                    } else {
                      loagingProvider.isLoading = false;
                      ShowSnackBar.showCustomSnackBar(
                          context, 'Ha ocurrido un error, intente de nuevo.');
                      return;
                    }
                  } else {
                    loagingProvider.isLoading = false;
                    ShowSnackBar.showCustomSnackBar(
                        context, 'información requerida!!');
                  }
                },
                titleButton: 'Iniciar sesión',
              ),
            ),

            ///recuperar contrasena
            Padding(
              padding: const EdgeInsets.only(
                top: 20,
                bottom: 30,
              ),
              child: ButtonActionWidget(
                function: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RecoverPasswordPage()),
                  );
                },
                titleButton: 'Recuperar contraseña',
              ),
            ),
            GestureDetector(
              onTap: () {
                authProvider.isVisisblePassword = true;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const RegisterUserPage()),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '¿No tienes cuenta? ',
                    style: TextStyle(
                      fontFamily: 'Montserrat,SemiBold',
                      color: CustomColors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: MediaQuery.of(context).size.width * 0.038,
                      // Aquí puedes ajustar el tamaño del texto en función del ancho de la pantalla.
                    ),
                  ),
                  Text(
                    ' - Regístrate',
                    style: TextStyle(
                      fontFamily: 'Montserrat,SemiBold',
                      color: CustomColors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.width * 0.040,
                      // Aquí puedes ajustar el tamaño del texto en función del ancho de la pantalla.
                    ),
                  ),
                ],
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(
                  top: 20,
                  bottom: 30,
                ),
                child: Text(
                  version,
                  style: TextStyle(
                    fontFamily: 'Montserrat,SemiBold',
                    color: CustomColors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).size.width * 0.025,
                    // Aquí puedes ajustar el tamaño del texto en función del ancho de la pantalla.
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
