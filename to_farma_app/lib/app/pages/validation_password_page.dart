import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:to_farma_app/app/components/componets.dart';
import 'package:to_farma_app/app/widgets/widgets.dart';
import 'package:to_farma_app/core/utlis/utlis.dart';

class ValidatePasswordPage extends StatelessWidget {
  const ValidatePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final currentSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppbarLogin(
        title: 'Verificación',
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
                keyboardType: TextInputType.number,
                decoration: InputDecorationCustom.getInputDecoration(
                  context: context,
                  hintext: 'pin',
                  prefixicon: const Icon(Icons.pin),
                ),
                onChanged: (value) {
                  //authProvider.email = value;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 10,
                bottom: 20,
              ),
              child: TextFormField(
                autocorrect: false,
                obscureText: true,
                inputFormatters: <TextInputFormatter>[
                  LengthLimitingTextInputFormatter(40), //cambiar a 11
                  //FilteringTextInputFormatter.allow(),
                ],
                maxLengthEnforcement: MaxLengthEnforcement.enforced,
                style: Fonts.robotoRegularBlack,
                keyboardType: TextInputType.text,
                decoration: InputDecorationCustom.getInputDecoration(
                  context: context,
                  hintext: 'contraseña',
                  prefixicon: const Icon(Icons.lock),
                ),
                onChanged: (value) {
                  //authProvider.email = value;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 10,
                bottom: 20,
              ),
              child: TextFormField(
                autocorrect: false,
                obscureText: true,
                inputFormatters: <TextInputFormatter>[
                  LengthLimitingTextInputFormatter(40), //cambiar a 11
                  //FilteringTextInputFormatter.allow(),
                ],
                maxLengthEnforcement: MaxLengthEnforcement.enforced,
                style: Fonts.robotoRegularBlack,
                keyboardType: TextInputType.text,
                decoration: InputDecorationCustom.getInputDecoration(
                  context: context,
                  hintext: 'repiete la contraseña',
                  prefixicon: const Icon(Icons.lock),
                ),
                onChanged: (value) {
                  //authProvider.email = value;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 30,
                bottom: 10,
              ),
              child: ButtonActionWidget(
                function: () async {},
                titleButton: 'Enviar',
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
