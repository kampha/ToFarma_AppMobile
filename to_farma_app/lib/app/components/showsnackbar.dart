import 'package:flutter/material.dart';
import 'package:to_farma_app/core/utlis/custom_colors.dart';

class ShowSnackBar {
  //mostrar el snackbar
  static void showCustomSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Center(
            child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.info,
              color: Colors.red,
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              message,
              style:
                  const TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
            ),
          ],
        )),
        backgroundColor: CustomColors.ButtonEnabledAction,
        elevation: 10.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        duration: const Duration(seconds: 2),
        padding: const EdgeInsets.all(10.0),
      ),
    );
  }

  static void showCustomSuccess(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Center(
            child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.check,
              color: Colors.green,
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              message,
              style:
                  const TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
            ),
          ],
        )),
        backgroundColor: CustomColors.ButtonEnabledAction,
        elevation: 10.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        duration: const Duration(seconds: 4),
        padding: const EdgeInsets.all(10.0),
      ),
    );
  }
}
