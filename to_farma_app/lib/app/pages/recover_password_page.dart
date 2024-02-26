import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:to_farma_app/app/components/componets.dart';
import 'package:to_farma_app/app/pages/pages.dart';
import 'package:to_farma_app/app/widgets/widgets.dart';
import 'package:to_farma_app/core/models/data.dart';
import 'package:to_farma_app/core/utlis/utlis.dart';

import '../../core/providers/providers.dart';

class RecoverPasswordPage extends StatelessWidget {
  const RecoverPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final currentSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppbarLogin(
        title: 'Recuperar contranseña',
        showLeftIcon: false,
        height: currentSize.height * 0.20,
      ),
      body: _Body(),
    );
  }
}

class _Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final currentSize = MediaQuery.of(context).size;
    final authProvider = Provider.of<AuthUserProvider>(context);
    final loagingProvider = Provider.of<LoadingProviders>(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: currentSize.height * 0.05,
                left: currentSize.width * 0.02,
              ),
              child: Text(
                'Ingrese su correo electrónico registrado.',
                style: TextStyle(
                  fontFamily: 'Montserrat,SemiBold',
                  color: CustomColors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: MediaQuery.of(context).size.width * 0.050,
                  // Aquí puedes ajustar el tamaño del texto en función del ancho de la pantalla.
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 40,
                bottom: 20,
              ),
              child: TextFormField(
                autocorrect: false,
                inputFormatters: <TextInputFormatter>[
                  LengthLimitingTextInputFormatter(40), //cambiar a 11
                  //FilteringTextInputFormatter.allow(),
                ],
                maxLengthEnforcement: MaxLengthEnforcement.enforced,
                style: Fonts.robotoRegularBlack,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecorationCustom.getInputDecoration(
                  context: context,
                  hintext: 'Correo electrónico',
                  prefixicon: const Icon(Icons.email),
                ),
                onChanged: (value) {
                  authProvider.email = value;
                },
                validator: (value) {
                  if (RegularExpressions.regExpEmail.hasMatch(value ?? '')) {
                    return null;
                  }
                  return '';
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 30,
                bottom: 10,
              ),
              child: ButtonActionWidget(
                function: () async {
                  if (authProvider.isValidEmailRecover() &&
                      RegularExpressions.regExpEmail
                          .hasMatch(authProvider.email)) {
                    loagingProvider.isLoading = true;
                    final respuesta =
                        await userGetInfor.recoverPassword(authProvider.email);
                    loagingProvider.isLoading = false;
                    if (respuesta) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ValidatePasswordPage()),
                      );
                    } else {
                      ShowSnackBar.showCustomSnackBar(
                          context, 'Ha ocurrido un error, intente de nuevo.');
                      return;
                    }
                  } else {
                    ShowSnackBar.showCustomSnackBar(context,
                        'Por favor ingresa un correo electrónico válido');
                    return;
                  }
                },
                titleButton: 'Solictar Pin',
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 20,
                bottom: 10,
              ),
              child: ButtonActionWidget(
                function: () async {
                  Navigator.pop(context);
                },
                titleButton: 'Cancelar',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
