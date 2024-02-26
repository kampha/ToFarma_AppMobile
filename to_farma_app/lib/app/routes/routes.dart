import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:to_farma_app/app/components/menu_home.dart';
import 'package:to_farma_app/app/pages/pages.dart';

class AppRoutes {
  static const initialRoute = 'splash';
  static const loginPageRoute = "loginPage";
  static const shortcuts = "menuHome";
  static PageController controller = PageController();

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      "splash": (context) => const AnimatedSplashScreenCustom(),
      "loginPage": (context) => const LoginPage(),
      "registerUserPage": (context) => const RegisterUserPage(),
      "recoverPage": (context) => const RecoverPasswordPage(),
      "validationPage": (context) => const ValidatePasswordPage(),
      "informationUserPage": (context) => const InformationUserPage(),
      "RecipeDetailPage": (context) => const RecipeDetailPage(),
      "menuHome": (context) => const MenuComponent(),
    };
  }

  static closeApp() {
    SystemNavigator.pop();
  }
}
