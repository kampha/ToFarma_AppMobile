class NETConfig {
  static const String baseUrl = 'imagebackofficeapi-qbmgqxcnra-uc.a.run.app';
  static const String prefix = 'api';
  static const String version1 = "v1";

  Map<String, String> headerAutenticar(String token) => {
        "Accept": "application/json",
        "Content-Type": "application/json",
        'PlataformToFarma': 'APPMovil',
        'APIToFarma': token,
      };

  Map<String, String> headerSinAutenticar() => {
        "Accept": "application/json",
        "Content-Type": "application/json",
      };
}
