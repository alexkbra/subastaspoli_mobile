import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:subastaspoli_mobile/src/models/tokenResponse.dart';

class Session {
  static final keySession = "SESSION";
  final storage = new FlutterSecureStorage();

  set({TokenResponse response}) async {
    final data = {
      "idToken": response.idToken,
      "clientStatus": response.clientStatus,
      "createAt": DateTime.now().toString()
    };
    await storage.write(key: keySession, value: jsonEncode(data));
  }

  get() async {
    final result = await storage.read(key: keySession);
    if (result != null) {
      return jsonDecode(result);
    }
    return null;
  }

  putEntidad({String key, int id}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(key, id);
  }

  getEntidad({String key}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.get(key);
  }

  deleteAllEntidad() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  deleteAll() async {
    await storage.deleteAll();
  }
}
