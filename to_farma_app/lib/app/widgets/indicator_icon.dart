import 'package:flutter/material.dart';

class IndicatorIcon extends StatelessWidget {
  final String? indicator;

  const IndicatorIcon({Key? key, this.indicator}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String verify = indicator ?? '';

    if (verify.contains('Buenos días') || verify.contains("Mañana")) {
      return const Icon(Icons.sunny, size: 30);
    }
    if (verify.contains('Buenas tardes') || verify.contains("Tarde")) {
      return const Icon(Icons.wb_twighlight, size: 30);
    }

    return const Icon(Icons.dark_mode_rounded, size: 30);
  }
}
