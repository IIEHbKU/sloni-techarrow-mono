import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

@Deprecated("")
class KeycloakLegacy {
  final String baseUrl = dotenv.env['KEYCLOAK_URL'] ?? '';
  final String realm = dotenv.env['REALM'] ?? '';
  final String clientId = dotenv.env['CLIENT_ID'] ?? '';
  final storage = const FlutterSecureStorage();

  Future<Map<String, dynamic>> login(String username, String password) async {
    final response = await http.post(
      Uri.parse("$baseUrl/realms/$realm/protocol/openid-connect/token"),
      headers: {"Content-Type": "application/x-www-form-urlencoded"},
      body: {
        "grant_type": "password",
        "client_id": clientId,
        "username": username,
        "password": password,
        "scope": "openid"
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      await storage.write(key: "access_token", value: data["access_token"]);
      await storage.write(key: "refresh_token", value: data["refresh_token"]);
      await storage.write(
          key: "expires_in", value: data["expires_in"].toString());
      await fetchUserInfo();
      return data;
    } else {
      return jsonDecode(response.body);
    }
  }

  Future<Map<String, String>?> fetchUserInfo() async {
    final url =
        Uri.parse("$baseUrl/realms/$realm/protocol/openid-connect/userinfo");
    print("Bearer ${await storage.read(key: "access_token")}");
    final response = await http.post(url, headers: {
      "Authorization": "Bearer ${await storage.read(key: "access_token")}",
    }, body: {
      "scope": "openid",
      "client_id": clientId,
    });
    if (response.statusCode != 200) {
      return response.headers;
    }
    final data = jsonDecode(response.body);
    await storage.write(key: "user_id", value: data["sub"]);
    await storage.write(key: "username", value: data["preferred_username"]);
    return null;
  }

  Future<Map<String, String>> getUserInfo() async {
    final userId = await storage.read(key: "user_id");
    final username = await storage.read(key: "username");
    if (userId == null || username == null) {
      final data = await fetchUserInfo();
      if (data != null) return {"user_id": "", "username": ""};
      return {"user_id": "", "username": ""};
    }

    return getUserInfo();
  }

  Future<Map<String, dynamic>> registerUser(
      String username, String email, String password) async {
    final response = await http.post(
      Uri.parse("$baseUrl/realms/$realm/protocol/openid-connect/registrations"),
      headers: {"Content-Type": "application/x-www-form-urlencoded"},
      body: {
        "client_id": clientId,
        "username": username,
        "email": email,
        "password": password,
        "response_type": "code"
      },
    );
    print(response.headers["location"]);
    if (response.statusCode != 200) {
      return response.headers;
    }
    print(response.body);
    return jsonDecode(response.body);
  }

  Future<bool> isTokenExpired() async {
    final expiresInStr = await storage.read(key: "expires_in");
    if (expiresInStr == null) return true;
    final expiresIn = int.tryParse(expiresInStr) ?? 0;
    return DateTime.now().millisecondsSinceEpoch >= expiresIn;
  }

  Future<bool> refreshToken() async {
    final refreshToken = await storage.read(key: "refresh_token");
    if (refreshToken == null) return false;

    final response = await http.post(
      Uri.parse("$baseUrl/realms/$realm/protocol/openid-connect/token"),
      headers: {"Content-Type": "application/x-www-form-urlencoded"},
      body: {
        "grant_type": "refresh_token",
        "client_id": clientId,
        "refresh_token": refreshToken
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      await storage.write(key: "access_token", value: data["access_token"]);
      await storage.write(key: "refresh_token", value: data["refresh_token"]);
      return true;
    }
    return false;
  }

  Future<void> logout() async {
    await storage.deleteAll();
  }
}
