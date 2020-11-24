import 'dart:async';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:subastaspoli_mobile/src/pages/home_page.dart';
import 'package:subastaspoli_mobile/src/pages/login_v2_page.dart';
import 'package:subastaspoli_mobile/src/pages/puja_page.dart';
import 'package:subastaspoli_mobile/src/utils/dialogs.dart';
import 'package:subastaspoli_mobile/src/utils/session.dart';

class PushNotificationProvider {
  PushNotificationProvider._internal();
  static PushNotificationProvider _instance =
      PushNotificationProvider._internal();
  static PushNotificationProvider get instance => _instance;
  GlobalKey<NavigatorState> _navigatorKey;

  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  final _mensajeStramController = new StreamController<Text>.broadcast();
  Stream<Text> get mensajes => _mensajeStramController.stream;
  final Session _session = new Session();

  initNotifications(GlobalKey<NavigatorState> navigatorKey) {
    _navigatorKey = navigatorKey;
    _firebaseMessaging.requestNotificationPermissions();

    _firebaseMessaging.getToken().then((token) {
      //e4z4Nzu3QfibBMbugHvnvG:APA91bGflHRtbUiqsgFa5_1yo2MVDj37HFOKFyHi4sUwt76XG_EfC6FXp1Rhcqu6LYiW4jG5r4lv7Sp9AJVGLLMGJ4exq4SnPt5R8dPGmnF6GHHXaf4yiqKJBlFBbMCFfEik5Xt5Ls-1
      print("==== FCM TOKEN ==========");
      print(token);
      _session.putEntidadToken(key: "tokenDis", data: token);
    });

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        String argumento = 'no-data';
        if (Platform.isAndroid) {
          argumento = message['data']['puja'] ?? 'no-data';
        }
        final text = Text(
          "Puja Actual $argumento",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w300),
        );
        _mensajeStramController.sink.add(text);
      },
      onBackgroundMessage: myBackgroundMessageHandler,
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        _navigateToItemDetail(message);
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        _navigateToItemDetail(message);
      },
    );
  }

  _navigateToItemDetail(Map<String, dynamic> message) async {
    _session.putEntidad(
        key: "eventoid", id: int.parse(message['data']['idEventos']));
    _session.putEntidad(
        key: "subastaid", id: int.parse(message['data']['idSubastas']));
    _session.putEntidad(
        key: "loteid", id: int.parse(message['data']['idLotes']));

    final dataSession = await _session.get();
    if (dataSession != null &&
        dataSession['idToken'] != null &&
        dataSession['idToken'].toString().isNotEmpty) {
      final isEvento = await _session.getEntidad(key: "eventoid");
      final isSubasta = await _session.getEntidad(key: "subastaid");
      final isLote = await _session.getEntidad(key: "loteid");
      if (isEvento != null && isSubasta != null && isLote != null) {
        final text = Text(
          "Puja Actual ${message['data']['puja']}",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w300),
        );

        _navigatorKey.currentState
            .pushNamed(PujaPage.pageName, arguments: text);
      } else {
        _navigatorKey.currentState.pushNamed(HomePage.pageName);
      }
    } else {
      Dialogs.alertInfo(_navigatorKey.currentContext,
          message: "regístrate o inicia sesión..",
          redirectPageName: LoginV2Page.pageName);
      _session.putEntidad(key: "whereIAmNow", id: 1);
    }
  }

  static Future<dynamic> myBackgroundMessageHandler(
      Map<String, dynamic> message) async {
    if (message.containsKey('data')) {
      // Handle data message
      final dynamic data = message['data'];
    }

    if (message.containsKey('notification')) {
      // Handle notification message
      final dynamic notification = message['notification'];
    }

    // Or do other work.
  }

  dispose() {
    _mensajeStramController?.close();
  }
}
