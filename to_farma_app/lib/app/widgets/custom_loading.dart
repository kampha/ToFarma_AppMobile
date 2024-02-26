import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:to_farma_app/core/providers/providers.dart';
import 'package:to_farma_app/core/utlis/utlis.dart';

class CustomLoading extends StatelessWidget {
  final Widget child;

  const CustomLoading({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final loagingProvider = Provider.of<LoadingProviders>(context);
    return ValueListenableBuilder(
      valueListenable: ValueNotifier<bool>(loagingProvider.isLoading),
      builder: (context, bool value, __) {
        return Stack(
          children: [
            child,
            if (value) LoadingProgress(),
          ],
        );
      },
    );
  }
}

class LoadingProgress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: Colors.black.withOpacity(0.6),
      child: Center(
        child: Lottie.asset(Assets.loadingJson, height: 250, width: 250),
      ),
    );
  }
}
