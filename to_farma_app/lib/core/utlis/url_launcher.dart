import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';
import 'package:to_farma_app/core/utlis/utlis.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

/// Esta clase es responsable de lanzar diferentes tipos de URL, como sitios web, números de teléfono, números de WhatsApp, vistas web en la aplicación.
class UrlLauncherCustom {
  static Future<void> openWhatsapp(
      BuildContext context, String whatsapp) async {
    var wpUrl = '${ExternalURLS.urlWhatsapp}$whatsapp&text=${Uri.parse("")}';

    final platform = await GetDeviceInformation.getPlatformName();

    if (await canLaunchUrl(Uri.parse(wpUrl))) {
      await launchUrlString(
        wpUrl,
      );
    } else {
      if (platform == GetDeviceInformation.iosPlaform) {
        Future.microtask(() => showAlertDialog(
            context,
            ExternalURLS.pkgWhatsapp['package']!,
            ExternalURLS.pkgWhatsapp['storeIos']!));
      } else if (platform == GetDeviceInformation.androidPlaform ||
          platform == GetDeviceInformation.googlePlaform) {
        Future.microtask(() => showAlertDialog(
            context,
            ExternalURLS.pkgWhatsapp['package']!,
            ExternalURLS.pkgWhatsapp['storeAndroid']!));
      } else if (platform == GetDeviceInformation.huaweiPlaform) {
        Future.microtask(() => showAlertDialog(
            context,
            ExternalURLS.pkgWhatsapp['package']!,
            ExternalURLS.pkgWhatsapp['storeHuawei']!));
      }
    }
  }

  static void showAlertDialog(
      BuildContext context, String title, String urlStore) {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.confirm,
      barrierDismissible: false,
      title: 'Aviso',
      text: 'Proceda a instalar WhatsApp.',
      confirmBtnText: 'Ir a la tienda',
      cancelBtnText: 'No',
      confirmBtnColor: Colors.green,
      confirmBtnTextStyle: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      customAsset: Assets.logoTofarma,
      onConfirmBtnTap: () async {
        Navigator.of(context).pop();
        await launchUrlString(urlStore);
      },
    );
  }
}
