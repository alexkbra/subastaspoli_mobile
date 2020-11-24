import 'dart:ffi';

import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:subastaspoli_mobile/src/utils/utils.dart';

class SocketClient {
  SocketClient._internal();
  static SocketClient _instance = SocketClient._internal();
  static SocketClient get instance => _instance;

  IO.Socket _socket;

  void connect({String token}) {
    this._socket = IO.io(Utils.sockedHost, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
      //'extraHeaders': {'foo': 'bar'} // optional
      /*'query': {
        "token_id": "123"
      }*/
    });
    this._socket.connect();

    this._socket.on('connection', (_) => {print('connect')});

    this._socket.on('error', (_) => {print(_)});
  }

  void disconnect() {
    this._socket?.disconnect();
  }
}
