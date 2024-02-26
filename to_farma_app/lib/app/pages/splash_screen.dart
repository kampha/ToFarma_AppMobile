import 'package:flutter/material.dart';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:lottie/lottie.dart';
import 'package:to_farma_app/app/pages/pages.dart';
import 'package:to_farma_app/core/utlis/assets.dart';
import 'package:to_farma_app/core/utlis/custom_colors.dart';
import 'package:to_farma_app/version.dart';

class AnimatedSplashScreenCustom extends StatelessWidget {
  const AnimatedSplashScreenCustom({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: _bodySplash(context),
      //backgroundColor: Colors.red,
      splashIconSize: double.infinity,
      nextScreen: const LoginPage(), //mainHiome
      duration: 3500,
      //centered: true,
      curve: Curves.easeInExpo,
      splashTransition: SplashTransition.fadeTransition,
      pageTransitionType: PageTransitionType.leftToRight,
      animationDuration: const Duration(microseconds: 2700),
    );
  }

  Widget _bodySplash(context) {
    final mediaquey = MediaQuery.of(context).size;
    String version = "Versión $versionNameApp";

    return Stack(
      alignment: Alignment.center,
      children: [
        Column(
          children: [
            SizedBox(
              height: mediaquey.height * 0.30,
            ),
            Lottie.asset(Assets.loadingJson, height: 250, width: 250),
          ],
        ),
        Positioned(
            top: mediaquey.height * 0.92,
            child: Center(
                child: Column(children: [
              const Text('ToFarma',
                  style: TextStyle(
                      color: CustomColors.ButtonEnabledAction,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
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
            ]))),
      ],
    );
  }
}
