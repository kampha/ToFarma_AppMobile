import 'package:flutter/material.dart';
import 'package:to_farma_app/app/widgets/widgets.dart';
import 'package:to_farma_app/app/screens/screen.dart';

class RecipeDetailPage extends StatelessWidget {
  const RecipeDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentSize = MediaQuery.of(context).size;
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;

    final int rmid = arguments["rmid"] ?? 0;
    final String numeroreceta = arguments["numeroreceta"];
    final String hospital = arguments["hospital"];

    return Scaffold(
        appBar: CustomAppBarMenu(
            height: currentSize.height * 0.14,
            menudisplay: false,
            title: 'Recetas Médicas - $numeroreceta'),
        body: BodyRecipeDetail(
            rmid: rmid, numeroreceta: numeroreceta, hospital: hospital));
  }
}
