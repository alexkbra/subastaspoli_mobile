import 'package:flutter_socket_io/flutter_socket_io.dart';
import 'package:flutter_socket_io/socket_io_manager.dart';
import 'package:subastaspoli_mobile/src/utils/utils.dart';

class SocketClient {
  SocketIO socketIO;
  connectSocket01({String token}) {
    //update your domain before using
    socketIO = SocketIOManager().createSocketIO(
        Utils.sockedHost, "/puja",
        query: "access_token="+token, socketStatusCallback: socketStatus);

    //call init socket before doing anything                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        
    
    socketIO.init();

    //subscribe event
    socketIO.subscribe("/topic/puja", _onSocketInfo);

    //connect socket
    socketIO.connect();
  }

  socketStatus() {
    print("Socket status: " );
  }

  subscribes() {
    if (socketIO != null) {
      socketIO.subscribe("/topic/puja", onReceiveChatMessage);
    }
  }

  void onReceiveChatMessage(dynamic message) {
    print("Message from UFO: " + message);
  }

  void sendChatMessage(String msg) async {
    if (socketIO != null) {
      String jsonData = msg;
          
      socketIO.sendMessage("/topic/pujas", jsonData, onReceiveChatMessage);
    }
  }

  destroySocket() {
    if (socketIO != null) {
      SocketIOManager().destroySocket(socketIO);
    }
  }

  _onSocketInfo(dynamic message) {
    print("Message from UFO: " + message);
  }
}
