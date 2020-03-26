
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:youtube_player/youtube_player.dart';

class  Utils{
   static const String sockedHost = '192.168.39.126:8080/websocket';
   //static const String sockedHost = 'ws://10.144.166.3:55544/websocket';
   static const String host = '815f5de4.ngrok.io'; 
   
   static const int port = 80;
   static const String path = '/api'; 
   static const String pageSize = '5';
   static const String scheme = 'http';

   Image imageFromBase64String(String base64String) {
    return Image.memory(base64Decode(base64String), fit: BoxFit.cover);
  }

  Uint8List dataFromBase64String(String base64String) {
    return base64Decode(base64String);
  }

  String base64String(Uint8List data) {
    return base64Encode(data);
  }

  YoutubePlayer videoEvento(String id, BuildContext context) {
    return YoutubePlayer(
      context: context,
      source: id,
      quality: YoutubeQuality.LOWEST,
    );
  }

}