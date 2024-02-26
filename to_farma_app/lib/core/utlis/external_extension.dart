// DOC -> Clase utilizada para registrar todos los URLs externos que abre o empotra la aplicación

class ExternalURLS {

  /// URL WHATSAPP
  static const String urlWhatsapp = 'whatsapp://send?phone=';

  /// URL TELEGRAM
  static const String urlTelegram = 'tg://resolve?domain=';

  /// WHATSAPP
  /// Keys:
  /// - package: nombre del paquete de la aplicación
  /// - storeAndroid: url de la tienda de aplicaciones de Android
  /// - storeIos: url de la tienda de aplicaciones de iOS
  static const Map<String, String> pkgWhatsapp = {
    'package': 'com.whatsapp',
    'storeAndroid':'https://play.google.com/store/apps/details?id=com.whatsapp',
    'storeIos': 'https://apps.apple.com/us/app/whatsapp-messenger/id310633997',
    'storeHuawei': 'https://appgallery.huawei.com/app/C104099818',
  };

  /// TELEGRAM
  /// Keys:
  /// - package: nombre del paquete de la aplicación
  /// - storeAndroid: url de la tienda de aplicaciones de Android
  /// - storeIos: url de la tienda de aplicaciones de iOS
  static const Map<String, String> pkgTelegram = {
    'package': 'org.telegram.messenger',
    'storeAndroid':'https://play.google.com/store/apps/details?id=org.telegram.messenger',
    'storeIos': 'https://apps.apple.com/us/app/telegram-messenger/id686449807',
    'storeHuawei': 'https://appgallery.huawei.com/app/C101184875',
  };

  /// URL FACEBOOK
  /// Keys:
  static const String urlFacebook = 'fb://facewebmodal/f?href=';


  ///Stores App others app
  //static const String storeGooglePlayBcr = "https://play.google.com/store/apps/details?id=bcr.movil";
  //static const String storeAppGalleryBcr = 'appmarket://details?id=bcr.movil';
  //static const String storeAppleBcr = "itms-apps://itunes.apple.com/app/id583646267";

}
