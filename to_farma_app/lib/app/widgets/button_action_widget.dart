import 'package:flutter/material.dart';
import 'package:to_farma_app/core/utlis/custom_colors.dart';

class ButtonActionWidget extends StatelessWidget {
  final Function() function;
  final String titleButton;

  const ButtonActionWidget({
    super.key,
    required this.function,
    required this.titleButton,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Container(
        height: 45,
        decoration: BoxDecoration(
          color: CustomColors.ButtonEnabledAction,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Center(
          child: Text(
            titleButton,
            style: TextStyle(
              fontFamily: 'Montserrat,SemiBold',
              color: CustomColors.white,
              fontWeight: FontWeight.bold,
              fontSize: MediaQuery.of(context).size.width * 0.042,
              // Aquí puedes ajustar el tamaño del texto en función del ancho de la pantalla.
            ),
          ),
        ),
      ),
    );
  }
}
