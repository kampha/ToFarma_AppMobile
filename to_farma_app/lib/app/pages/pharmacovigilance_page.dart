import 'package:flutter/material.dart';
import 'package:to_farma_app/app/widgets/widgets.dart';
import 'package:to_farma_app/app/screens/screen.dart';

class PharmacovigilancePage extends StatelessWidget {
  const PharmacovigilancePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentSize = MediaQuery.of(context).size;

    return Scaffold(
        appBar: CustomAppBarMenu(
            height: currentSize.height * 0.14,
            menudisplay: false,
            title: 'Farmacovigilancia'),
        body: const BodyPharmacovigilance());
  }
}
