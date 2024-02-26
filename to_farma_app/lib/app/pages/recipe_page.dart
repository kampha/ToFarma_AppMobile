import 'package:flutter/material.dart';
import 'package:to_farma_app/app/widgets/widgets.dart';
import 'package:to_farma_app/app/screens/screen.dart';

class RecipePage extends StatelessWidget {
  const RecipePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentSize = MediaQuery.of(context).size;

    return Scaffold(
        appBar: CustomAppBarMenu(
            height: currentSize.height * 0.14,
            menudisplay: false,
            title: 'Recetas Médicas'),
        body: const BodyRecipe());
  }
}
