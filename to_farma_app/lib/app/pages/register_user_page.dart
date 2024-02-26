import 'package:flutter/material.dart';
import 'package:to_farma_app/app/screens/body_register_user.dart';
import 'package:to_farma_app/app/widgets/widgets.dart';

class RegisterUserPage extends StatelessWidget {
  const RegisterUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    final currentSize = MediaQuery.of(context).size;

    return CustomLoading(
      child: Scaffold(
        appBar: AppbarLogin(
          title: 'Nuevo Usuario',
          showLeftIcon: false,
          height: currentSize.height * 0.15,
        ),
        body: const BodyRegisterUser(),
      ),
    );
  }
}
