import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';
import 'package:to_farma_app/core/utlis/assets.dart';

class TextError extends StatelessWidget {
  final String error;

  const TextError({Key? key, required this.error}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return /*buildButton(
      onTap: () {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.info,
          text: error,
          autoCloseDuration: const Duration(seconds: 5),
        );
      },
      title: 'Información',
      text: error,
      leadingImage: Assets.logoTofarma,
    );*/
        AlertDialog(
            title: RichText(
              text: const TextSpan(
                style: TextStyle(fontSize: 25, color: Colors.black),
                children: [
                  WidgetSpan(
                    child: Padding(
                      padding:
                          EdgeInsets.only(top: 0, bottom: 0, left: 0, right: 0),
                      child: Icon(
                        Icons.info,
                        size: 35,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  TextSpan(text: "Información"),
                ],
              ),
            ),
            content: Text(
              error,
              style: const TextStyle(
                  fontSize: 18, color: Color.fromARGB(255, 90, 90, 90)),
              maxLines: 100,
              overflow: TextOverflow.ellipsis,
            ));
  }

  Card buildButton({
    required onTap,
    required title,
    required text,
    required leadingImage,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      clipBehavior: Clip.antiAlias,
      elevation: 1,
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(
          backgroundImage: AssetImage(
            leadingImage,
          ),
        ),
        title: Text(
          title ?? "",
          style: const TextStyle(fontSize: 25, color: Colors.black),
          maxLines: 100,
        ),
        subtitle: Text(text ?? "",
            style: const TextStyle(
                fontSize: 18, color: Color.fromARGB(255, 90, 90, 90)),
            maxLines: 100),
        trailing: const Icon(
          Icons.keyboard_arrow_right_rounded,
        ),
      ),
    );
  }
}
