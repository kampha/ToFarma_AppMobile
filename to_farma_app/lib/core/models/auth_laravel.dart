import 'dart:convert';

class OauthToken {
  OauthToken({
    required this.password,
    required this.username,
    this.clientId,
    this.clientSecret,
    this.grantType,
    this.scope,
  });

  String password;
  String username;
  String? clientId;
  String? clientSecret;
  String? grantType;
  String? scope;

  factory OauthToken.fromRawJson(String str) =>
      OauthToken.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OauthToken.fromJson(Map<String, dynamic> json) => OauthToken(
        password: json["password"],
        username: json["username"],
        clientId: json["client_id"],
        clientSecret: json["client_secret"],
        grantType: json["grant_type"],
        scope: json["scope"],
      );

  Map<String, dynamic> toJson() => {
        "password": password,
        "username": username,
        "client_id": clientId,
        "client_secret": clientSecret,
        "grant_type": grantType,
        "scope": scope,
      };
}
