import 'package:flutter/material.dart';

import '../../../auth_legacy/keycloak.dart';

class AuthScreenButtonActions {
  static Future<String?> register(String username, String email,
      String password, BuildContext context) async {
    final res = await KeycloakLegacy().registerUser(username, email, password);
    if (res["location"] != null) {
      return res["location"]
          .toString()
          .split("tech/?")
          .last
          .split("realms")
          .first;
    }
    final loginRes = await login(username, password, context);
    if (loginRes != null) return loginRes;
    return null;
  }

  static Future<String?> login(
      String username, String password, BuildContext context) async {
    if (context.mounted == false) return "Context is not mounted";
    final res = await KeycloakLegacy().login(username, password);
    if (res["error_description"] != null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(res["error_description"])));

      return res["error_description"];
    }
    ;
    Navigator.of(context).pushReplacementNamed('/welcome');

    return null;
  }
}
