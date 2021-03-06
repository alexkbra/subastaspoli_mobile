import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:subastaspoli_mobile/src/models/loginVM.dart';
import 'package:subastaspoli_mobile/src/models/managedUserVM.dart';
import 'package:subastaspoli_mobile/src/models/puja_model.dart';
import 'package:subastaspoli_mobile/src/models/tokenResponse.dart';
import 'package:subastaspoli_mobile/src/utils/dialogs.dart';
import 'package:subastaspoli_mobile/src/utils/session.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:subastaspoli_mobile/src/utils/utils.dart';

class AuthApi {
  final _session = Session();

  Future<bool> register(BuildContext context, ManagedUserVM managerUser) async {
    try {
      //final url = "${AppConfig.apiHost}/register";
      final url = Uri(
          scheme: Utils.scheme,
          host: Utils.host,
          port: Utils.port,
          path: '${Utils.path}/register');

      final json = jsonEncode(managerUser.toJson());
      final map = {"Content-Type": "application/json"};
      final http.Response response =
          await http.post(url, headers: map, body: json);
      if (response.statusCode == 201) {
        return true;
      } else {
        final parsed = jsonDecode(response.body);
        throw PlatformException(
            code: response.statusCode.toString(), message: parsed['detail']);
      }
    } on PlatformException catch (e) {
      Dialogs.alertError(context, message: "Error ${e.code}:${e.message}");
      return false;
    }
  }

  Future<bool> login(BuildContext context, LoginVM login) async {
    TokenResponse resp = null;
    try {
      //final url = "${AppConfig.apiHost}/authenticate";
      final url = Uri(
          scheme: Utils.scheme,
          host: Utils.host,
          port: Utils.port,
          path: '${Utils.path}/authenticate_mobile');

      final json = jsonEncode(login.toJson());
      final map = {"Content-Type": "application/json"};
      final http.Response response =
          await http.post(url, headers: map, body: json);
      if (response.statusCode == 200) {
        resp = TokenResponse.fromJson(jsonDecode(response.body));
        _session.set(response: resp);
        return true;
      } else {
        final parsed = jsonDecode(response.body);
        throw PlatformException(
            code: response.statusCode.toString(), message: parsed['detail']);
      }
    } on PlatformException catch (e) {
      Dialogs.alertError(context, message: "Error ${e.code}:${e.message}");
      return false;
    }
  }

  Future<bool> pujar(BuildContext context, PujaVM puja) async {
    TokenResponse resp = null;
    try {
      final url = Uri(
          scheme: Utils.scheme,
          host: Utils.host,
          port: Utils.port,
          path: '${Utils.path}/pujar');

      final json = jsonEncode(puja.toJson());
      final map = {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${puja.token.toString()}"
      };

      final http.Response response =
          await http.post(url, headers: map, body: json);
      if (response.statusCode == 201) {
        resp = TokenResponse.fromJson(jsonDecode(response.body));
        print("puja realizada");
        return true;
      } else {
        final parsed = jsonDecode(response.body);
        throw PlatformException(
            code: response.statusCode.toString(), message: parsed['detail']);
      }
    } on PlatformException catch (e) {
      Dialogs.alertError(context, message: "Error ${e.code}:${e.message}");
      return false;
    }
  }

  Future<String> pujarInit(PujaVM puja) async {
    String resp = "0.0";
    try {
      final url = Uri(
          scheme: Utils.scheme,
          host: Utils.host,
          port: Utils.port,
          path: '${Utils.path}/pujarInit');

      final json = jsonEncode(puja.toJson());
      final map = {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${puja.token.toString()}"
      };
      final http.Response response =
          await http.post(url, headers: map, body: json);
      if (response.statusCode == 200) {
        resp = response.body;
        return resp;
      } else {
        final parsed = jsonDecode(response.body);
        throw PlatformException(
            code: response.statusCode.toString(), message: parsed['detail']);
      }
    } on PlatformException catch (e) {
      return resp;
    }
  }
}
