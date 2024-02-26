import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:to_farma_app/app/screens/body_login.dart';
import 'package:to_farma_app/app/widgets/widgets.dart';
import 'package:to_farma_app/core/utlis/utlis.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final currentSize = MediaQuery.of(context).size;

    // final authService = Provider.of<OAuthLaravelServices>(context);
    // authService.authUser('villalobos_055@hotmail.com','124');
    // final userService = Provider.of<UsersServices>(context);
    // userService.getUser();

    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop(); // Cierra la aplicación
        return false;
      },
      child: CustomLoading(
        child: Scaffold(
          appBar: AppbarLogin(
            showiconCenter: true,
            iconCenter: Image.asset(
              Assets.logoTofarma,
              height: 120,
            ),
            title: CustomFuntions.getGreeting(),
            showLeftIcon: true,
            leftIcon: IndicatorIcon(indicator: CustomFuntions.getGreeting()),
            height: currentSize.height * 0.30,
          ),
          body: const BodyLogin(),
        ),
      ),
    );
  }
}
